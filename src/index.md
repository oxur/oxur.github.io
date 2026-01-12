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
 (/ˈoʊkər/ OH-kər) - A Modern Lisp for the Next Generation of Developers
</h1>
<h5 class="text-base-content/80 mt-8 text-center sm:text-start lg:text-lg">
Experience the power of Lisp built on Rust—with modern ergonomics, blazing performance, and comprehensive tooling. Build expressive, maintainable systems with confidence.
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

<div class="max-w-md animate-bounce-slow">
<pre class="p-12"><code class="language-oxur">(deffn fibonacci (n:i32) (:> i32)
  (0 0)
  (1 1)
  (n (+ (fibonacci (- n 1))
        (fibonacci (- n 2)))))
</code></pre>
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
<p class="text-base-content/80 mt-1">Primordial Syntax</p>
</div>
<div>
<div class="bg-primary/10 hover:bg-primary/15 rounded-box text-primary inline-flex items-center p-3 transition-all">
<span class="iconify lucide--package size-8"></span>
</div>
<p class="mt-5 text-2xl font-semibold lg:text-4xl">Proven</p>
<p class="text-base-content/80 mt-1">The Rust Standard Library <br/>and Ecosystem</p>
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
For now, choose it for the exploration of the unknown :-D When it's finished, you can choose it for Oxur's combination of the timeless power of Lisp with modern language design,
which will give you a practical tool for building robust, maintainable systems using a Lisp backed by Rust.
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
<p class="text-base-content/80 mt-4">Also, we've got this guy:

[![Ruxxy the Orux][ruxxy]][ruxxy]

[ruxxy]: assets/images/logo/v2.3-250x.png

</p>
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
Full integration with rustc, cargo, and crates; will add the Oxur compiler, a REPL, formatter, AST inspector, and IDE extensions for a seamless development experience.
</p>
</div>
</div>
<div class="card card-border">
<div class="card-body">
<span class="iconify lucide--book-open text-primary size-8"></span>
<p class="mt-2 text-xl font-medium">Well Documented</p>
<p class="text-base-content/80 mt-2 line-clamp-3">
Have we mentioned our design docs? If design docs are your thing, have we got a treat for you!
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
combining the expressive power of Lisp with Rust's native performance and modern tooling.
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
it compiles to efficient native code. Also, have you <em>seen</em> the Rust AST?! It's absolutely BONKERS. One of the best things ever. Seriously. Oxur's AST is just the Rust AST in S-expression form. 🤤
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
and any application requiring high performance and expressive code. Oxur provides 100% interop with Rust—anything you can build with Rust, you can build with Oxur!
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
Seriously? Not even close. It's not even ready for <em>alpha testing</em>. Huge swaths of the language haven't even been created yet! Oxur is under active development. Check the Github repository
for the latest. And don't forget those delicious design docs, either!
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
Contributions are welcome! But there's a good chance most contributions will take place as conversations, feedback, questions, and concerns in our Discord. Check the links below for the invite!
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
