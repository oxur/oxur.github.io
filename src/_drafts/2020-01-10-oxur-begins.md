---
title: "Oxur Begins: Building a Lisp for the Rust Ecosystem"
description: Announcing a new experiment in language design - bringing Lisp's elegance to Rust's performance
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
---

Today marks the beginning of something I've been thinking about for a while: **Oxur**, a Lisp designed to work seamlessly with Rust.

The core idea is simple: what if we could combine Lisp's homoiconicity and interactive development with Rust's performance and type safety? Not a Lisp implemented *in* Rust (there are already several good ones), but a Lisp designed specifically to *interoperate* with Rust code, leverage its ecosystem, and compile to efficient native binaries.

## Why Another Lisp?

Fair question. The Lisp family tree is already extensive. But I keep coming back to a few observations:

1. **Rust's ownership model is actually quite Lispy** - explicit about data flow, favoring immutability, using algebraic types
2. **Modern Lisps often sacrifice interop for purity** - beautiful in isolation, painful in practice
3. **The REPL experience can be so much better** - instant feedback, but with compilation performance when needed

## First Steps

The initial commit contains experiments with ASTs and S-expressions in Rust. I've been exploring how to represent Lisp forms using Rust's type system - `enum`s make this surprisingly natural. The goal is to make the AST itself manipulable as Lisp data, maintaining homoiconicity while staying close to Rust semantics.

Early experiments with a REPL show promise. The challenge is balancing immediate interpretation (for that instant feedback loop) with eventual compilation (for production performance). I'm thinking about a tiered approach - simple expressions evaluate directly, complex code compiles through Rust.

## What's Next

This is very much an experiment. I'm working in the open, learning as I go. Near-term goals:

- Get a basic REPL working with arithmetic and function definitions
- Explore macro systems that can expand to Rust code
- Figure out the FFI story - calling Rust from Oxur should feel natural
- Build enough of the language to write interesting programs

The repository is at github.com/oxur/oxur if you want to follow along. Fair warning: it's extremely early days, full of half-finished ideas and placeholder code.

If you're interested in Lisps, Rust, language design, or the intersection of all three, I'd love to hear your thoughts. This is going to be a journey of discovery, and I suspect I'll learn as much from missteps as successes.

Let's see where this goes.
