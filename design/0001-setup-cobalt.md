# Cobalt Static Site Generator Setup Instructions

## Overview

These instructions guide you through setting up a Cobalt-based static site for the Oxur Lisp language website. The site will be hosted on GitHub Pages using the custom domain `oxur.ελ`.

## Repository Information

- **Repo**: https://github.com/oxur/oxur.github.io
- **Current files**: CNAME, LICENSE
- **Domain**: oxur.ελ
- **Template**: DaisyUI Mobile App Landing Page (Tailwind CSS + DaisyUI)

## Prerequisites

1. Rust and Cargo installed
2. Git configured and authenticated
3. Access to the oxur/oxur.github.io repository

## Installation Steps

### 1. Install Cobalt

```bash
cargo install cobalt-bin
```

Verify installation:
```bash
cobalt --version
```

### 2. Clone the Repository

```bash
git clone https://github.com/oxur/oxur.github.io.git
cd oxur.github.io
```

### 3. Initialize Cobalt Structure

Create the basic Cobalt directory structure:

```bash
# Create directories
mkdir -p _layouts
mkdir -p _includes
mkdir -p _data
mkdir -p _sass
mkdir -p posts
mkdir -p assets/css
mkdir -p assets/js
mkdir -p assets/img

# Create config file
cat > _cobalt.yml << 'EOF'
site:
  title: "Oxur Lisp"
  description: "A modern Lisp dialect"
  base_url: "https://oxur.ελ"
  
# Markdown settings
markdown:
  syntax_highlight: true
  
# Build settings
dest: _site
ignore:
  - "*.swp"
  - ".git"
  - "README.md"
  - "COBALT_SETUP.md"

# Permalinks
posts:
  dir: posts
  
# Assets to copy
assets:
  sass:
    style: compressed
EOF
```

### 4. Create Initial Layouts

**Main layout** (`_layouts/default.liquid`):

```liquid
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ page.title }} | {{ site.title }}</title>
    <meta name="description" content="{{ page.description | default: site.description }}">
    
    <!-- Tailwind CSS CDN (temporary - replace with your purchased template) -->
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.4.19/dist/full.min.css" rel="stylesheet" type="text/css" />
    <script src="https://cdn.tailwindcss.com"></script>
    
    <!-- Custom styles -->
    <link rel="stylesheet" href="/assets/css/main.css">
</head>
<body>
    {% include header.liquid %}
    
    <main>
        {{ page.content }}
    </main>
    
    {% include footer.liquid %}
    
    <script src="/assets/js/main.js"></script>
</body>
</html>
```

### 5. Create Includes

**Header** (`_includes/header.liquid`):

```liquid
<header class="navbar bg-base-100 shadow-lg">
    <div class="flex-1">
        <a href="/" class="btn btn-ghost text-xl">{{ site.title }}</a>
    </div>
    <div class="flex-none">
        <ul class="menu menu-horizontal px-1">
            <li><a href="/">Home</a></li>
            <li><a href="/docs">Documentation</a></li>
            <li><a href="/download">Download</a></li>
            <li><a href="https://github.com/oxur/oxur">GitHub</a></li>
        </ul>
    </div>
</header>
```

**Footer** (`_includes/footer.liquid`):

```liquid
<footer class="footer footer-center p-10 bg-base-200 text-base-content rounded">
    <div>
        <p>Copyright © {{ "now" | date: "%Y" }} Oxur Lisp Project</p>
        <p>Built with <a href="https://cobalt-org.github.io/" class="link">Cobalt</a></p>
    </div>
</footer>
```

### 6. Create Homepage

**Homepage** (`index.md`):

```markdown
---
layout: default.liquid
title: Home
description: Oxur - A modern Lisp dialect
---

# Welcome to Oxur Lisp

Oxur is a modern, efficient Lisp dialect designed for [add your key features here].

## Features

- **Modern syntax**: Clean and expressive
- **High performance**: Built with Rust
- **Easy to learn**: Comprehensive documentation
- **Powerful**: [Add key capabilities]

## Quick Start

```lisp
;; Your first Oxur program
(println "Hello, Oxur!")
```

## Get Started

[Download Oxur](/download) or check out the [documentation](/docs).
```

### 7. Create Additional Pages

**Documentation page** (`docs.md`):

```markdown
---
layout: default.liquid
title: Documentation
---

# Documentation

Documentation coming soon!
```

**Download page** (`download.md`):

```markdown
---
layout: default.liquid
title: Download
---

# Download Oxur

Download instructions coming soon!
```

### 8. Create Assets

**Main CSS** (`assets/css/main.css`):

```css
/* Custom styles for Oxur site */
/* This will be supplemented by your purchased DaisyUI template */

:root {
  --oxur-primary: #3b82f6;
}

/* Add your custom styles here */
```

**Main JS** (`assets/js/main.js`):

```javascript
// Custom JavaScript for Oxur site
console.log('Oxur site loaded');
```

### 9. Update .gitignore

Create/update `.gitignore`:

```
_site/
.cobalt/
*.swp
.DS_Store
```

### 10. Build and Test Locally

```bash
# Build the site
cobalt build

# Serve with live reload
cobalt serve
```

Visit `http://localhost:3000` to preview your site.

### 11. Set Up GitHub Pages Deployment

**Option A: GitHub Actions (Recommended)**

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        
      - name: Setup Rust
        uses: dtolnay/rust-toolchain@stable
        
      - name: Install Cobalt
        run: cargo install cobalt-bin
        
      - name: Build site
        run: cobalt build
        
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./_site

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

**Option B: Manual Deployment**

```bash
# Build the site
cobalt build

# Push _site contents to gh-pages branch
git checkout --orphan gh-pages
git rm -rf .
cp -r _site/* .
rm -rf _site
git add .
git commit -m "Deploy site"
git push origin gh-pages --force
git checkout main
```

### 12. Configure GitHub Pages

1. Go to repository Settings → Pages
2. Set source to:
   - **GitHub Actions** (if using Option A)
   - **Deploy from branch: gh-pages** (if using Option B)
3. Verify CNAME file contains: `oxur.ελ`

### 13. Integrate Your Purchased Template

Once you have the DaisyUI template:

1. Extract the template files
2. Copy HTML structure to `_layouts/default.liquid`
3. Copy CSS to `assets/css/` or `_sass/`
4. Copy JS to `assets/js/`
5. Copy images to `assets/img/`
6. Update references in the layout files
7. Convert template sections to Liquid includes as needed

### 14. Development Workflow

```bash
# Start development server
cobalt serve

# Build for production
cobalt build

# Clean build artifacts
rm -rf _site
```

## Directory Structure Reference

```
oxur.github.io/
├── _cobalt.yml           # Site configuration
├── _layouts/             # Page templates
│   └── default.liquid
├── _includes/            # Reusable components
│   ├── header.liquid
│   └── footer.liquid
├── _data/                # Data files (JSON, YAML)
├── _sass/                # Sass files (optional)
├── _site/                # Generated site (gitignored)
├── assets/
│   ├── css/
│   ├── js/
│   └── img/
├── posts/                # Blog posts (optional)
├── .github/
│   └── workflows/
│       └── deploy.yml
├── index.md              # Homepage
├── docs.md               # Documentation page
├── download.md           # Download page
├── CNAME                 # Custom domain
├── LICENSE
└── .gitignore
```

## Liquid Templating Basics

Cobalt uses Liquid for templating. Here are key concepts:

**Variables:**
```liquid
{{ page.title }}
{{ site.description }}
{{ page.content }}
```

**Conditionals:**
```liquid
{% if page.featured %}
  <span class="badge">Featured</span>
{% endif %}
```

**Loops:**
```liquid
{% for post in collections.posts.pages %}
  <h2>{{ post.title }}</h2>
{% endfor %}
```

**Includes:**
```liquid
{% include header.liquid %}
```

**Filters:**
```liquid
{{ "now" | date: "%Y-%m-%d" }}
{{ page.title | upcase }}
```

## Troubleshooting

**Site not building:**
- Check `_cobalt.yml` syntax
- Verify all front matter is valid YAML
- Look for Liquid syntax errors

**Assets not loading:**
- Check asset paths start with `/`
- Verify files are in the correct directories
- Check `_cobalt.yml` ignore list

**GitHub Pages not updating:**
- Check GitHub Actions logs
- Verify gh-pages branch exists (if using Option B)
- Check Pages settings in repository

## Resources

- [Cobalt Documentation](https://cobalt-org.github.io/docs/)
- [Liquid Documentation](https://shopify.github.io/liquid/)
- [DaisyUI Components](https://daisyui.com/components/)
- [Tailwind CSS Docs](https://tailwindcss.com/docs)

## Next Steps

1. Install Cobalt
2. Initialize the directory structure
3. Test locally with `cobalt serve`
4. Set up GitHub Actions workflow
5. Integrate your purchased template
6. Create actual content (docs, examples, etc.)
7. Configure custom domain DNS
8. Deploy!

Good luck with the Oxur website! 🦎
