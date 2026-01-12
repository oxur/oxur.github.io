---
title: "Announcing Treebeard: Oxur's Tree-Walking Interpreter"
description: From REPL experiments to VM epiphany - how Oxur's interpreter emerged from understanding the compilation pipeline
published_date: 2026-01-11 14:00:00 -0600
layout: post.liquid
is_draft: true
tags:
  - treebeard
  - interpreter
  - oxur
  - vm
  - architecture
categories:
  - Technical Deep Dives
data:
  read_time: 8
  featured: true
  image: /assets/images/blog/treebeard-post.png
---

Yesterday, while documenting Oxur's compilation pipeline, I had an epiphany that changed everything. Let me explain.

## The Problem That Started It All

I was working on the REPL's "def" variable problem. You type `(def x:i32 42)` in the REPL, it works perfectly in "calculator mode" (instant evaluation), but then the variable *disappears* when you try using it in more complex code that requires compilation.

Why? Because calculator mode stores variables in Rust data structures (immediate evaluation), while compilation generates standalone Rust code (stateless). The variables live in different worlds. I spent days trying to figure out how to "inject" REPL variables into compiled Rust code, hitting rough edge after rough edge.

Then, while mapping out the compilation pipeline for documentation, I realized something profound.

## The Compilation Pipeline (Briefly)

Oxur's compilation works in clear stages:

1. **Parse**: Text → Surface Forms (ergonomic S-expressions)
2. **Expand**: Surface Forms → Core Forms (stable, minimal IR)
3. **Lower**: Core Forms → Oxur AST (Rust concepts, still S-expressions)
4. **Convert**: Oxur AST → `syn` structures (Rust AST library)
5. **Generate**: `syn` → Rust source (via `prettyplease` or `ToTokens`)
6. **Compile**: Rust source → binary (via `rustc`)

The key innovation is **Core Forms** - a stable intermediate representation inspired by LFE (Lisp Flavored Erlang). They capture Lisp semantics in a minimal, canonical form: `define-func`, `lambda`, `if-expr`, `binary-op`, etc.

Core Forms give us "buffer zone architecture" - the front-end (Oxur syntax) can evolve independently from the back-end (Rust codegen), because they're decoupled by this stable IR.

## The Epiphany

While explaining Core Forms, I had this thought: *These are stable. Canonical. Well-defined. They represent Oxur semantics, not Rust semantics.*

And then: **They're directly interpretable.**

What if Core Forms aren't just an intermediate representation for *compilation*? What if they're also the *bytecode format* for a virtual machine?

S-expressions like `(define-func :name add :params [...] :body [...])` aren't "code to compile" - they're *data structures* we can traverse and execute directly!

Suddenly, everything clicked into place.

## Enter Treebeard

**Treebeard** is Oxur's tree-walking interpreter. Named after Tolkien's wise Ent (slow, deliberate, thoughtful), Treebeard executes Core Forms directly without touching `rustc`.

The architecture is simple:

```rust
struct Treebeard {
    heap: HashMap<String, TypedValue>,  // where variables live!
    stack: Vec<Value>,
    code: Vec<SExp>,  // Core Forms
}

impl Treebeard {
    fn eval(&mut self, form: &SExp) -> Result<Value> {
        match form {
            SExp::Symbol(s) => self.heap.get(s).cloned(),
            SExp::Number(n) => Ok(Value::I64(*n)),
            SExp::List(forms) => {
                // Pattern match on Core Forms
                match forms.as_slice() {
                    [Symbol("define-func"), ...] => self.eval_function_def(...),
                    [Symbol("if-expr"), ...] => self.eval_conditional(...),
                    [Symbol("binary-op"), ...] => self.eval_binary_op(...),
                    _ => self.eval_application(...),
                }
            }
        }
    }
}
```

When you type `(def x:i32 42)` in the REPL, Treebeard stores it in the heap. When you reference `x` later, Treebeard looks it up. Variables persist *naturally* because they live in the interpreter's environment.

No injection hacks. No trying to bridge incompatible worlds. Just straightforward evaluation.

## Three Execution Paths

This unlocks a beautiful architecture with **three execution strategies**:

### Tier 1: Calculator Mode (~0.1-1ms)
Simple arithmetic on integers, evaluated directly in Rust. No compilation, no VM overhead. Just fast number crunching.

### Tier 2: VM Interpretation (~1-5ms)
Execute Core Forms in Treebeard. Variables live in the VM heap, functions are closures over the VM environment, state persists across evaluations. No `rustc` invocation.

### Tier 3: Compilation (~5-300ms)
Lower Core Forms to Rust, compile to native code. Can inject VM state for hybrid execution. Two sub-paths:
- **Fast path**: Quick codegen (~50-100ms) for REPL testing
- **Optimized path**: Pretty-printed, fully-optimized Rust (~50-300ms) for production

The **critical insight**: Core Forms work as BOTH compilation IR AND VM bytecode. One IR, multiple execution engines!

## This IS the LFE Pattern

LFE (Lisp Flavored Erlang) does exactly this:
- Core Erlang = stable IR
- Can *interpret* Core Erlang (debugging, REPL)
- Can *compile* to BEAM bytecode (production)

Oxur now does the same:
- Core Forms = stable IR
- Can *interpret* in Treebeard (development, REPL)
- Can *compile* to Rust (production)

Robert Virding's insight was that the IR doesn't need to be ergonomic - it needs to be *stable* and *minimal*. Then you get freedom on both ends: experiment with syntax on the front-end, target multiple platforms on the back-end.

We're following the same playbook.

## Why This Matters

**For REPL users**: Variables just work. Type `(def x 42)`, reference `x` later - it's there. No mental model of "modes" or "tiers". The interpreter handles it naturally.

**For debugging**: Step through Core Forms execution, inspect the heap, watch evaluation in real-time. Treebeard can expose everything because it's not hidden inside compiled code.

**For experimentation**: Try language features quickly. If it works in Treebeard, great - optimize later. If it doesn't, iterate rapidly without waiting for `rustc`.

**For the future**: Once Core Forms are stable, we can target *other* back-ends. Compile to WASM? Sure. Generate BEAM bytecode for Erlang interop? Possible. Target LLVM directly? Eventually.

The Core Forms abstraction makes all of this feasible.

## Current Status

Treebeard is *very* early - the repository just went live yesterday. Current capabilities:

- Basic Core Forms evaluation (arithmetic, variables, simple functions)
- Heap management for variable storage
- Integration with the REPL as "Tier 2"
- Foundation for more sophisticated features

What's coming:

- Full Core Forms spec (conditionals, pattern matching, recursion)
- Proper closure support with environment chains
- Tail call optimization
- Integration with Oxur's type system
- Performance benchmarking vs compilation

## The Path Forward

This discovery fundamentally changed Oxur's architecture for the better. What was a "compiler that sometimes interprets for convenience" is now "a language with multiple execution strategies, each optimized for different use cases."

The compilation pipeline document that triggered this epiphany is in the Oxur repo as `crates/design/dev/oxur-runtime/0001-compilation-pipeline-vm-epiphany.md` - it captures the full thought process, confusions, corrections, and breakthroughs from that brainstorming session.

Treebeard itself is at github.com/oxur/treebeard. It's a separate project because the interpreter has value beyond just Oxur - anyone working with Lisp-like languages might find the Core Forms interpreter pattern useful.

## Conclusion

Sometimes the best insights come from trying to explain what you're building. By forcing myself to document the compilation pipeline clearly, I uncovered an architecture that's cleaner, more flexible, and more powerful than what I started with.

Core Forms as interpretable IR. Three execution tiers. Persistent REPL state without hacks. It all fits together now.

Treebeard: slow, deliberate, thoughtful - and exactly what Oxur needed.

If you're interested in language implementation, VMs, or the intersection of interpretation and compilation, check out the repositories and design docs. This is getting exciting.
