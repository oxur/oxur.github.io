---
layout: default.liquid
title: Documentation
description: Complete documentation for Oxur - a modern Lisp dialect for systems programming
---

<div class="prose prose-lg max-w-none">

# Oxur Documentation

Welcome to the Oxur documentation! Oxur is a modern Lisp dialect designed for systems programming, combining the expressive power of Lisp with native performance and contemporary tooling.

<div class="alert alert-info mt-8">
  <span class="iconify lucide--info size-5"></span>
  <span>Oxur is under active development. This documentation reflects the planned features and current implementation status.</span>
</div>

## Getting Started

### Installation

Oxur can be installed using several methods:

**Via Cargo (Rust package manager):**

```bash
cargo install oxur
```

**From source:**

```bash
git clone https://github.com/oxur/oxur.git
cd oxur
cargo build --release
```

**Binary releases:**
Download pre-built binaries from the [releases page](https://github.com/oxur/oxur/releases).

### Quick Start

Create your first Oxur program:

```lisp
;; hello.oxur
(defn main []
  (println "Hello, World!"))
```

Run it:

```bash
oxur run hello.oxur
```

Or compile to a native binary:

```bash
oxur build hello.oxur -o hello
./hello
```

## Language Features

### Modern Lisp Syntax

Oxur provides familiar Lisp syntax with modern enhancements:

- **S-expressions**: Classic parenthesized expressions
- **Immutability by default**: Variables are immutable unless explicitly marked mutable
- **Type inference**: Strong static typing with inference
- **Pattern matching**: Powerful destructuring and matching
- **Hygenic macros**: Safe macro system with proper scoping

### Performance

Built with Rust and compiling to native code, Oxur delivers:

- Zero-cost abstractions
- Minimal runtime overhead
- Direct system calls
- Efficient memory management

### Tooling

Oxur comes with a complete toolchain:

- **REPL**: Interactive development environment
- **Package Manager**: Dependency management and project scaffolding
- **LSP Server**: IDE integration for autocomplete, goto definition, etc.
- **Formatter**: Consistent code formatting
- **Debugger**: Step-through debugging support

## Syntax Basics

### Variables and Bindings

```lisp
;; Immutable binding
(def x 42)

;; Mutable variable
(def mut counter 0)
(set! counter (+ counter 1))

;; Local bindings
(let [a 10
      b 20]
  (+ a b))
```

### Functions

```lisp
;; Function definition
(defn factorial [n]
  (if (<= n 1)
    1
    (* n (factorial (- n 1)))))

;; Anonymous functions
(def square (fn [x] (* x x)))

;; Short lambda syntax
(map #(* % %) [1 2 3 4 5])
```

### Data Structures

```lisp
;; Lists
(def numbers '(1 2 3 4 5))

;; Vectors (efficient random access)
(def coords [10 20 30])

;; Maps
(def person {:name "Alice"
             :age 30
             :email "alice@example.com"})

;; Sets
(def unique #{1 2 3 4 5})
```

### Control Flow

```lisp
;; Conditionals
(if (> x 0)
  "positive"
  "non-positive")

;; Cond for multiple branches
(cond
  (< x 0) "negative"
  (> x 0) "positive"
  :else "zero")

;; Pattern matching
(match value
  [:ok result] result
  [:err msg] (println "Error:" msg))
```

### Macros

```lisp
;; Define a macro
(defmacro when [test & body]
  `(if ~test
     (do ~@body)))

;; Usage
(when (= day "Friday")
  (println "Weekend is near!")
  (celebrate))
```

## Examples

### Fibonacci Sequence

```lisp
(defn fib [n]
  (match n
    0 0
    1 1
    _ (+ (fib (- n 1)) (fib (- n 2)))))

;; With memoization
(def fib-memo
  (memoize
    (fn [n]
      (match n
        0 0
        1 1
        _ (+ (fib-memo (- n 1)) (fib-memo (- n 2)))))))
```

### File I/O

```lisp
(use oxur.io)

;; Read file
(def content (io/read-file "data.txt"))

;; Write file
(io/write-file "output.txt" "Hello, Oxur!")

;; Process lines
(io/with-reader "input.txt"
  (fn [reader]
    (doseq [line (io/lines reader)]
      (println line))))
```

### Web Server

```lisp
(use oxur.http)

(defn handler [request]
  {:status 200
   :headers {"Content-Type" "text/plain"}
   :body "Hello from Oxur!"})

(defn main []
  (http/serve handler {:port 8080})
  (println "Server running on port 8080"))
```

## Standard Library {#stdlib}

The Oxur standard library provides comprehensive functionality:

### Core

- **Collections**: List, vector, map, set operations
- **String**: String manipulation and formatting
- **Math**: Mathematical functions and constants
- **IO**: File and stream operations

### Concurrency

- **Channels**: CSP-style message passing
- **Futures**: Asynchronous computation
- **Atoms**: Atomic references for shared state

### System

- **Process**: Process spawning and management
- **FS**: File system operations
- **Net**: Network programming
- **Time**: Date and time handling

### Utilities

- **JSON**: JSON parsing and generation
- **Regex**: Regular expressions
- **Testing**: Unit testing framework
- **Logging**: Structured logging

## Project Structure

A typical Oxur project:

```
my-project/
├── Oxur.toml          # Project configuration
├── src/
│   ├── main.oxur      # Main entry point
│   └── lib/
│       └── utils.oxur # Library modules
├── tests/
│   └── test_main.oxur # Unit tests
└── README.md
```

### Oxur.toml

```toml
[package]
name = "my-project"
version = "0.1.0"
authors = ["Your Name <you@example.com>"]
license = "MIT"

[dependencies]
http = "0.2"
json = "0.1"
```

## Contributing {#contributing}

We welcome contributions to Oxur! Here's how to get involved:

### Development Setup

1. Fork the repository
2. Clone your fork: `git clone https://github.com/yourusername/oxur.git`
3. Create a branch: `git checkout -b feature/your-feature`
4. Make your changes
5. Run tests: `cargo test`
6. Submit a pull request

### Contribution Guidelines

- Follow the existing code style
- Add tests for new features
- Update documentation
- Write clear commit messages
- Be respectful and constructive

### Areas for Contribution

- **Core language features**: Implement new language constructs
- **Standard library**: Add new modules and functions
- **Tooling**: Improve REPL, formatter, LSP server
- **Documentation**: Examples, tutorials, guides
- **Testing**: Increase test coverage
- **Performance**: Optimize critical paths

## Resources

### Community

- **GitHub**: [github.com/oxur/oxur](https://github.com/oxur/oxur)
- **Discussions**: [github.com/oxur/oxur/discussions](https://github.com/oxur/oxur/discussions)
- **Issues**: [github.com/oxur/oxur/issues](https://github.com/oxur/oxur/issues)
- **Mastodon**: [@oxur@fosstodon.org](https://fosstodon.org/@oxur)

### Learning Resources

- [Tutorial](#tutorial) - Step-by-step introduction
- [Examples](https://github.com/oxur/oxur/tree/main/examples) - Code examples
- [API Reference](https://docs.rs/oxur) - Complete API documentation
- [Wiki](https://github.com/oxur/oxur/wiki) - Community guides

## License {#license}

Oxur is open source software released under the **MIT License**.

You are free to use, modify, and distribute Oxur for both personal and commercial purposes. See the [LICENSE](https://github.com/oxur/oxur/blob/main/LICENSE) file for full details.

---

<div class="text-center mt-16">
  <p class="text-lg">Questions or feedback?</p>
  <div class="mt-4 flex gap-4 justify-center">
    <a href="https://discord.gg/mndyrJD4" class="btn btn-primary">
      <span class="iconify lucide--message-circle size-5"></span>
      Join Discussion
    </a>
    <a href="https://github.com/oxur/oxur/issues" class="btn btn-outline">
      <span class="iconify lucide--bug size-5"></span>
      Report Issue
    </a>
  </div>
</div>

</div>
