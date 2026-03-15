#!/usr/bin/env bash
# bluesky-post.sh — Post new blog articles to Bluesky and update frontmatter with the AT URI.
# Runs in GitHub Actions CI. Requires: curl, jq, imagemagick (for large cover images).
set -uo pipefail

# ─── Configuration ───────────────────────────────────────────────────────────

BLUESKY_HANDLE="${BLUESKY_HANDLE:?Missing BLUESKY_HANDLE secret}"
BLUESKY_APP_PASSWORD="${BLUESKY_APP_PASSWORD:?Missing BLUESKY_APP_PASSWORD secret}"
PDS_HOST="https://bsky.social"
COMPARE_REF="${GITHUB_BEFORE:-HEAD~1}"
POSTS_UPDATED=0

# Handle initial push (all-zero ref)
if [ "$COMPARE_REF" = "0000000000000000000000000000000000000000" ]; then
    COMPARE_REF="HEAD~1"
fi

# ─── Dependency check ────────────────────────────────────────────────────────

for cmd in curl jq hugo; do
    command -v "$cmd" &>/dev/null || { echo "::error::$cmd is required but not installed"; exit 1; }
done

# Determine ImageMagick command (IM7: magick, IM6: convert)
MAGICK_CMD=""
if command -v magick &>/dev/null; then
    MAGICK_CMD="magick"
elif command -v convert &>/dev/null; then
    MAGICK_CMD="convert"
else
    echo "::warning::ImageMagick not found — large cover images will not be resized"
fi

# ─── Helper: extract value from YAML frontmatter string ──────────────────────

get_value() {
    local yaml="$1"
    local key="$2"
    local raw
    raw=$(echo "$yaml" | grep "^${key}:" | head -1) || true
    [ -z "$raw" ] && return 1

    # Remove key: prefix
    raw="${raw#"${key}:"}"
    # Trim leading whitespace
    raw="$(echo "$raw" | sed 's/^[[:space:]]*//')"

    # Double-quoted value
    if [[ "$raw" == \"* ]]; then
        echo "$raw" | sed 's/^"//;s/".*//'
        return 0
    fi

    # Single-quoted value
    if [[ "$raw" == \'* ]]; then
        echo "$raw" | sed "s/^'//;s/'.*//"
        return 0
    fi

    # Unquoted: strip trailing YAML comment and whitespace
    echo "$raw" | sed 's/[[:space:]]*#.*$//;s/[[:space:]]*$//'
}

# ─── Helper: extract frontmatter (lines between first pair of ---) ───────────

extract_frontmatter() {
    awk '/^---[[:space:]]*$/ { count++; next } count == 1 { print }' "$1"
}

# ─── Helper: insert bluesky_comment_uri into frontmatter ─────────────────────

update_frontmatter() {
    local file="$1"
    local uri="$2"
    awk -v uri="$uri" '
        BEGIN { delim = 0 }
        /^---[[:space:]]*$/ {
            delim++
            if (delim == 2) {
                printf "bluesky_comment_uri: \"%s\"\n", uri
            }
        }
        { print }
    ' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
}

# ─── Helper: resize image if over 1 MB ───────────────────────────────────────

prepare_image() {
    local src="$1"
    local max_size=1000000  # 1 MB

    local file_size
    file_size=$(stat -c%s "$src" 2>/dev/null || stat -f%z "$src" 2>/dev/null || echo 0)

    if [ "$file_size" -le "$max_size" ]; then
        echo "$src"
        return 0
    fi

    if [ -z "$MAGICK_CMD" ]; then
        echo "::warning::Cover image $(basename "$src") is ${file_size} bytes (>1 MB) but ImageMagick is unavailable"
        echo "$src"
        return 0
    fi

    echo "Cover image $(basename "$src") is ${file_size} bytes, resizing..." >&2
    local out="/tmp/bsky_cover_$(basename "$src" | sed 's/\.[^.]*$//').jpg"
    local quality=85

    $MAGICK_CMD "$src" -resize '1200x630>' -quality "$quality" "$out"
    file_size=$(stat -c%s "$out" 2>/dev/null || stat -f%z "$out" 2>/dev/null || echo 0)

    while [ "$file_size" -gt "$max_size" ] && [ "$quality" -gt 30 ]; do
        quality=$((quality - 10))
        $MAGICK_CMD "$src" -resize '1200x630>' -quality "$quality" "$out"
        file_size=$(stat -c%s "$out" 2>/dev/null || stat -f%z "$out" 2>/dev/null || echo 0)
    done

    echo "Resized to ${file_size} bytes (quality=${quality})" >&2
    echo "$out"
}

# ─── Helper: detect MIME type from extension ──────────────────────────────────

mime_type_for() {
    case "${1,,}" in
        *.jpg|*.jpeg) echo "image/jpeg" ;;
        *.png) echo "image/png" ;;
        *.webp) echo "image/webp" ;;
        *) echo "application/octet-stream" ;;
    esac
}

# ─── Post to Bluesky and return the AT URI ────────────────────────────────────

create_bluesky_post() {
    local url="$1"
    local lang="$2"        # pt-BR or en-US
    local title="$3"
    local cover_path="$4"  # may be empty

    # Build post text
    local blog_name alt_text
    if [ "$lang" = "pt-BR" ]; then
        blog_name="Ortogonalidade Conceitual"
        alt_text="Post \"${title}\" no blog chamado Ortogonalidade Conceitual"
    else
        blog_name="Conceptual Orthogonality"
        alt_text="\"${title}\" post at the blog titled Conceptual Orthogonality"
    fi

    local text
    text=$(printf '%s: %s\n(%s)' "$blog_name" "$title" "$url")

    # Compute byte offsets for the URL facet
    # The URL sits at: "{blog_name}: {title}\n({url})"
    # byte_start = bytes of "{blog_name}: {title}\n(" and byte_end = byte_start + bytes of url
    local prefix_bytes url_bytes
    prefix_bytes=$(printf '%s: %s\n(' "$blog_name" "$title" | wc -c)
    url_bytes=$(printf '%s' "$url" | wc -c)
    local byte_start=$prefix_bytes
    local byte_end=$((byte_start + url_bytes))

    # Build the embed (image or none)
    local embed_json="null"
    if [ -n "$cover_path" ] && [ -f "$cover_path" ]; then
        # Resize if needed
        local upload_path
        upload_path=$(prepare_image "$cover_path")

        local mime
        mime=$(mime_type_for "$upload_path")

        # Upload blob
        local blob_response
        blob_response=$(curl -sf -X POST "${PDS_HOST}/xrpc/com.atproto.repo.uploadBlob" \
            -H "Authorization: Bearer ${ACCESS_JWT}" \
            -H "Content-Type: ${mime}" \
            --data-binary @"${upload_path}") || {
            echo "::warning::Failed to upload cover image for ${url}" >&2
            blob_response=""
        }

        if [ -n "$blob_response" ]; then
            local blob_ref
            blob_ref=$(echo "$blob_response" | jq '.blob')

            # Get actual image dimensions for aspect ratio (if identify is available)
            local img_w=1200 img_h=630
            if command -v identify &>/dev/null; then
                img_w=$(identify -format "%w" "$upload_path" 2>/dev/null || echo 1200)
                img_h=$(identify -format "%h" "$upload_path" 2>/dev/null || echo 630)
            fi

            embed_json=$(jq -n \
                --arg alt "$alt_text" \
                --argjson blob "$blob_ref" \
                --argjson w "$img_w" \
                --argjson h "$img_h" \
                '{
                    "$type": "app.bsky.embed.images",
                    "images": [{
                        "alt": $alt,
                        "image": $blob,
                        "aspectRatio": { "width": $w, "height": $h }
                    }]
                }')
        fi
    fi

    # Build the record JSON
    local record
    record=$(jq -n \
        --arg text "$text" \
        --arg created "$(date -u +%Y-%m-%dT%H:%M:%S.000Z)" \
        --arg lang "$lang" \
        --argjson byteStart "$byte_start" \
        --argjson byteEnd "$byte_end" \
        --arg url "$url" \
        --argjson embed "$embed_json" \
        '{
            "$type": "app.bsky.feed.post",
            "text": $text,
            "createdAt": $created,
            "langs": [$lang],
            "facets": [{
                "index": { "byteStart": $byteStart, "byteEnd": $byteEnd },
                "features": [{ "$type": "app.bsky.richtext.facet#link", "uri": $url }]
            }]
        }
        | if $embed != null then . + { "embed": $embed } else . end')

    # Create the post
    local response
    response=$(curl -sf -X POST "${PDS_HOST}/xrpc/com.atproto.repo.createRecord" \
        -H "Authorization: Bearer ${ACCESS_JWT}" \
        -H "Content-Type: application/json" \
        -d "$(jq -n \
            --arg repo "$DID" \
            --arg collection "app.bsky.feed.post" \
            --argjson record "$record" \
            '{ "repo": $repo, "collection": $collection, "record": $record }')") || {
        echo "::error::Failed to create Bluesky post for ${url}" >&2
        return 1
    }

    local uri
    uri=$(echo "$response" | jq -r '.uri')
    if [ -z "$uri" ] || [ "$uri" = "null" ]; then
        echo "::error::Bluesky API did not return a URI for ${url}" >&2
        echo "Response: ${response}" >&2
        return 1
    fi

    echo "$uri"
}

# ─── Process a single content file ───────────────────────────────────────────

process_file() {
    local file="$1"

    # Only process index.md or index.en.md
    if ! [[ "$file" =~ index(\.en)?\.md$ ]]; then
        return 0
    fi

    echo "Processing: $file"

    # Extract frontmatter
    local fm
    fm=$(extract_frontmatter "$file")

    # Skip drafts
    local draft
    draft=$(get_value "$fm" "draft") || true
    if [ "$draft" = "true" ]; then
        echo "  Skipping (draft)"
        return 0
    fi

    # Skip if already has bluesky_comment_uri
    if echo "$fm" | grep -q "^bluesky_comment_uri:"; then
        echo "  Skipping (already has bluesky_comment_uri)"
        return 0
    fi

    # Extract metadata
    local title image
    title=$(get_value "$fm" "title") || { echo "  Skipping (no title)"; return 0; }
    image=$(get_value "$fm" "image") || true

    # Look up the permalink from hugo list all (populated before this function runs)
    # Extract URL by pattern rather than field index — safe even if title contains commas
    local url
    url=$(echo "$HUGO_URLS" | grep "^${file}," | grep -o 'https://[^,]*')
    if [ -z "$url" ]; then
        echo "  Skipping (not found in hugo list all — may be future-dated or excluded)"
        return 0
    fi

    # Determine language
    local lang
    if [[ "$file" == *index.en.md ]]; then
        lang="en-US"
    else
        lang="pt-BR"
    fi

    # Resolve cover image path
    local cover_path=""
    if [ -n "$image" ]; then
        cover_path="$(dirname "$file")/${image}"
        if [ ! -f "$cover_path" ]; then
            echo "  Warning: cover image not found at ${cover_path}"
            cover_path=""
        fi
    fi

    echo "  Title: ${title}"
    echo "  URL:   ${url}"
    echo "  Lang:  ${lang}"
    echo "  Cover: ${cover_path:-none}"

    # Post to Bluesky
    local at_uri
    at_uri=$(create_bluesky_post "$url" "$lang" "$title" "$cover_path") || {
        echo "  FAILED to post to Bluesky"
        return 1
    }

    echo "  Bluesky URI: ${at_uri}"

    # Update frontmatter
    update_frontmatter "$file" "$at_uri"
    POSTS_UPDATED=$((POSTS_UPDATED + 1))
    echo "  Frontmatter updated"
}

# ═════════════════════════════════════════════════════════════════════════════
# MAIN
# ═════════════════════════════════════════════════════════════════════════════

echo "=== Bluesky Post Script ==="
echo "Compare ref: ${COMPARE_REF}"

# ─── Step 1: Find new/modified post files ─────────────────────────────────────

NEW_FILES=$(git diff --name-only --diff-filter=AM "${COMPARE_REF}" HEAD -- 'content/post/' 2>/dev/null || echo "")

if [ -z "$NEW_FILES" ]; then
    echo "No new post files detected."
    exit 0
fi

echo "New/modified files:"
echo "$NEW_FILES" | sed 's/^/  /'

# ─── Step 2: Get canonical URLs from Hugo ────────────────────────────────────

echo ""
echo "Resolving permalinks via hugo list all..."
HUGO_URLS=$(hugo list all 2>/dev/null)
if [ -z "$HUGO_URLS" ]; then
    echo "::error::hugo list all returned no output"
    exit 0
fi

# ─── Step 3: Authenticate with Bluesky ───────────────────────────────────────

echo ""
echo "Authenticating with Bluesky..."

SESSION=$(curl -sf -X POST "${PDS_HOST}/xrpc/com.atproto.server.createSession" \
    -H "Content-Type: application/json" \
    -d "$(jq -n --arg id "$BLUESKY_HANDLE" --arg pw "$BLUESKY_APP_PASSWORD" \
        '{ "identifier": $id, "password": $pw }')") || {
    echo "::error::Failed to authenticate with Bluesky. Check BLUESKY_HANDLE and BLUESKY_APP_PASSWORD secrets."
    exit 0  # Don't block the deploy
}

ACCESS_JWT=$(echo "$SESSION" | jq -r '.accessJwt')
DID=$(echo "$SESSION" | jq -r '.did')

if [ -z "$ACCESS_JWT" ] || [ "$ACCESS_JWT" = "null" ]; then
    echo "::error::Bluesky authentication failed (no access token in response)"
    exit 0  # Don't block the deploy
fi

echo "Authenticated as ${DID}"

# ─── Step 4: Process each file ────────────────────────────────────────────────

echo ""
while IFS= read -r file; do
    [ -z "$file" ] && continue
    echo "---"
    process_file "$file" || echo "::warning::Failed to process ${file}, continuing..."
done <<< "$NEW_FILES"

# ─── Step 5: Commit and push if any posts were updated ────────────────────────

echo ""
echo "=== Summary: ${POSTS_UPDATED} post(s) updated ==="

if [ "$POSTS_UPDATED" -gt 0 ]; then
    echo "Committing frontmatter changes..."
    git config user.name "github-actions[bot]"
    git config user.email "github-actions[bot]@users.noreply.github.com"
    git add content/
    git commit -m "ci: add Bluesky comment URIs for new posts"
    if git push; then
        echo "Changes pushed."
    else
        echo "::warning::git push failed (frontmatter changes exist only in this build)"
    fi
fi

echo "Done."
