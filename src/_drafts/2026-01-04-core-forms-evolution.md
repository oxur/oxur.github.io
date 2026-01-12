---
title: "The Evolution of Lisp Core Forms: A Tabular History"
description: Tracing how "core" versus "derived" forms were categorized from McCarthy through Scheme standardization
published_date: 2026-01-04 11:00:00 -0600
layout: post.liquid
is_draft: true
tags:
  - lisp
  - history
  - design
  - reference
categories:
  - Language Design
data:
  read_time: 8
  featured: false
---

Yesterday's post explored [the philosophical journey toward minimal Lisp](/posts/2026-01-03-quest-for-minimal-lisp/). Today, I want to provide a reference: **exact tables** showing what each era considered "core" versus "derived."

This is useful not just for historical interest, but as a practical guide when designing Oxur's Core Forms. Seeing how categorizations evolved reveals which forms are genuinely primitive and which just *feel* primitive until you examine them closely.

## McCarthy's Original Lisp (1960)

**Source:** "Recursive Functions of Symbolic Expressions and Their Computation by Machine, Part I"

### Elementary Functions (5)

| Function | Purpose |
|----------|---------|
| `ATOM` | Test if argument is an atomic symbol |
| `EQ` | Test equality of two atoms |
| `CAR` | Return first element of a pair |
| `CDR` | Return second element of a pair |
| `CONS` | Construct a new pair from two arguments |

### Special Forms (4)

| Form | Purpose | Notes |
|------|---------|-------|
| `QUOTE` | Prevent evaluation | Returns argument unevaluated |
| `COND` | Conditional expression | Lazy evaluation of branches |
| `LAMBDA` | Function abstraction | Creates anonymous functions |
| `LABEL` | Recursive naming | Later shown unnecessary (Y combinator) |

**Total: 9 operators** for universal computation.

## Original Scheme (1975)

**Source:** MIT AI Memo 349 (Sussman & Steele, December 1975)

Scheme introduced **AINTs** (primitive special forms) versus **AMACROs** (derived forms).

### AINTs (Primitive) - 7

| Form | Purpose | Notes |
|------|---------|-------|
| `IF` | Two-branch conditional | "The primitive conditional operator" |
| `QUOTE` | Prevent evaluation | "As in LISP" |
| `DEFINE` | Top-level definition | LAMBDA must appear explicitly |
| `LABELS` | Local recursive functions | ALGOLesque; allows mutual recursion |
| `ASET` | Assignment | "The side effect primitive" |
| `EVALUATE` | Eval | "Similar to LISP EVAL" |
| `CATCH` | Continuation capture | "Escape operator for control structure" |

*Note: `LAMBDA` isn't listed as AINT because it's even more fundamental - it's how all closures are created.*

### AMACROs (Derived) - 6+

| Form | Expansion Target | Notes |
|------|------------------|-------|
| `COND` | Nested `IF` | "Singleton clauses not allowed" |
| `AND` | `IF` | "As in MacLISP" |
| `OR` | `IF` | "As in MacLISP" |
| `BLOCK` | `LAMBDA` | "Like PROGN but tail-call optimized" |
| `DO` | `LABELS` + `IF` | "Like MacLISP new-style DO" |
| `AMAPCAR` | `LABELS` | Expects SCHEME lambda closure |

## RABBIT Compiler (1978)

**Source:** MIT AI Technical Report 474 (Steele)

The RABBIT compiler formalized the "semantic basis set" - the minimal core the compiler needed to understand.

### Semantic Basis Set (6)

| Form | Purpose |
|------|---------|
| `LAMBDA` | Function abstraction |
| `IF` | Conditional |
| `QUOTE` | Literal data |
| `SETQ` | Assignment |
| `CATCH` | Continuation capture |
| Application | Function calls |

### Explicitly Derived

| Form | Notes |
|------|-------|
| `COND` | → nested `IF` |
| `AND` / `OR` | → `IF` with `LAMBDA` for lazy evaluation |
| `BLOCK` | → sequenced `LAMBDA` applications |
| `DO` | → recursive `LABELS` |
| `LET` | → `LAMBDA` application |
| `LABELS` | → `LETREC` equivalent |

## R3RS - Revised³ Report on Scheme (1986)

**Source:** The R3RS specification

R3RS formalized **Primitive Expression Types** vs **Derived Expression Types**.

### Primitive Expression Types (6)

| Type | Syntax Example | Purpose |
|------|----------------|---------|
| Variable reference | `x` | Look up binding |
| Literal expression | `'datum`, `#t`, `42` | Self-evaluating or quoted |
| Procedure call | `(operator operands...)` | Apply function |
| Lambda expression | `(lambda (x) body)` | Create procedure |
| Conditional | `(if test conseq alt)` | Branch |
| Assignment | `(set! var expr)` | Mutate binding |

### Derived Expression Types (11)

| Form | Category | Reduces To |
|------|----------|------------|
| `cond` | Conditional | Nested `if` |
| `case` | Conditional | `let` + `cond` + `memv` |
| `and` | Conditional | `if` + `let` |
| `or` | Conditional | `if` + `let` |
| `let` | Binding | `lambda` application |
| `let*` | Binding | Nested `let` |
| `letrec` | Binding | `let` + `set!` |
| `begin` | Sequencing | `lambda` with sequence |
| `do` | Iteration | `letrec` + `if` |
| `delay` | Evaluation | `lambda` (thunk) |
| `quasiquote` | Quotation | `quote` + `cons` + `list` |

**Key quote:** "By application of these rules, any expression can be reduced to a semantically equivalent expression in which only the primitive expression types occur."

## R5RS - Revised⁵ Report on Scheme (1998)

**Source:** The R5RS specification

R5RS refined categories and added macro-related primitives.

### Primitive Constructs (9)

| Category | Forms | Purpose |
|----------|-------|---------|
| **Expression Types** | | |
| Variable reference | `identifier` | Lookup |
| Literal | `quote`, self-eval | Data |
| Procedure call | `(operator operands...)` | Application |
| `lambda` | `(lambda formals body)` | Abstraction |
| `if` | `(if test conseq [alt])` | Conditional |
| `set!` | `(set! var expr)` | Assignment |
| **Macro Forms** | | |
| `let-syntax` | | Local macro binding |
| `letrec-syntax` | | Recursive local macros |
| `syntax-rules` | | Pattern-based macros |

### Derived Expression Types (14)

| Form | Category |
|------|----------|
| `cond` | Conditional |
| `case` | Conditional |
| `and` | Conditional |
| `or` | Conditional |
| `let` | Binding |
| `let*` | Binding |
| `letrec` | Binding |
| `begin` | Sequencing |
| `do` | Iteration |
| `named let` | Iteration |
| `delay` | Lazy eval |
| `quasiquote` | Quotation |
| `unquote` | Quotation |
| `unquote-splicing` | Quotation |

## Common Lisp - The Contrast (1994)

**Source:** ANSI Common Lisp Standard

Common Lisp took a different approach: **25 special operators** fixed in the language.

### All 25 Special Operators

| Operator | Category | Purpose |
|----------|----------|---------|
| `block` | Control | Named exit point |
| `catch` | Control | Dynamic non-local exit |
| `eval-when` | Evaluation | Control evaluation time |
| `flet` | Binding | Local function binding |
| `function` | Reference | Get function object |
| `go` | Control | Transfer to tag |
| `if` | Conditional | Branch |
| `labels` | Binding | Local recursive functions |
| `let` | Binding | Parallel local binding |
| `let*` | Binding | Sequential local binding |
| `load-time-value` | Evaluation | Evaluate at load time |
| `locally` | Declaration | Local declarations |
| `macrolet` | Binding | Local macro binding |
| `multiple-value-call` | Values | Pass multiple values |
| `multiple-value-prog1` | Values | Return multiple values |
| `progn` | Sequencing | Sequential evaluation |
| `progv` | Binding | Dynamic variable binding |
| `quote` | Quotation | Prevent evaluation |
| `return-from` | Control | Return from block |
| `setq` | Assignment | Variable assignment |
| `symbol-macrolet` | Binding | Local symbol macros |
| `tagbody` | Control | Establish tags for GO |
| `the` | Declaration | Type declaration |
| `throw` | Control | Throw to catch |
| `unwind-protect` | Control | Cleanup forms |

**Note:** Many of these (like `let`, `let*`, `flet`, `labels`) *could* theoretically derive from `lambda`, but Common Lisp chose practicality - special operators enable more efficient compilation.

## Theoretical Minimum

Research established what truly cannot be derived.

### The Irreducible Core (5 forms)

| Form | Why Irreducible |
|------|-----------------|
| `QUOTE` | Meta-level operation; can't define quote using quote |
| `LAMBDA` | Foundation of all binding; defines abstraction itself |
| `IF` | Must not evaluate both branches |
| `SET!` | Requires location access, not value |
| `DEFINE` | Requires privileged environment access |

### Pure Lambda Calculus (3 constructs)

| Construct | Notes |
|-----------|-------|
| Lambda abstraction | `λx.body` |
| Application | `(f x)` |
| Variables | `x` |

Everything else (conditionals, numbers, pairs) can be Church-encoded, but this is impractical.

## The Narrowing Funnel: Summary

| Era | Source | Core Forms | Notes |
|-----|--------|------------|-------|
| 1960 | McCarthy | **9** | 5 functions + 4 special forms |
| 1975 | Original Scheme | **7** | AINTs only |
| 1978 | RABBIT | **~6** | Semantic basis set |
| 1986 | R3RS | **6** | Primitive expression types |
| 1998 | R5RS | **6 + 3** | Core + macro forms |
| 1994 | Common Lisp | **25** | Practical over minimal |
| Theory | Lambda calculus | **3** | Abstraction + application + variables |
| Practical | — | **5** | quote, lambda, if, set!, define |

The history shows consistent drive toward identifying the smallest possible core, with **lambda as the universal binding mechanism** from which most other constructs derive.

## Implications for Oxur

Looking at this evolution, several principles emerge for Oxur's Core Forms:

**1. Lambda is central.** Every system converged on lambda as the primitive abstraction. Oxur's Core Forms must make lambda foundational.

**2. Around 5-6 forms are genuinely primitive.** More than that, and you're including convenience. Fewer, and you sacrifice practicality for theoretical purity.

**3. Macros enable derived forms.** R5RS's success came from formalizing the primitive/derived split with hygenic macros. Oxur should do the same - Core Forms + macro system = complete language.

**4. Type integration adds requirements.** Scheme doesn't care about types. Oxur integrates with Rust's type system, so Core Forms need type-related constructs (`type-ref`, `param`, typed bindings). This is fine - it's our version of Common Lisp's practical additions.

**5. The boundary protects stability.** By clearly marking what's primitive, we protect ourselves from churn. Surface forms can experiment wildly; Core Forms stay stable.

## Conclusion

This tabular history serves as both reference and guide. When designing Core Forms, we can ask: "Which category has this historically belonged to?" The answer usually reveals whether it's genuinely primitive or derived convenience.

For Oxur, the plan is:
- **Core Forms**: ~6-8 primitives (quote, lambda, if, define-func, let, set!, type-ref, param)
- **Structural forms**: ~5-6 (block, binary-op, call, var-ref, literal)
- **Surface Forms**: Everything else, expressed via macros

This gives us Scheme-level minimalism with Rust-integration practicality. The right balance for our goals.

---

*This document lives in the Oxur repository as `workbench/lisp_core_forms_evolution.md`. It complements the philosophical exploration in [Quest for Minimal Lisp](/posts/2026-01-03-quest-for-minimal-lisp/) with concrete historical data.*
