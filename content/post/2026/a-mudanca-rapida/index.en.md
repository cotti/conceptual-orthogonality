---
title: "The quick change"
description: "AI is a hard thing to poke with your finger correctly"
date: 2026-01-14T17:17:57-03:00 #current time
draft: false
image: "cover.png"
categories: ["development"]
tags: ["ia", "dev"]
# series: []
# author: ""
# toc: true
# math: false
# readingTime: true
# license: ""

# hidden: false
# comments: true
# slug: ""
# aliases: []

# lastmod: 2026-01-04T02:18:57-03:00
# expiryDate: 2025-12-31
# publishDate: 2026-01-04T02:18:57-03:00

# keywords: []
# weight: 1

# layout: "post"
# type: "post"

---

Lately I've been thinking about this whole *seniority* thing.

Not that I feel like I'm approaching it; quite the opposite.

But about the change that this two-letter thing which is causing things and stuff around is generating in the concept, and in dynamics between Junior and Senior developers.

And the other day I caught myself thinking more about it than I thought I would.

I should note that these musings assume the continued existence of current AI is inevitable, even if there's a bubble to burst. Vibe coding isn't my thing.

## Intern

My first contact with AI helping me solve some sort of problem was in my previous job, still in the telephony field. I had to build a *GUI* with *C#* and *XAML* - using *Avalonia* - with some capabilities that weren't included in the framework. In this case, a tree-based folder and file navigation component with more complex state management. Which items were selected, which weren't, which had certain elements selected... It was tough. Not to mention the potential memory consumption madness. Avalonia 0.10 had some memory management pitfalls, and we already had another library that compromised performance to access and edit Excel spreadsheets. A cursed project.

At times I thought I wouldn't be able to untangle it. But tinkering with the AI ​​of the time, which basically consisted of *Phind* back when it was a free preview and used *GPT 3.5* with a slight modification, I eventually managed to make something that worked. It had its share of bugs that I fixed over time, but it **worked**.

AI ​​then had a tendency to hallucinate much more frequently. And basically knew nothing about Avalonia: it only talked about older versions, with different class architectures, or mixed it with WPF concepts that it happened to know a little better.

In retrospect, there are two important reasons for this:

- Avalonia is a niche framework, and its code was probably not considered for LLM consumption.
- Avalonia's documentation is generally perceived as a weak point, especially back in version 0.10. It's better now, but it's still mentioned as a drawback when compared to its direct competitor, Uno.

It was with this mishmash that I eventually arrived at a usable component.

My senior called GPT the *intern*. Every now and then, especially when something was needed in the front-end, there goes the intern doing something.

But always within that small scope. A piece of the page, few interactions. It was still somewhat as a toy that the intern was effectively hired.

## Junior

I thought I had a general idea of ​​what to recommend to someone who wanted to enter a development career. Try scratching some itches, try using more than one language, try to absorb how it's not so scary to do something you publish on your own, practice, make mistakes until you get it right, bang your head against a problem, don't be afraid to poke things, be curious to ask and find out why.

From a team's point of view, a person in a junior role is also there to learn *by following the breadcrumb trail* of their seniors. To take advantage of the fact that there's always work that consumes more time than the cognition of someone more experienced, to get used to the idea of ​​one day making their own decisions and fighting for them.

But if someone with more experience knows how to write a good prompt, knows how to set limits and requirements clearly, they can make almost any current LLM graduate who is doing well in code more productive than a junior person. **Or even more than that**.

A question I'm immensely curious to find an answer to: How do you define a general case where this can be reconciled? Is it even possible?

## Mid-Level

The so-called "danger" is no longer limited to the previous levels. Opus 4.5, for example, implements complete functionalities given a good prompt. Mid-Level is a position that I see as somewhat out of the ordinary outside of Brazil, but it represents a relevant middle ground. It is here that the role of task delegation becomes a little better understood.

In this sense, I consider a position at this level "as safe as before." In general, a person with the average skill expected for this level already knows how to make adequate limitations to delegate a small, functional task that works here and there.

## Senior and Beyond

The most senior thing I've ever done was quite recent.

There was a feature being implemented that technically falls under my name, but someone with less experience developing in the codebase in question went ahead and started implementing it, making considerable use of LLM.

My role was primarily to let someone else work on something I know I could do better if I had the time. I reviewed, suggested, blocked, resolved conflicts. Eventually, I'll tweak it to fit with the rest of the code, but what's there works.

As much as I reviewed more AI-generated code, the process of defining what should be created was done from the perspective of someone with a correct understanding of what should ultimately happen. So I also reviewed whether the idea behind the implementation sounded right, and it did.

## The Pachyderm in the Room

All these questions arise oblivious to the damage outside the field. I also wonder what role these external circumstances will play when some kind of mitigation measure is needed, whether for environmental, social, or both types of damage, or other options.

There's even a discussion about calling AI a "tool" versus its conception having changed the course of the industry. Why not both? Even if the famous bubble bursts, what exists now is here to stay, and it will not only influence the sector but also... it already does.

I was a junior and I want to help others, but it's an **owl situation**. Opening up ye olde GPT is *drawing a circle*. Getting it to do what you want properly is *drawing the rest of the owl*. Without the benefit of seeing things from the perspective of experience, it's difficult to express how important it is to do things the way they were done in the old days – **4 years ago** – at least until you have a general idea of ​​how many different ways you can shoot yourself in the foot.
