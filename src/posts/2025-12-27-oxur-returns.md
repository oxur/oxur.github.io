---
title: "Oxur Returns: Five Years Later, With Fresh Horns"
description: Resuming work on Oxur after a long break - new perspectives, mature tooling, and clearer vision
published_date: 2025-12-27 12:00:00 -0600
layout: post.liquid
tags:
  - announcement
  - oxur
  - rust
  - lisp
categories:
  - Project Updates
data:
  read_time: 6
  featured: true
  image: /assets/images/blog/ruxxy.png
---

Five years. That's how long it's been since I put Oxur on hiatus. Over the holidays, I dusted off the code, read through the old commits, and felt that familiar spark: *this is still interesting*.

But I'm not resuming where I left off. Too much has changed - both in the Rust ecosystem and in my clarity of language design for a compiled, typed Lisp. This isn't a continuation; it's a reboot with lessons learned.

## What Changed

**The Rust ecosystem matured dramatically.** In 2020, building language tools meant rolling your own parser infrastructure and fighting with half-finished crates. In 2025, we have battle-tested libraries: `syn` for Rust AST manipulation, `ratatui` for polished TUIs, `reedline` for sophisticated REPL input. The foundation is solid now.

**I understand the problem better.** Five years ago, I was trying to build "Lisp for Rust" without really knowing what that meant. Now, after five more years of programming in Go, Rust and Lisp -- and after returning to another Lisp effort (ZYLISP, written on Go), I see the design space *much* more clearly. The goal isn't Lisp-in-Rust (done many times) or Rust-with-parentheses (pointless). It's something more specific: **a homoiconic language that compiles to Rust and integrates seamlessly with its ecosystem**.

**The project needs structure.** 2020's Oxur was one crate, a jumble of experiments. 2025's Oxur is organized: `oxur-ast` for conversion between Oxur's AST (s-expression forms of the syn Rust AST), Rust AST (syn), and Rust source files; `oxur-comp` for the multi-stage compile chain; `oxur-lang` for Oxur macros, core forms, etc.; and `oxur-repl` for the interactive environment. Separation of concerns makes everything clearer.

## What We've Built (So Far)

The past few days of winter break hacking produced:

- **Design documentation system** - Using `oxur-oxd` docs tool to manage design docs like Rust's RFCs (update: we later renamed this to oxur-odm, document management)
- **Initial architecture** - Outlined the compilation pipeline from S-expressions → Core Forms → Oxur AST → `syn` → Rust source
- **Project structure** - Cargo workspace with clear crate boundaries
- **Tooling** - Just the beginnings, but it's already making a big impact on productivity
- **Logo designs** - Visual identity matters, even for programming languages

We're going to be looking along these sorts of lines in the coming weeks:

1. **Surface Forms** - The ergonomic Lisp you write, with macros and sugar
2. **Core Forms** - A minimal, stable IR that macros expand to
3. **Oxur AST** - Rust concepts (Items, Exprs, Stmts) in S-expression form
4. **syn AST** - The standard Rust AST library
5. **Rust Source** - Pretty-printed code that goes to `rustc`

This pipeline solves problems that stumped me five years ago. The Core Forms layer gives us LFE-style stability - the front-end (Oxur syntax) can evolve independently from the back-end (Rust codegen). The Oxur AST layer protects us from `syn` API changes while keeping everything inspectable as S-expressions. My time spent on LFE over the past 14 years, and my work on the [ZYLISP project](https://github.com/zylisp/design/blob/main/00-index.md) *really* helped push the vision forward in all these areas.

## AI and Language Aside

It's interesting to note that five years ago I was working on both a Go-based Lisp and a Rust-based one, that for each the aim was full host language interop. The return to both in 2025 was no accident, either: one of the reasons I had to stop working on those projects originally was not having a team to help build. 2025 was the year of Claude.ai -- many of us in the software engineering and programming language communities had been very strong opponents to AI in 2024. The output was pure garbage. Claude.ai changed all that -- not overnight, but quickly enough (and with enough qualtiy) that those of us who were holdouts against the wave become die-hard surfers and lifeguards :-) Now I have the team. I can build the Lisp I had envisioned.

The next question for me was "Since I can't do both, where do I want to put my focus? Go or Rust?" I definitely enjoy writing Rust more, but there are some serious benefits to Go. One of the biggies that my coworkers and I discovered throughout the year was how good a language it was for AI. I have done hands-on comparisons between Go, C/C++, Python, Ruby, Erlang, LFE, Java, JavaScript, TypeScript, Fortran, Racket, and more: Go beat them all for consistently higher quality. I lay this success at the feet of several responsible parties:

- language tooling
- static typing
- generally better than average code examples online (so pretty good corpora for training language models)

It wasn't until very later in the year that I started experimenting with AI and Rust. And wow. Just. Wow. And I thought *Go* had been a good fit for AI! Rust beat it hands-down:

- better tooling
- unbelievably high quality of documentation (which is oddly easy to overlook until your AI depends upon it to do anything *remotely* correct!)
- much more rigorous typing than Go
- very high quality of example code online

Best of all, I've always had more fun writing in Rust than Go, so this was quite the delightful outcome :-)

## What's Next

I'm being realistic this time. This is still a side project, still experimental, still uncertain. But the foundation feels right in a way 2020's didn't.

Near-term focus:

- Implement the full compilation pipeline
- Build a polished REPL using modern TUI crates
- Iterate on design documents to accurately represent language progress, additions, pivots, etc.
- Work on core forms
- Experiment with language syntax/macros

I'm working in two-day sprints during my time off and making insane amounts of progress. But the goal isn't a releasable language - it's exploring the design space with better tools and clearer vision so that by the time the winter break is over, there's enough momentum that I can continue with the project during nights and weekends.

## Join the Journey

The repository is at [github.com/oxur/oxur](https://github.com/oxur/oxur) (cleaned up, reorganized, active again). Development logs will appear here as blog posts. Design documents are in the repo's `design/` directory, in particular, [here](https://github.com/oxur/oxur/blob/main/crates/design/docs/index.md).

If you're interested in:

- Lisp/Rust interop and hybrid compilation/interpretation
- Homoiconic languages with static type systems
- Modern language tooling and REPL design
- Related experiments and explorations

...then follow along! This iteration of Oxur is informed by 30 years of professional experience, nearly 15 years as an LFE contributor, and five years of deep thinking about Lisps on hosted statically typed languages.

It's good to be back. Let's see what we can build :-)
