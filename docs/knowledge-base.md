# Oxur Website Knowledge Base

This document captures important gotchas, workflows, and lessons learned while developing the Oxur website.

## Table of Contents

- [Project Setup](#project-setup)
- [Development Workflows](#development-workflows)
- [Cobalt SSG Gotchas](#cobalt-ssg-gotchas)
- [Template & Liquid Issues](#template--liquid-issues)
- [CSS Build System](#css-build-system)
- [Blog Post Management](#blog-post-management)
- [Deployment](#deployment)

---

## Project Setup

### Setting Up on a New Machine

When cloning the project to a new machine, follow these steps:

1. **Install dependencies:**

   ```bash
   make install
   ```

   This installs all npm dependencies needed for CSS compilation.

2. **Set up git worktree:**

   ```bash
   make setup
   ```

   This creates a git worktree at `build/` that tracks the `pages` branch. The worktree is essential for deployment.

3. **Verify installation:**

   ```bash
   make check
   ```

   Confirms that cobalt, npm, node, and git are all installed and accessible.

### Required Tools

- **cobalt** - Static site generator (install: `cargo install cobalt-bin`)
- **npm/node** - For CSS compilation with PostCSS and Tailwind
- **git** - For version control and worktree management

---

## Development Workflows

### Starting Development Server

```bash
make serve
```

This command:

- Cleans previous builds
- Compiles CSS to `src/assets/css/main.css` (dev location)
- Updates build info in `_cobalt.yml`
- Starts cobalt serve with drafts enabled

**Access at:** `http://<hostname>.local:5099`

### Watching CSS Changes

If you want to run CSS compilation separately:

```bash
make css-watch
```

This watches `src/styles/app.css` and recompiles to `src/assets/css/main.css` on changes.

### Full Development Mode

```bash
make dev
```

Runs both CSS watch and cobalt serve in parallel.

---

## Cobalt SSG Gotchas

### Critical: `cobalt serve` Uses Temp Directory

**The most important gotcha:**

When you run `cobalt serve`, Cobalt does **NOT** serve files from the `build/` directory. Instead, it:

1. Reads source files from `src/`
2. Builds to a **temporary directory**
3. Serves from that temp directory

**Implications:**

- CSS must be in `src/assets/css/main.css` for dev mode
- Changes to `build/` won't appear in the dev server
- Only `cobalt build` outputs to `build/`

### Dev vs Production Paths

| Mode | Command | CSS Output | Serves From |
|------|---------|------------|-------------|
| Development | `make serve` | `src/assets/css/main.css` | Temp directory |
| Production | `make build` | `build/assets/css/main.css` | `build/` (for deployment) |

---

## Template & Liquid Issues

### Indentation in Liquid Templates

**Problem:** Extra indentation in Liquid templates gets rendered as whitespace in the HTML output, causing visual formatting issues.

**Example of problematic code:**

```liquid
<div class="card">
  {% for post in collections.posts.pages %}
    {% include "post-card.liquid" %}
  {% endfor %}
</div>
```

**Solution:** Minimize indentation in Liquid loops and conditionals:

```liquid
<div class="card">
{% for post in collections.posts.pages %}
{% include "post-card.liquid" %}
{% endfor %}
</div>
```

### HTML in Liquid Variables

**Problem:** When passing HTML through Liquid variables (like in frontmatter), the HTML gets escaped.

**Example:**

```yaml
---
description: "Line one<br/>Line two"
---
```

When rendered with `{{ page.description }}`, the `<br/>` appears as text instead of creating a line break.

**Solution:** Hardcode HTML directly in templates instead of passing through variables:

```liquid
<p class="description">
  Line one<br/>Line two
</p>
```

---

## CSS Build System

### Dual Output Paths

The CSS build system has **two output paths**:

1. **Dev Output:** `src/assets/css/main.css`
   - Used by `cobalt serve`
   - Built by: `make build-css-dev` or `npm run css:build:dev`
   - Watched by: `npm run css:watch`

2. **Production Output:** `build/assets/css/main.css`
   - Used by deployment
   - Built by: `make build-css` or `npm run css:build`

### Why Two Paths?

Because `cobalt serve` serves from a temp directory (not `build/`), it needs CSS files in `src/` to include them in the temp build.

### CSS Not Rendering?

If CSS isn't rendering in dev mode:

1. Check if `src/assets/css/main.css` exists
2. Run `make build-css-dev` or `npm run css:build:dev`
3. Restart `make serve`

**Note:** The file `src/assets/css/main.css` is gitignored (it's generated), so you must build it after cloning.

---

## Blog Post Management

### Directory Structure

```
src/
├── posts/          # Published posts (will appear on site)
└── _drafts/        # Draft posts (only visible with --drafts flag)
```

### Creating a New Post

Use the `make draft` target to create a new draft post:

```bash
make draft TITLE="My Post Title"
```

This will:
- Generate a slug from the title (e.g., "My Post Title" → "my-post-title")
- Create a file with today's date: `YYYY-MM-DD-my-post-title.md`
- Add proper frontmatter (title, description, published_date, slug, layout, tags)
- Place it in `src/_drafts/`

You can then edit the file and view it with:

```bash
make serve  # Includes --drafts flag
```

### Publishing a Draft

Use the `make publish` target to move a draft to published posts:

```bash
make publish POST=my-post-title
```

This will:
- Find the draft matching the slug
- Move it from `src/_drafts/` to `src/posts/` using `git mv`
- Remind you to commit the change

**Note:** The POST parameter is the slug (not the full filename).

### Moving a Post Back to Drafts

Use the `make unpublish` target to unpublish a post:

```bash
make unpublish POST=my-post-title
```

This will:
- Find the post matching the slug
- Move it from `src/posts/` to `src/_drafts/` using `git mv`
- Remind you to commit the change

### Filename Convention

Blog post filenames **must** include the date: `YYYY-MM-DD-slug.md`

This is required because `_cobalt.yml` sets:

```yaml
posts:
  publish_date_in_filename: true
```

---

## Deployment

### Building for Production

```bash
make build
```

This:

1. Runs `make build-cobalt` (builds site to `build/`)
2. Runs `make build-css` (compiles CSS to `build/assets/css/main.css`)
3. Copies `src/CNAME` to `build/CNAME`
4. Shows build stats

### Deploying to GitHub/Codeberg Pages

```bash
make deploy
```

This:

1. Runs `make build`
2. Commits changes in the `build/` worktree (pages branch)
3. Pushes `pages` branch to both Codeberg and GitHub
4. Triggers Pages deployment

### Git Worktree Architecture

The project uses **two git branches**:

- **main branch:** Source code (templates, markdown, styles)
- **pages branch:** Built site (HTML, CSS, deployed to Pages)

The `build/` directory is a **git worktree** tracking the `pages` branch. This allows:

- Separate commit history for built artifacts
- Atomic deployments
- Clean separation of source and output

### Manual Deployment Steps

If `make deploy` fails:

```bash
# Build the site
make build

# Navigate to worktree
cd build

# Commit changes
git add -A
git commit -m "Site rebuild - $(date -u '+%Y-%m-%dT%H:%M:%SZ')"

# Push to remotes
git push codeberg pages
git push github pages

# Return to main branch
cd ..
```

---

## Additional Tips

### Checking Build Info

```bash
make info
```

Shows current configuration including paths, git info, and tool versions.

### Cleaning Build Artifacts

```bash
make clean       # Clean build artifacts and caches
make clean-css   # Clean only CSS files
make clean-all   # Deep clean including node_modules
```

### Hostname Normalization

The Makefile normalizes hostnames to always include `.local`:

```makefile
LOCALHOST := $(shell hostname | grep -q '\.local$' && hostname || echo "$(hostname).local")
```

This ensures `make serve` works consistently across different machines.

---

## Common Issues

### "CSS not found" on Remote Machine

**Symptom:** CSS works on one machine but 404s on another.

**Cause:** Missing `src/assets/css/main.css` (it's gitignored).

**Solution:**

```bash
make build-css-dev
make serve
```

### Templates Show Extra Whitespace

**Cause:** Indentation in Liquid templates.

**Solution:** Remove extra indentation around Liquid tags (see [Template Issues](#template--liquid-issues)).

### Changes Not Appearing in Dev Server

**Cause:** Editing files in `build/` instead of `src/`.

**Solution:** Always edit source files in `src/`. The `build/` directory is only for deployment.

### Worktree Setup Fails

**Symptom:** `make setup` fails with "worktree already exists" or similar.

**Solution:**

```bash
# Remove existing worktree
git worktree remove build
rm -rf build

# Re-run setup
make setup
```

---

## Quick Reference

### Daily Development

```bash
make serve        # Start dev server with drafts
# Edit files in src/
# View at http://<hostname>.local:5099
```

### Creating & Publishing Posts

```bash
# Create new draft
make draft TITLE="My New Post"

# Edit the draft
vim src/_drafts/2026-01-12-my-new-post.md

# Test with dev server
make serve

# Publish when ready
make publish POST=my-new-post
git commit -m "Published: My New Post"

# Or unpublish if needed
make unpublish POST=my-new-post
git commit -m "Unpublished: My New Post"
```

### Deployment

```bash
make build       # Test build locally
make deploy      # Deploy to GitHub/Codeberg Pages
make push        # Push source changes to remotes
```

---

*Last updated: 2026-01-12*
