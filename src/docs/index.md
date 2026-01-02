---
layout: default.liquid
title: Documentation
description: Complete documentation for Oxur - a modern Lisp dialect for systems programming
---

<div class="prose prose-lg max-w-none">

# Oxur Documentation

<div class="alert alert-warning mt-8">
  <span class="iconify lucide--info size-5"></span>
  <span>Oxur is under active development. This documentation reflects the planned features and current implementation status.</span>
</div>

Welcome to the Oxur documentation! The project is under active, early development, so it is too early for format documentation. However, there are several options if you want to keep track of our designs, implementations, discoveries, and issues.

## Getting Started

### Obtaining the Source

```bash
git clone https://github.com/oxur/oxur.git
cd oxur
make build
```

**Binary releases:**

Download pre-built binaries will be available from the [releases page](https://github.com/oxur/oxur/releases).

### Checking Current Status

To view the list of design docs and their current status:

```bash
./bin/oxd list
```

[![oxd cli tool screenshot of list command][oxd-list-screenshot]][oxd-list-screenshot]

[oxd-list-screenshot]: assets/images/screenshots/oxd-list.png

Note that those documents have metadata and they are tracked via the oxd tool, receive updates, etc.

If you are interested in low-level Oxur, we suggest reading the AST and S-expression design docs. If you are curious about directions in syntax, be sure to check out documents `0021` and `0025`.

Note that these are all indexed and linked here, for web-browsing convenience:

* <https://github.com/oxur/oxur/blob/main/crates/design/docs/index.md>

We also have less formal documents that do not have their metadata tracked and do not go through an approval process. They are more like Github tickets and can be viewed with the `--dev` flag:

```bash
./bin/oxd list --dev
```

[![oxd cli tool screenshot of list dev command][oxd-list-dev-screenshot]][oxd-list-dev-screenshot]

[oxd-list-dev-screenshot]: assets/images/screenshots/oxd-list-dev.png
