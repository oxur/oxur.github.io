---
title: "Progress Update: A Month of Experimentation"
description: Early lessons from building Oxur - S-expressions, REPLs, and the joy of discovery
published_date: 2020-02-11 19:00:00 -0600
layout: post.liquid
tags:
  - oxur
  - progress
  - rust
  - lisp
categories:
  - Project Updates
data:
  read_time: 5
  featured: false
  image: /assets/images/blog/ochre-aurochs.jpg
---

It's been about a month since the first commit, and I wanted to share where things stand with Oxur.

## What's Working

The core S-expression parser is solid. I can parse nested structures, handle quotes, and represent everything as a clean Rust `enum`. The homoiconicity is real - the code you write *is* the data structure you manipulate. There's something deeply satisfying about that.

The REPL exists! It's primitive, but you can define functions, call them, and see results. Logging support is in place, which has been invaluable for debugging the evaluation engine. Every step of parsing and evaluation can be traced.

Most importantly: I've learned a ton about how to get Rust and Lisp evaluation working together. There's a future path where Lisp can interop with Rust seamlessly ...

## The Hard Parts

**Performance vs Interactivity**: The tension I anticipated is real. Interpreted evaluation is wonderfully flexible but slow. Compiling through Rust is fast but destroys the interactive feel. I haven't solved this yet.

**Type System Integration**: Rust's types are *everywhere*, and they want to be checked at compile time. Lisp's dynamic typing wants runtime flexibility. Finding the sweet spot - where we get Rust's safety without losing Lisp's expressiveness - is trickier than I expected. In truth, I want Oxur to be a typed Lisp, so this will be a long, hard road.

**Macro Design**: I want a macro system that can expand to Rust code, but macros-as-functions doesn't quite work. Macros-as-transformers on S-expressions makes more sense, but then how do we ensure they emit valid Rust? This feels like a core design question I haven't cracked yet. And reader macros. Always reader macros. That's going to be a tricky one.

## What I'm Learning

Building a language, even a small one, forces you to make a hundred tiny decisions. Should function names be symbols or strings? How do we handle recursion? What's the scope model? Each choice cascades into others.

The Rust compiler is an incredible teacher. When my code doesn't compile, the error messages usually point directly at the conceptual problem. It's like having a patient mentor who won't let you proceed until you really understand what you're doing.

## Path Forward

I'm going to keep experimenting, but I need to be realistic about time. This is a spare-time project, and life has a way of filling spare time with other things. I'm less interested in building a production-ready system right now than in exploring the design space.

The repository will stay public, code will keep getting pushed (when it happens), but I'm not setting aggressive timelines. The goal is learning and discovery, not shipping v1.0.

If anyone out there is working on similar problems - Lisp/Rust interop, hybrid interpretation/compilation, homoiconic languages that compile - I'd love to connect. Sometimes the best part of working in public is the unexpected conversations.

More updates when there's news worth sharing. Until then: wish me luck!
