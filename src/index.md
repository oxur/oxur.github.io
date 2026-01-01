---
layout: landing.liquid
title: Home
description: Oxur - A modern, expressive Lisp dialect for systems programming
---

<!-- Hero Section -->
<section class="relative py-12 lg:py-24" id="home">
<div class="absolute inset-0 w-full bg-[url(/assets/images/landing/bg-gradient.png)] bg-cover bg-center bg-no-repeat opacity-20 dark:opacity-15"></div>
<div class="relative z-10 container py-8 lg:py-16">
<div class="grid items-center gap-8 lg:grid-cols-2 xl:gap-36">
<div class="order-2 lg:order-1">
<h1 class="text-center text-3xl/tight leading-10 font-semibold tracking-tight sm:text-start lg:text-4xl/tight">
<span class="text-brand-gradient">Oxur</span>
 - A Modern Lisp for the Next Generation of Developers
</h1>
<h5 class="text-base-content/80 mt-8 text-center sm:text-start lg:text-lg">
Experience the power of Lisp with modern ergonomics, blazing performance, and comprehensive tooling. Build expressive, maintainable systems with confidence.
</h5>
<div class="mt-8 flex gap-4 max-sm:justify-center sm:mt-16 sm:gap-6">
<a href="/#download" class="btn btn-primary btn-lg">
<span class="iconify lucide--download size-5"></span>
Download Oxur
</a>
<a href="/docs" class="btn btn-outline btn-lg">
<span class="iconify lucide--book-open size-5"></span>
Read the Docs
</a>
</div>
</div>

<div class="relative order-1 lg:order-2">
<div class="flex justify-center">
<div class="mockup-code max-w-md animate-bounce-slow">
<pre data-prefix="1"><code>(defn factorial [n]</code></pre>
<pre data-prefix="2"><code>  (if (&lt;= n 1)</code></pre>
<pre data-prefix="3"><code>    1</code></pre>
<pre data-prefix="4"><code>    (* n (factorial</code></pre>
<pre data-prefix="5"><code>          (- n 1)))))</code></pre>
<pre data-prefix="6"><code></code></pre>
<pre data-prefix="7"><code>(factorial 5)</code></pre>
<pre data-prefix="8" class="text-success"><code>; =&gt; 120</code></pre>
</div>
</div>
</div>
</div>

<!-- Stats Cards -->
<div class="mt-12 grid grid-cols-2 gap-8 text-center md:grid-cols-4 lg:mt-16">
<div>
<div class="bg-primary/10 hover:bg-primary/15 text-primary rounded-box inline-flex items-center p-3 transition-all">
<span class="iconify lucide--zap size-8"></span>
</div>
<p class="mt-5 text-2xl font-semibold lg:text-4xl">Fast</p>
<p class="text-base-content/80 mt-1">Compiled Performance</p>
</div>
<div>
<div class="bg-primary/10 hover:bg-primary/15 rounded-box text-primary inline-flex items-center p-3 transition-all">
<span class="iconify lucide--code size-8"></span>
</div>
<p class="mt-5 text-2xl font-semibold lg:text-4xl">Expressive</p>
<p class="text-base-content/80 mt-1">Modern Syntax</p>
</div>
<div>
<div class="bg-primary/10 hover:bg-primary/15 rounded-box text-primary inline-flex items-center p-3 transition-all">
<span class="iconify lucide--package size-8"></span>
</div>
<p class="mt-5 text-2xl font-semibold lg:text-4xl">Complete</p>
<p class="text-base-content/80 mt-1">Rich Standard Library</p>
</div>
<div>
<div class="bg-primary/10 hover:bg-primary/15 rounded-box text-primary inline-flex items-center p-3 transition-all">
<span class="iconify lucide--github size-8"></span>
</div>
<p class="mt-5 text-2xl font-semibold lg:text-4xl">Open</p>
<p class="text-base-content/80 mt-1">MIT Licensed</p>
</div>
</div>
</div>
</section>

<!-- Features Section -->
<section class="container py-8 lg:py-16" id="features">
<div class="grid gap-8 lg:grid-cols-5 xl:gap-16">
<div class="lg:col-span-2">
<p class="text-2xl font-semibold lg:text-3xl">Why choose Oxur?</p>
<p class="text-base-content/80 mt-4">
Oxur combines the timeless power of Lisp with modern language design,
giving you a practical tool for building robust, maintainable systems.
</p>
<div class="mt-8 space-y-3">
<div class="flex items-center gap-3">
<span class="iconify lucide--check text-primary size-4.5"></span>
<p>Native compilation for maximum performance</p>
</div>
<div class="flex items-center gap-3">
<span class="iconify lucide--check text-primary size-4.5"></span>
<p>Modern tooling and package management</p>
</div>
<div class="flex items-center gap-3">
<span class="iconify lucide--check text-primary size-4.5"></span>
<p>Comprehensive standard library</p>
</div>
</div>
</div>
<div class="grid gap-6 sm:grid-cols-2 lg:col-span-3">
<div class="card card-border">
<div class="card-body">
<span class="iconify lucide--cpu text-primary size-8"></span>
<p class="mt-2 text-xl font-medium">High Performance</p>
<p class="text-base-content/80 mt-2 line-clamp-3">
Built with Rust, Oxur compiles to native code for performance
comparable to systems languages.
</p>
</div>
</div>
<div class="card card-border">
<div class="card-body">
<span class="iconify lucide--blocks text-primary size-8"></span>
<p class="mt-2 text-xl font-medium">Powerful Macros</p>
<p class="text-base-content/80 mt-2 line-clamp-3">
Leverage Lisp's legendary macro system to extend the language
and create domain-specific abstractions.
</p>
</div>
</div>
<div class="card card-border">
<div class="card-body">
<span class="iconify lucide--wrench text-primary size-8"></span>
<p class="mt-2 text-xl font-medium">Modern Tooling</p>
<p class="text-base-content/80 mt-2 line-clamp-3">
Integrated package manager, REPL, formatter, and LSP server
for seamless development experience.
</p>
</div>
</div>
<div class="card card-border">
<div class="card-body">
<span class="iconify lucide--book-open text-primary size-8"></span>
<p class="mt-2 text-xl font-medium">Well Documented</p>
<p class="text-base-content/80 mt-2 line-clamp-3">
Comprehensive documentation, tutorials, and examples to get
you started quickly.
</p>
</div>
</div>
</div>
</div>
</section>

<!-- FAQ Section -->
<section class="py-8 lg:py-16" id="faq">
<div class="container">
<div class="text-center">
<h2 class="text-3xl font-semibold lg:text-4xl">Frequently Asked Questions</h2>
<p class="text-base-content/80 mt-2">Everything you need to know about Oxur</p>
</div>

<div class="mt-8 grid gap-6 md:grid-cols-2">
<div class="space-y-6">
<div class="collapse-plus border-base-300 collapse border">
<input checked="checked" name="faq" type="radio" aria-label="open/close" />
<div class="collapse-title text-lg font-medium">
What is Oxur?
</div>
<div class="collapse-content">
<p class="text-base">
Oxur is a modern Lisp dialect designed for systems programming,
combining the expressive power of Lisp with native performance and modern tooling.
</p>
</div>
</div>
<div class="collapse-plus border-base-300 collapse border">
<input name="faq" type="radio" aria-label="open/close" />
<div class="collapse-title text-lg font-medium">
How does Oxur compare to other Lisps?
</div>
<div class="collapse-content">
<p class="text-base">
Oxur prioritizes modern ergonomics and native performance while
maintaining Lisp's core philosophy of code as data. Built with Rust,
it compiles to efficient native code.
</p>
</div>
</div>
<div class="collapse-plus border-base-300 collapse border">
<input name="faq" type="radio" aria-label="open/close" />
<div class="collapse-title text-lg font-medium">
What can I build with Oxur?
</div>
<div class="collapse-content">
<p class="text-base">
Oxur is suitable for systems programming, CLI tools, web services,
and any application requiring high performance and expressive code.
</p>
</div>
</div>
</div>

<div class="space-y-6">
<div class="collapse-plus border-base-300 collapse border">
<input name="faq" type="radio" aria-label="open/close" />
<div class="collapse-title text-lg font-medium">
Is Oxur production-ready?
</div>
<div class="collapse-content">
<p class="text-base">
Oxur is under active development. Check our GitHub repository
for the current status, roadmap, and planned features.
</p>
</div>
</div>
<div class="collapse-plus border-base-300 collapse border">
<input name="faq" type="radio" aria-label="open/close" />
<div class="collapse-title text-lg font-medium">
How can I contribute?
</div>
<div class="collapse-content">
<p class="text-base">
Contributions are welcome! Visit our GitHub repository for
contribution guidelines, open issues, and discussion forums.
</p>
</div>
</div>
<div class="collapse-plus border-base-300 collapse border">
<input name="faq" type="radio" aria-label="open/close" />
<div class="collapse-title text-lg font-medium">
What's the license?
</div>
<div class="collapse-content">
<p class="text-base">
Oxur is open source software released under the MIT license,
free for both personal and commercial use.
</p>
</div>
</div>
</div>
</div>
</div>
</section>

<!-- Download CTA Section -->
<section class="py-8 lg:py-16" id="download">
<div class="container text-center">
<p class="text-3xl font-semibold lg:text-4xl">Get started with Oxur today!</p>
<p class="text-base-content/80 mt-8 inline-block max-w-[600px]">
Download the latest release and start building with a modern Lisp that
combines elegance with performance.
</p>
<div class="mt-8 flex justify-center gap-4 sm:gap-6">
<a href="/download" class="btn btn-primary btn-lg">
<span class="iconify lucide--download size-5"></span>
Download
</a>
<a href="/docs" class="btn btn-outline btn-lg">
<span class="iconify lucide--book size-5"></span>
Documentation
</a>
</div>
</div>
</section>
