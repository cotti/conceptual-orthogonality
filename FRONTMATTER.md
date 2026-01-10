# Frontmatter Templates Reference

This document provides comprehensive templates and documentation for all frontmatter fields available in this Hugo blog.

## Table of Contents

1. [Post Frontmatter](#post-frontmatter)
2. [Page Frontmatter](#page-frontmatter)
3. [Special Pages](#special-pages)
4. [Multilingual Content](#multilingual-content)
5. [Quick Reference](#quick-reference)

---

## Post Frontmatter

Posts are the main content type for blog articles. Create posts using:

```bash
hugo new content post/<post-name>/index.md
```

### Complete Post Template

```yaml
---
# =============================================================================
# REQUIRED FIELDS
# =============================================================================

title: "Your Post Title"
description: "A brief 150-160 character summary for SEO and listings"
date: 2024-01-15T10:00:00-03:00
draft: false

# =============================================================================
# FEATURED IMAGE
# =============================================================================

# Local image (place in same folder as index.md):
image: cover.jpg

# Or external URL:
# image: https://example.com/image.jpg

# =============================================================================
# CATEGORIZATION
# =============================================================================

# Broad categories (1-2 recommended)
categories:
    - Technology
    - Tutorials

# Specific tags (3-7 recommended)
tags:
    - hugo
    - static-site
    - web-development
    - tutorial

# Group into a series
series:
    - Getting Started with Hugo

# =============================================================================
# AUTHOR (for multi-author blogs)
# =============================================================================

author: "Cotti"
# Or multiple authors:
# authors:
#     - "Cotti"
#     - "Guest Author"

# =============================================================================
# CONTENT DISPLAY
# =============================================================================

# Table of contents (overrides global setting)
toc: true

# Math typesetting with KaTeX
math: false

# Reading time display
readingTime: true

# Content license
license: "CC BY-NC-SA 4.0"

# =============================================================================
# VISIBILITY & NAVIGATION
# =============================================================================

# Hide from listings (still accessible via URL)
hidden: false

# Enable/disable comments
comments: true

# Custom URL slug (final URL: /p/<slug>/)
slug: my-custom-slug

# Redirect old URLs to this post
aliases:
    - /old-blog/2023/original-post
    - /p/old-slug/

# =============================================================================
# DATES
# =============================================================================

# Last modification (auto-detected from git if not set)
lastmod: 2024-01-20T15:30:00-03:00

# Future publish date
publishDate: 2024-01-15T10:00:00-03:00

# Expiration date (unpublishes after this)
# expiryDate: 2025-12-31

# =============================================================================
# SEO & ORDERING
# =============================================================================

# SEO keywords (defaults to tags if not set)
keywords:
    - hugo tutorial
    - static site generator

# Manual ordering in listings (lower = higher priority)
# weight: 1
---

Your content here...
```

### Minimal Post Template

```yaml
---
title: "Quick Post Title"
description: "Brief description"
date: 2024-01-15
draft: false
tags:
    - quick-note
---

Content...
```

---

## Page Frontmatter

Pages are standalone content not part of the post stream (About, Contact, etc.).

```bash
hugo new content page/<page-name>/index.md
```

### Complete Page Template

```yaml
---
title: "Page Title"
description: "Page description for SEO"
date: 2024-01-01

# URL configuration
slug: page-url

# Add to navigation menu
menu:
    main:
        weight: -50  # Lower = higher in menu
        params:
            icon: file  # Tabler icon name

# Content options
license: "CC BY-NC-ND"
toc: true
comments: false
hidden: false
---

Page content...
```

### Available Menu Icons

Common Tabler icons for menu items:
- `user` - About pages
- `archives` - Archives
- `search` - Search
- `link` - Links/resources
- `home` - Home
- `mail` - Contact
- `book` - Documentation
- `code` - Code/projects
- `brand-github` - GitHub
- `brand-twitter` - Twitter

Full list: https://tabler-icons.io/

---

## Special Pages

### Archives Page

Displays all posts organized by date.

```yaml
---
title: "Arquivos"  # or "Archives" for English
description: "Todos os posts organizados por data"
date: 2024-01-01
layout: archives
slug: arquivos  # or "archives" for English
menu:
    main:
        weight: -70
        params:
            icon: archive
---
```

### Search Page

Provides full-text search functionality.

```yaml
---
title: "Busca"  # or "Search" for English
description: "Pesquise no blog"
date: 2024-01-01
layout: search
slug: busca  # or "search" for English
outputs:
    - html
    - json  # REQUIRED for search to work
menu:
    main:
        weight: -60
        params:
            icon: search
---
```

### Links Page

Display a collection of links (friends, resources, etc.).

```yaml
---
title: "Links"
description: "Links úteis e amigos"
date: 2024-01-01
layout: links
slug: links
menu:
    main:
        weight: -40
        params:
            icon: link
links:
    - title: "Friend's Blog"
      description: "A great blog about tech"
      website: "https://example.com"
      image: "https://example.com/avatar.jpg"
---
```

---

## Multilingual Content

This blog supports Portuguese (pt-BR) and English (en-US).

### File Naming Convention

- **Portuguese (default)**: `index.md`
- **English**: `index.en.md`

### URL Structure

| Language | Base URL | Example Post |
|----------|----------|--------------|
| Portuguese | `/` | `/p/meu-post/` |
| English | `/en/` | `/en/p/my-post/` |

### Creating Bilingual Content

For a post available in both languages:

```
content/
└── post/
    └── my-post/
        ├── index.md       # Portuguese version
        ├── index.en.md    # English version
        └── cover.jpg      # Shared image
```

### Language-Specific Frontmatter

**Portuguese (`index.md`):**
```yaml
---
title: "Meu Título em Português"
description: "Descrição em português"
date: 2024-01-15
tags:
    - tecnologia
    - tutorial
---
```

**English (`index.en.md`):**
```yaml
---
title: "My English Title"
description: "English description"
date: 2024-01-15
tags:
    - technology
    - tutorial
---
```

---

## Quick Reference

### Essential Fields

| Field | Required | Description |
|-------|----------|-------------|
| `title` | Yes | Content title |
| `date` | Yes | Publication date |
| `draft` | Recommended | Set to `false` to publish |
| `description` | Recommended | SEO summary (150-160 chars) |

### Common Optional Fields

| Field | Default | Description |
|-------|---------|-------------|
| `image` | none | Featured image |
| `tags` | `[]` | Content tags |
| `categories` | `[]` | Content categories |
| `toc` | `true` | Table of contents |
| `comments` | `true` | Enable comments |
| `slug` | filename | Custom URL |

### Date Formats

Hugo accepts multiple date formats:

```yaml
# Full ISO 8601 with timezone
date: 2024-01-15T10:30:00-03:00

# Date only
date: 2024-01-15

# Date and time
date: 2024-01-15 10:30:00

# With timezone name
date: 2024-01-15T10:30:00 America/Sao_Paulo
```

### Content Excerpt

Use `<!--more-->` to define where the excerpt ends:

```markdown
This is the excerpt that appears in listings.

<!--more-->

This is the rest of the content, only visible on the full post page.
```

