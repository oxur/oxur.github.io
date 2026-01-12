---
title: "Oxur Begins: Building a(nother) Lisp for the Rust Ecosystem"
description: A tentative experiment in language design - bringing Lisp's elegance to Rust's performance
published_date: 2020-01-10 09:47:00 -0600
layout: post.liquid
is_draft: true
tags:
  - announcement
  - oxur
  - lisp
  - rust
categories:
  - Project Updates
data:
  read_time: 4
  featured: false
  image: /assets/images/blog/ochre-aurochs.jpg
---

Today marks the beginning of something I've been thinking about for a while: **Oxur**, a Lisp designed to work seamlessly with Rust.

The core idea is simple: what if we could combine Lisp's homoiconicity and interactive development with Rust's performance and type safety? Not a Lisp implemented *in* Rust (there are already several good ones), but a Lisp designed specifically to *interoperate* with Rust code, leverage its ecosystem, and compile to efficient native binaries.

## Why Another Lisp?

Well, the question is really always "Why NOT another Lisp?" Isn't it? Can there ever be too many? *Where there is Lisp, there is Learning!*

In all seriousness, though, I didn't start out trying to -- or even WANTING to -- create another Lisp. I kept searching, delving into source code, hoping that someone in the Rust ecosystem had done for Rust [what Robert Virding did for Erlang](https://github.com/lfe/lfe): give it a Lisp flavour. Sadly, no such gem was anywhere to be found, regardless of the depth of my desires. Which really just left the one alternative.

1. **Rust's ownership model is tastey** - explicit about data flow, favoring immutability, using algebraic types
2. **Modern Lisps often sacrifice interop for purity** - beautiful in isolation, painful to take advantage of existing bodies of work in the hosted language
3. **The challenge of building a great REPL experience** - instant feedback, but with compilation performance when needed? Yes, please.

## First Steps

The initial commit contains experiments with ASTs and S-expressions in Rust. I've been exploring how to represent Lisp forms using Rust's type system - `enum`s make this surprisingly natural. The goal is to make the AST itself manipulable as Lisp data, maintaining homoiconicity while staying close to Rust semantics.

Early experiments with a REPL show promise. The challenge is balancing immediate interpretation (for that instant feedback loop) with eventual compilation (for production performance). We may eventually do a tiered approach - simple expressions evaluate directly, complex code compiles through Rust.

## What's Next

This is very much an experiment. I'm working in the open, learning as I go. Near-term goals:

- Get a basic REPL working with arithmetic and function definitions
- Explore macro systems that can expand to Rust code
- Figure out the FFI story - calling Rust from Oxur should feel natural
- Build enough of the language to write interesting programs

The repository is at [github.com/oxur/oxur](https://github.com/oxur/oxur) if you want to follow along. Fair warning: it's extremely early days, full of half-finished ideas and placeholder code.

If you're interested in Lisps, Rust, language design, or the intersection of all three, I'd love to hear your thoughts. This is going to be a journey of discovery, and I suspect I'll learn as much from missteps as successes.

Let's see where this goes. ...
