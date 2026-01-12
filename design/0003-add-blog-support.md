# Adding Blog Functionality to oxur.li (Cobalt SSG)

## Overview

This guide provides instructions for adding a complete blogging system to the oxur.li static site, which uses **Cobalt** (a Rust-based static site generator) with **Liquid templates**, **Tailwind CSS**, and **DaisyUI** components.

---

## Part 1: Understanding the Current Site Structure

Based on the git-tracked files, the site has this relevant structure:

```
├── _cobalt.yml                    # Main Cobalt configuration
├── src/
│   ├── _includes/                 # Liquid partials
│   │   ├── footer.liquid
│   │   ├── head.liquid
│   │   ├── header.liquid
│   │   ├── theme-toggle.liquid
│   │   └── topbar.liquid
│   ├── _layouts/                  # Page layouts
│   │   ├── default.liquid
│   │   ├── landing.liquid
│   │   └── redirect.liquid
│   ├── assets/
│   │   ├── css/
│   │   │   ├── main.css
│   │   │   └── atom-one-dark.min.css  # Code highlighting
│   │   └── js/
│   │       ├── main.js
│   │       └── highlight-*.min.js
│   ├── styles/
│   │   ├── app.css
│   │   └── daisyui.css
│   ├── docs/                      # Existing documentation pages
│   └── index.md                   # Homepage
├── docs/                          # Build output directory
└── design/                        # Design documents
```

**Key Points:**
- Site uses `.liquid` templates and `.md` content files
- DaisyUI is already integrated (see `daisyui.css`)
- Code syntax highlighting is available via highlight.js
- The `docs/` folder appears to be the build output (common for GitHub Pages)

---

## Part 2: Creating the Blog Infrastructure

### Step 1: Update `_cobalt.yml` Configuration

Add/modify the posts configuration in `_cobalt.yml`:

```yaml
# Add or update these sections in _cobalt.yml
site:
  title: "Oxur"
  description: "Your site description"
  base_url: "https://oxur.li"

posts:
  title: "Blog"
  description: "Thoughts, tutorials, and updates from the Oxur project"
  dir: posts              # Where blog posts live
  drafts_dir: _drafts     # Where draft posts live
  order: Desc             # Newest first
  rss: blog.rss           # RSS feed location
  publish_date_in_filename: true
  default:
    layout: post.liquid
    excerpt_separator: "\n\n"
```

### Step 2: Create Directory Structure

Create these new directories:

```
src/
├── posts/                    # Published blog posts go here
├── _drafts/                  # Draft posts (not built by default)
├── blog/
│   ├── index.md             # Blog landing page
│   └── archives/
│       └── index.md         # Archives with pagination
├── _layouts/
│   ├── post.liquid          # Individual post template
│   ├── blog.liquid          # Blog landing page template
│   └── blog-archives.liquid # Archives template with pagination
├── _includes/
│   ├── post-card.liquid     # Reusable post card component
│   ├── pagination.liquid    # Pagination navigation component
│   └── post-meta.liquid     # Post metadata (date, tags, etc.)
├── _data/
│   └── featured_posts.json  # Manually curated featured posts list
```

---

## Part 3: Layout Templates

### 3.1 Post Layout (`src/_layouts/post.liquid`)

```liquid
{% include "head.liquid" %}
{% include "topbar.liquid" %}

<article class="prose prose-lg lg:prose-xl mx-auto px-4 py-8 max-w-4xl">
  <!-- Post Header -->
  <header class="mb-8 not-prose">
    <div class="breadcrumbs text-sm mb-4">
      <ul>
        <li><a href="/" class="link link-hover">Home</a></li>
        <li><a href="/blog/" class="link link-hover">Blog</a></li>
        <li>{{ page.title }}</li>
      </ul>
    </div>
    
    <h1 class="text-4xl lg:text-5xl font-bold mb-4">{{ page.title }}</h1>
    
    {% include "post-meta.liquid" %}
    
    {% if page.description %}
    <p class="text-xl text-base-content/70 mt-4">{{ page.description }}</p>
    {% endif %}
  </header>

  <!-- Post Content -->
  <div class="blog-content">
    {{ page.content }}
  </div>

  <!-- Post Footer -->
  <footer class="not-prose mt-12 pt-8 border-t border-base-300">
    <!-- Tags -->
    {% if page.tags.size > 0 %}
    <div class="mb-6">
      <span class="font-semibold mr-2">Tags:</span>
      {% for tag in page.tags %}
      <a href="/blog/tags/{{ tag | slugify }}/" class="badge badge-outline badge-lg mr-2 mb-2 hover:badge-primary">
        {{ tag }}
      </a>
      {% endfor %}
    </div>
    {% endif %}

    <!-- Navigation to other posts -->
    <div class="flex flex-col sm:flex-row justify-between gap-4 mt-8">
      <a href="/blog/" class="btn btn-outline">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
        </svg>
        Back to Blog
      </a>
    </div>
  </footer>
</article>

{% include "footer.liquid" %}
```

### 3.2 Blog Landing Page Layout (`src/_layouts/blog.liquid`)

```liquid
{% include "head.liquid" %}
{% include "topbar.liquid" %}

<main class="container mx-auto px-4 py-8 max-w-6xl">
  <!-- Hero Section -->
  <div class="hero bg-base-200 rounded-box mb-12 py-12">
    <div class="hero-content text-center">
      <div class="max-w-2xl">
        <h1 class="text-5xl font-bold">{{ page.title | default: "Blog" }}</h1>
        <p class="py-6 text-lg text-base-content/70">
          {{ page.description | default: "Thoughts, tutorials, and updates" }}
        </p>
      </div>
    </div>
  </div>

  {{ page.content }}
</main>

{% include "footer.liquid" %}
```

### 3.3 Blog Archives Layout with Pagination (`src/_layouts/blog-archives.liquid`)

```liquid
{% include "head.liquid" %}
{% include "topbar.liquid" %}

<main class="container mx-auto px-4 py-8 max-w-6xl">
  <div class="mb-8">
    <div class="breadcrumbs text-sm">
      <ul>
        <li><a href="/">Home</a></li>
        <li><a href="/blog/">Blog</a></li>
        <li>Archives</li>
      </ul>
    </div>
    <h1 class="text-4xl font-bold mt-4">Blog Archives</h1>
    <p class="text-base-content/70 mt-2">All posts, organized by date</p>
  </div>

  <!-- Posts List -->
  <div class="space-y-6">
    {% for post in paginator.pages %}
      {% include "post-card.liquid", post: post, style: "horizontal" %}
    {% endfor %}
  </div>

  <!-- Pagination -->
  {% include "pagination.liquid" %}
</main>

{% include "footer.liquid" %}
```

---

## Part 4: Reusable Components (Includes)

### 4.1 Post Card Component (`src/_includes/post-card.liquid`)

This component supports two styles: "card" (vertical) and "horizontal".

```liquid
{% comment %}
  Post Card Component
  
  Parameters:
    - post: The post object
    - style: "card" (default) or "horizontal"
    - show_excerpt: true/false (default: true)
{% endcomment %}

{% assign card_style = include.style | default: "card" %}
{% assign show_excerpt = include.show_excerpt | default: true %}

{% if card_style == "horizontal" %}
<!-- Horizontal Card Style -->
<article class="card card-side bg-base-100 shadow-md hover:shadow-lg transition-shadow">
  {% if post.data.image %}
  <figure class="w-48 shrink-0">
    <img src="{{ post.data.image }}" alt="{{ post.title }}" class="h-full object-cover" />
  </figure>
  {% endif %}
  <div class="card-body">
    <h2 class="card-title">
      <a href="/{{ post.permalink }}" class="link link-hover">{{ post.title }}</a>
    </h2>
    <div class="text-sm text-base-content/60 flex flex-wrap items-center gap-2">
      <time datetime="{{ post.published_date | date: '%Y-%m-%d' }}">
        {{ post.published_date | date: "%B %d, %Y" }}
      </time>
      {% if post.data.read_time %}
      <span class="badge badge-ghost badge-sm">{{ post.data.read_time }} min read</span>
      {% endif %}
    </div>
    {% if show_excerpt and post.excerpt %}
    <p class="text-base-content/70 mt-2">{{ post.excerpt | strip_html | truncate: 150 }}</p>
    {% endif %}
    <div class="card-actions justify-end mt-4">
      {% for tag in post.tags limit: 3 %}
      <span class="badge badge-outline badge-sm">{{ tag }}</span>
      {% endfor %}
    </div>
  </div>
</article>

{% else %}
<!-- Vertical Card Style (default) -->
<article class="card bg-base-100 shadow-md hover:shadow-lg transition-shadow">
  {% if post.data.image %}
  <figure>
    <img src="{{ post.data.image }}" alt="{{ post.title }}" class="w-full h-48 object-cover" />
  </figure>
  {% endif %}
  <div class="card-body">
    <h2 class="card-title">
      <a href="/{{ post.permalink }}" class="link link-hover">{{ post.title }}</a>
      {% if post.data.featured %}
      <span class="badge badge-secondary">Featured</span>
      {% endif %}
    </h2>
    <div class="text-sm text-base-content/60">
      <time datetime="{{ post.published_date | date: '%Y-%m-%d' }}">
        {{ post.published_date | date: "%B %d, %Y" }}
      </time>
    </div>
    {% if show_excerpt and post.excerpt %}
    <p class="text-base-content/70">{{ post.excerpt | strip_html | truncate: 120 }}</p>
    {% endif %}
    <div class="card-actions justify-end mt-2">
      {% for tag in post.tags limit: 2 %}
      <span class="badge badge-outline badge-sm">{{ tag }}</span>
      {% endfor %}
    </div>
  </div>
</article>
{% endif %}
```

### 4.2 Pagination Component (`src/_includes/pagination.liquid`)

Uses DaisyUI's `join` component for pagination buttons:

```liquid
{% if paginator.total_indexes > 1 %}
<nav class="flex justify-center mt-12" aria-label="Pagination">
  <div class="join">
    <!-- First Page -->
    {% if paginator.previous_index %}
    <a href="/{{ paginator.first_index_permalink }}" class="join-item btn" aria-label="First page">
      <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 19l-7-7 7-7m8 14l-7-7 7-7" />
      </svg>
    </a>
    {% endif %}
    
    <!-- Previous Page -->
    {% if paginator.previous_index %}
    <a href="/{{ paginator.previous_index_permalink }}" class="join-item btn" aria-label="Previous page">
      «
    </a>
    {% else %}
    <button class="join-item btn btn-disabled" aria-disabled="true">«</button>
    {% endif %}
    
    <!-- Current Page Indicator -->
    <button class="join-item btn btn-active">
      Page {{ paginator.index }} of {{ paginator.total_indexes }}
    </button>
    
    <!-- Next Page -->
    {% if paginator.next_index %}
    <a href="/{{ paginator.next_index_permalink }}" class="join-item btn" aria-label="Next page">
      »
    </a>
    {% else %}
    <button class="join-item btn btn-disabled" aria-disabled="true">»</button>
    {% endif %}
    
    <!-- Last Page -->
    {% if paginator.next_index %}
    <a href="/{{ paginator.last_index_permalink }}" class="join-item btn" aria-label="Last page">
      <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 5l7 7-7 7M5 5l7 7-7 7" />
      </svg>
    </a>
    {% endif %}
  </div>
</nav>
{% endif %}
```

### 4.3 Post Metadata Component (`src/_includes/post-meta.liquid`)

```liquid
<div class="flex flex-wrap items-center gap-4 text-base-content/60 text-sm">
  <!-- Date -->
  <div class="flex items-center gap-1">
    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
    </svg>
    <time datetime="{{ page.published_date | date: '%Y-%m-%d' }}">
      {{ page.published_date | date: "%B %d, %Y" }}
    </time>
  </div>
  
  <!-- Read Time (if available in frontmatter) -->
  {% if page.data.read_time %}
  <div class="flex items-center gap-1">
    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
    </svg>
    <span>{{ page.data.read_time }} min read</span>
  </div>
  {% endif %}
  
  <!-- Category (if available) -->
  {% if page.categories.size > 0 %}
  <div class="flex items-center gap-1">
    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z" />
    </svg>
    <span>{{ page.categories | join: " / " }}</span>
  </div>
  {% endif %}
</div>
```

---

## Part 5: Content Pages

### 5.1 Blog Landing Page (`src/blog/index.md`)

```markdown
---
title: Blog
description: Thoughts, tutorials, and updates from the Oxur project
layout: blog.liquid
permalink: blog/
---

<!-- Featured Posts Section -->
{% if site.data.featured_posts %}
<section class="mb-16">
  <h2 class="text-2xl font-bold mb-6 flex items-center gap-2">
    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-primary" fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z" />
    </svg>
    Featured Posts
  </h2>
  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
    {% for post_slug in site.data.featured_posts %}
      {% for post in collections.posts.pages %}
        {% if post.slug == post_slug %}
          {% include "post-card.liquid", post: post, style: "card" %}
        {% endif %}
      {% endfor %}
    {% endfor %}
  </div>
</section>
{% endif %}

<!-- Recent Posts Section -->
<section class="mb-16">
  <div class="flex justify-between items-center mb-6">
    <h2 class="text-2xl font-bold">Recent Posts</h2>
    <a href="/blog/archives/" class="btn btn-ghost btn-sm">
      View All
      <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 ml-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
      </svg>
    </a>
  </div>
  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
    {% for post in collections.posts.pages limit: 6 %}
      {% include "post-card.liquid", post: post, style: "card" %}
    {% endfor %}
  </div>
</section>

<!-- Categories/Tags Cloud (optional) -->
<section class="mb-16">
  <h2 class="text-2xl font-bold mb-6">Browse by Tag</h2>
  <div class="flex flex-wrap gap-2">
    {% assign all_tags = "" | split: "" %}
    {% for post in collections.posts.pages %}
      {% for tag in post.tags %}
        {% unless all_tags contains tag %}
          {% assign all_tags = all_tags | push: tag %}
        {% endunless %}
      {% endfor %}
    {% endfor %}
    {% for tag in all_tags %}
    <a href="/blog/tags/{{ tag | slugify }}/" class="badge badge-lg badge-outline hover:badge-primary transition-colors">
      {{ tag }}
    </a>
    {% endfor %}
  </div>
</section>
```

### 5.2 Blog Archives Page with Pagination (`src/blog/archives/index.md`)

```markdown
---
title: Blog Archives
description: All posts from the Oxur blog
layout: blog-archives.liquid
permalink: blog/archives/
pagination:
  include: All
  per_page: 10
  permalink_suffix: "./{{ num }}/"
  order: Desc
  sort_by: ["published_date"]
---
```

---

## Part 6: Featured Posts Data File

### `src/_data/featured_posts.json`

Create this file to manually curate which posts appear in the featured section:

```json
[
  "getting-started-with-oxur",
  "version-2-release",
  "performance-improvements"
]
```

These should match the `slug` of your posts (filename without date and extension).

---

## Part 7: Blog Post Template

### Example Post (`src/posts/2024-01-15-getting-started-with-oxur.md`)

```markdown
---
title: Getting Started with Oxur
description: A comprehensive guide to installing and using Oxur for the first time
published_date: 2024-01-15 10:00:00 -0500
layout: post.liquid
tags:
  - tutorial
  - getting-started
  - installation
categories:
  - Tutorials
data:
  image: /assets/images/blog/getting-started.png
  read_time: 8
  featured: true
---

This is the first paragraph which will be used as the excerpt. Keep it compelling!

## Introduction

Start your content here. The system supports full Markdown with:

- **Bold** and *italic* text
- [Links](https://example.com)
- Code blocks with syntax highlighting

### Code Example

```rust
fn main() {
    println!("Hello, Oxur!");
}
```

## Next Steps

Continue with more content...
```

---

## Part 8: Draft Posts

### Creating a Draft

There are two ways to create a draft post:

**Method 1: Using the `_drafts` folder**

Place the file in `src/_drafts/`:

```
src/_drafts/upcoming-feature-announcement.md
```

**Method 2: Using frontmatter**

Add `is_draft: true` to any post's frontmatter:

```markdown
---
title: Upcoming Feature Announcement
is_draft: true
published_date: 2024-02-01 10:00:00 -0500
layout: post.liquid
---
```

### Previewing Drafts Locally

Run Cobalt with the `--drafts` flag:

```bash
cobalt serve --drafts
```

Or for building:

```bash
cobalt build --drafts
```

**Important:** Drafts will NOT be included in production builds unless you explicitly use the `--drafts` flag.

---

## Part 9: DaisyUI Component Recommendations

Here are the recommended DaisyUI components for each blog feature:

### Blog Landing Page
| Feature | DaisyUI Component | Classes |
|---------|------------------|---------|
| Hero section | `hero` | `hero`, `hero-content`, `bg-base-200`, `rounded-box` |
| Post cards | `card` | `card`, `card-body`, `card-title`, `card-actions` |
| Tags | `badge` | `badge`, `badge-outline`, `badge-primary`, `badge-lg` |
| Call-to-action | `btn` | `btn`, `btn-primary`, `btn-ghost`, `btn-outline` |

### Blog Post Page
| Feature | DaisyUI Component | Classes |
|---------|------------------|---------|
| Breadcrumbs | `breadcrumbs` | `breadcrumbs`, `text-sm` |
| Tag display | `badge` | `badge`, `badge-outline` |
| Navigation | `btn` | `btn`, `btn-outline` |
| Content | Tailwind Typography | `prose`, `prose-lg`, `lg:prose-xl` |

### Archives/Pagination
| Feature | DaisyUI Component | Classes |
|---------|------------------|---------|
| Pagination | `join` | `join`, `join-item`, `btn`, `btn-active`, `btn-disabled` |
| Post list | `card` | `card`, `card-side` (horizontal layout) |
| Loading states | `skeleton` | `skeleton`, `h-32`, `w-full` |

### Common Patterns
| Feature | DaisyUI Component | Classes |
|---------|------------------|---------|
| Dark/light mode | `theme-controller` | Already in your theme toggle |
| Alerts/notices | `alert` | `alert`, `alert-info`, `alert-warning` |
| Dividers | `divider` | `divider` |
| Loading | `loading` | `loading`, `loading-spinner` |

---

## Part 10: CSS Additions

Add these to your `src/assets/css/main.css` or `src/styles/app.css`:

```css
/* Blog-specific styles */

/* Ensure prose content works well with DaisyUI themes */
.blog-content {
  @apply prose prose-lg max-w-none;
}

/* Style code blocks */
.blog-content pre {
  @apply rounded-box;
}

/* Style inline code */
.blog-content code:not(pre code) {
  @apply bg-base-200 px-1.5 py-0.5 rounded text-sm;
}

/* Post card hover effects */
.card:hover {
  @apply transform scale-[1.02] transition-transform duration-200;
}

/* Smooth transitions for theme switching */
article, .card, .hero {
  @apply transition-colors duration-200;
}

/* Better image handling in posts */
.blog-content img {
  @apply rounded-box shadow-md;
}

/* Block quotes styling */
.blog-content blockquote {
  @apply border-l-4 border-primary bg-base-200/50 rounded-r-box;
}
```

---

## Part 11: README Documentation

Add this section to your project README:

```markdown
## Blog

### Adding a New Blog Post

1. Create a new Markdown file in `src/posts/` with the format:
   ```
   YYYY-MM-DD-your-post-slug.md
   ```

2. Add the required frontmatter:
   ```yaml
   ---
   title: Your Post Title
   description: A brief description for SEO and previews
   published_date: YYYY-MM-DD HH:MM:SS -0500
   layout: post.liquid
   tags:
     - tag1
     - tag2
   categories:
     - Category Name
   data:
     image: /assets/images/blog/your-image.png  # optional
     read_time: 5  # optional, in minutes
     featured: false  # optional, set true for featured posts
   ---
   ```

3. Write your content in Markdown below the frontmatter.

### Creating Draft Posts

Draft posts won't be published to the live site. Two methods:

**Method 1:** Place the file in `src/_drafts/` instead of `src/posts/`

**Method 2:** Add `is_draft: true` to the frontmatter

### Previewing Drafts

```bash
cobalt serve --drafts
```

### Featuring Posts

Edit `src/_data/featured_posts.json` and add the post slug (filename without date and extension):

```json
[
  "your-post-slug",
  "another-featured-post"
]
```

### Building the Site

```bash
# Production build (excludes drafts)
cobalt build

# Development build (includes drafts)
cobalt build --drafts

# Local development server
cobalt serve --drafts
```
```

---

## Part 12: Implementation Checklist

Use this checklist to track progress:

### Configuration
- [ ] Update `_cobalt.yml` with posts configuration
- [ ] Create `src/posts/` directory
- [ ] Create `src/_drafts/` directory
- [ ] Create `src/_data/featured_posts.json`

### Layouts
- [ ] Create `src/_layouts/post.liquid`
- [ ] Create `src/_layouts/blog.liquid`
- [ ] Create `src/_layouts/blog-archives.liquid`

### Includes/Components
- [ ] Create `src/_includes/post-card.liquid`
- [ ] Create `src/_includes/pagination.liquid`
- [ ] Create `src/_includes/post-meta.liquid`

### Pages
- [ ] Create `src/blog/index.md`
- [ ] Create `src/blog/archives/index.md`

### Styling
- [ ] Add blog-specific CSS to stylesheets
- [ ] Verify DaisyUI components render correctly
- [ ] Test dark/light theme compatibility

### Content
- [ ] Create at least one sample blog post
- [ ] Create at least one draft post
- [ ] Add featured posts to data file

### Testing
- [ ] Test `cobalt build` (drafts excluded)
- [ ] Test `cobalt serve --drafts` (drafts included)
- [ ] Verify pagination works correctly
- [ ] Test on multiple screen sizes (responsive)
- [ ] Verify RSS feed generation

### Documentation
- [ ] Update README with blog instructions
- [ ] Document frontmatter options

---

## Part 13: Troubleshooting

### Common Issues

**Posts not appearing:**
- Ensure `published_date` is in the past
- Check `is_draft` is not set to `true`
- Verify the file is in `src/posts/` not `src/_drafts/`

**Pagination not working:**
- Ensure `pagination` block is properly formatted in frontmatter
- Check that `include: All` is set correctly

**Styling issues:**
- Make sure Tailwind/DaisyUI CSS is being loaded
- Check that `prose` classes are applied for content
- Verify theme variables are properly set

**Drafts showing in production:**
- Confirm build command doesn't include `--drafts` flag
- Check CI/CD configuration

---

## Summary

This guide provides everything needed to add a fully-featured blog to the oxur.li site while maintaining consistency with the existing design system. The implementation leverages:

- **Cobalt SSG** features: posts, drafts, pagination, RSS
- **Liquid templates** for reusable components
- **DaisyUI components** for consistent styling
- **Tailwind CSS** for responsive design

The modular approach with includes makes it easy to maintain and extend the blog functionality over time.
