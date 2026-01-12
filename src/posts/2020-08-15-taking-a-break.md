---
title: "Taking a Break: Oxur on Hiatus"
description: Pausing development to focus on other priorities - the journey continues, just not right now
published_date: 2020-08-15 10:00:00 -0600
layout: post.liquid
tags:
  - announcement
  - oxur
categories:
  - Project Updates
data:
  read_time: 3
  featured: false
---

A brief update: I'm putting Oxur on hiatus for the foreseeable future.

## Why?

Time, mainly. The initial burst of energy that carried me through those early commits has been redirected to more immediate priorities - work, family, life; the usuals. Building a programming language, even a small one, requires sustained focus and deep thinking. And a small team. Right now, I don't have either.

This isn't a declaration of failure or abandonment. It's recognition that side projects have seasons, and this one's season has passed for now.

## What I Learned

The month+ of active work taught me more than I expected:

- **Rust is an excellent language for language implementation** - the type system catches so many bugs that would be subtle runtime errors elsewhere
- **Lisp semantics are beautifully simple** - but the simplicity hides deep design questions about evaluation, scope, and interop
- **REPLs are harder than they look in a memory safe, statically compiled language** - the read-eval-print loop sounds straightforward until you implement it

Building a language solo is a marathon, not a sprint. The initial exploration phase is exhilarating - every commit adds visible functionality. But then you hit the "trough of sorrow" where the next features require solving hard, interconnected problems. That's where I am now, and that's where I need to pause.

## What's Next?

The repository stays public. The code remains MIT licensed. If anyone wants to fork it, experiment with the ideas, or take it in completely different directions - please do! Some of the S-expression parsing code might be useful to others, even if the larger Oxur vision remains incomplete.

I may return to this project when circumstances change. The problems I was exploring - hybrid interpretation/compilation, Lisp/Rust interop, homoiconic languages with static guarantees - still fascinate me. But for now, they'll have to wait.

To anyone who followed along, starred the repo, or sent encouraging messages: thank you. Working in public, even on something this experimental, was valuable precisely because it wasn't solitary.

Until we meet again: keep making interesting things. The world needs more weird programming languages, more experiments at the boundaries of what's possible, more people willing to try and learn and share.

Oxur will be here when I return.
