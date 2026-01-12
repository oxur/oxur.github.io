---
title: Blog
description: Insights on Oxur, Treebeard, Rust, ASTs, and Lisps
layout: blog.liquid
---

<!-- Featured Posts Section -->
{% if site.data.featured_posts %}
<section class="mb-16">
<h2 class="text-2xl font-bold mb-6 flex items-center gap-2">
<span class="iconify lucide--star size-6 text-primary"></span>
Featured Posts
</h2>
<!-- First row: 2 columns -->
<div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
{% assign featured_count = 0 %}
{% for post_slug in site.data.featured_posts limit: 2 %}
{% for post in collections.posts.pages %}
{% if post.slug == post_slug %}
{% assign include_post = post %}
{% assign include_style = "card" %}
{% assign include_show_excerpt = true %}
{% include "post-card.liquid" %}
{% assign featured_count = featured_count | plus: 1 %}
{% endif %}
{% endfor %}
{% endfor %}
</div>
<!-- Second row: 1 full-width featured post -->
{% assign featured_count = 0 %}
{% for post_slug in site.data.featured_posts %}
{% if featured_count == 2 %}
{% for post in collections.posts.pages %}
{% if post.slug == post_slug %}
{% assign include_post = post %}
{% assign include_style = "featured-large" %}
{% assign include_show_excerpt = true %}
{% include "post-card.liquid" %}
{% endif %}
{% endfor %}
{% endif %}
{% assign featured_count = featured_count | plus: 1 %}
{% endfor %}
</section>
{% endif %}

<!-- Recent Posts Section -->
<section class="mb-16">
  <div class="flex justify-between items-center mb-6">
    <h2 class="text-2xl font-bold">Recent Posts</h2>
    <a href="/blog/archives/" class="btn btn-ghost btn-sm">
      View All
      <span class="iconify lucide--arrow-right size-4 ml-1"></span>
    </a>
  </div>
  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
    {% for post in collections.posts.pages limit: 6 %}
      {% assign include_post = post %}
      {% assign include_style = "card" %}
      {% assign include_show_excerpt = true %}
      {% include "post-card.liquid" %}
    {% endfor %}
  </div>
</section>

<!-- Categories/Tags Cloud -->
<section class="mb-16">
<h2 class="text-2xl font-bold mb-6">Browse by Tag</h2>
<div class="flex flex-wrap gap-2">{% assign all_tags = "" | split: "" %}{% for post in collections.posts.pages %}{% for tag in post.tags %}{% unless all_tags contains tag %}{% assign all_tags = all_tags | push: tag %}{% endunless %}{% endfor %}{% endfor %}{% for tag in all_tags %}<a href="/blog/tags/{{ tag | slugify }}/" class="badge badge-lg badge-outline hover:badge-primary transition-colors">{{ tag }}</a> {% endfor %}</div>
</section>
