---
title: "Oxur Returns: Five Years Later, With Fresh Eyes"
description: Resuming work on Oxur after a long break - new perspectives, mature tooling, and clearer vision
published_date: 2025-12-26 12:00:00 -0600
layout: post.liquid
is_draft: true
tags:
  - announcement
  - oxur
  - rust
  - lisp
  - treebeard
categories:
  - Project Updates
data:
  read_time: 6
  featured: true
---

Five years. That's how long it's been since I put Oxur on hiatus. Over the holidays, I dusted off the code, read through the old commits, and felt that familiar spark: *this is still interesting*.

But I'm not resuming where I left off. Too much has changed - both in the Rust ecosystem and in my understanding of language design. This isn't a continuation; it's a reboot with lessons learned.

## What Changed

**The Rust ecosystem matured dramatically.** In 2020, building language tools meant rolling your own parser infrastructure and fighting with half-finished crates. In 2025, we have battle-tested libraries: `syn` for Rust AST manipulation, `ratatui` for polished TUIs, `reedline` for sophisticated REPL input. The foundation is solid now.

**I understand the problem better.** Five years ago, I was trying to build "Lisp for Rust" without really knowing what that meant. Now, after years of writing both Lisp and Rust professionally, I see the design space more clearly. The goal isn't Lisp-in-Rust (done many times) or Rust-with-parentheses (pointless). It's something more specific: **a homoiconic language that compiles to Rust and integrates seamlessly with its ecosystem**.

**The project needs structure.** 2020's Oxur was one crate, a jumble of experiments. 2025's Oxur is organized: `oxur-core` for fundamentals, `oxur-parse` for S-expressions, `oxur-comp` for compilation, `oxur-ast` for Rust AST manipulation, `oxur-repl` for the interactive environment. Separation of concerns makes everything clearer.

## What We've Built (So Far)

The past 24 hours of winter break hacking produced:

- **Logo designs** - Visual identity matters, even for programming languages
- **Project structure** - Cargo workspace with clear crate boundaries
- **Design documentation system** - Using my `oxur-odm` tool to manage design docs like Rust's RFCs
- **Initial architecture** - Outlined the compilation pipeline from S-expressions → Core Forms → Oxur AST → `syn` → Rust source

That last piece is crucial. I finally understand the right abstraction layers:

1. **Surface Forms** - The ergonomic Lisp you write, with macros and sugar
2. **Core Forms** - A minimal, stable IR that macros expand to
3. **Oxur AST** - Rust concepts (Items, Exprs, Stmts) in S-expression form
4. **syn AST** - The standard Rust AST library
5. **Rust Source** - Pretty-printed code that goes to `rustc`

This pipeline solves problems that stumped me five years ago. The Core Forms layer gives us LFE-style stability - the front-end (Oxur syntax) can evolve independently from the back-end (Rust codegen). The Oxur AST layer protects us from `syn` API changes while keeping everything inspectable as S-expressions.

## Introducing Treebeard

Here's the exciting part: alongside Oxur, I'm building **Treebeard** - a tree-walking interpreter for Oxur code. Named after Tolkien's wise Ent (slow, deliberate, thoughtful), Treebeard will execute Oxur directly without compilation.

Why both a compiler AND an interpreter?

**Different execution strategies for different needs:**

- **Treebeard** (~1-5ms): Interpret Core Forms directly, perfect for REPL experimentation
- **Fast compilation** (~50-100ms): Quick Rust codegen for testing
- **Optimized compilation** (~50-300ms): Production-ready binaries

The key insight: Core Forms work as BOTH a compilation IR AND an interpreted bytecode format. One language, multiple execution strategies.

This solves the performance-vs-interactivity tension that plagued 2020's design. Variables can live in Treebeard's environment, persisting across REPL interactions. When you need speed, compile seamlessly. When you need flexibility, interpret. The user chooses based on their workflow.

## What's Next

I'm being realistic this time. This is still a side project, still experimental, still uncertain. But the foundation feels right in a way 2020's didn't.

Near-term focus:

- Get Treebeard interpreting basic Core Forms
- Implement the full compilation pipeline
- Build a polished REPL using modern TUI crates
- Document the design through blog posts (learning in public worked well before)

I'm working in two-week sprints during time off. The goal isn't a releasable language - it's exploring the design space with better tools and clearer vision.

## Join the Journey

The repository is at github.com/oxur/oxur (cleaned up, reorganized, active again). Development logs will appear here as blog posts. Design documents are in the repo's `design/` directory.

If you're interested in:
- Lisp/Rust interop and hybrid compilation/interpretation
- Homoiconic languages with static type systems
- Modern language tooling and REPL design
- Tree-walking interpreters vs JIT compilers

...then follow along! This iteration of Oxur is informed by five years of learning, a mature ecosystem, and the wisdom to focus on core problems rather than everything at once.

It's good to be back. Let's see what we can build.
