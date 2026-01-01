# Plan: Adapt DaisyUI Template for Cobalt Static Site

## Overview

Adapt the purchased DaisyUI/Tailwind template (located in `./site/`) to work with Cobalt, converting from Vite's build system to an integrated PostCSS + Cobalt workflow. Create a single-page landing site with Oxur branding.

## User Requirements

- **Site Structure**: Single-page landing (keep all sections on homepage)
- **Branding**: Replace "daisyAI" with "Oxur", adapt AI app content for Lisp language
- **CSS Build**: Integrate Tailwind CSS 4 compilation (NOT pre-compiled)
- **Reference**: Create `src/reference/` with copy of `site/html/*`

## Implementation Steps

### 1. Setup Build System (30 min)

**Create package.json in project root** with Tailwind CSS 4 + DaisyUI dependencies:

```json
{
  "name": "oxur-site",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "css:build": "postcss src/assets/css/app.css -o docs/assets/css/main.css",
    "css:watch": "postcss src/assets/css/app.css -o docs/assets/css/main.css --watch",
    "cobalt:build": "cobalt build",
    "cobalt:watch": "cobalt serve",
    "build": "npm run css:build && npm run cobalt:build",
    "dev": "npm-run-all --parallel css:watch cobalt:watch",
    "copy-reference": "cp -r site/html src/reference"
  },
  "devDependencies": {
    "@iconify-json/lucide": "^1.2.24",
    "@iconify/tailwind4": "^1.0.3",
    "@tailwindcss/postcss": "^4.0.3",
    "autoprefixer": "^10.4.20",
    "daisyui": "^5.0.0-beta.6",
    "npm-run-all": "^4.1.5",
    "postcss": "^8.4.49",
    "postcss-cli": "^11.0.0",
    "tailwindcss": "^4.0.3"
  }
}
```

**Create postcss.config.js**:

```js
export default {
  plugins: {
    '@tailwindcss/postcss': {},
    autoprefixer: {}
  }
}
```

**Run setup**:
```bash
npm install
npm run copy-reference
```

### 2. Create CSS Source Files (45 min)

**File: `src/assets/css/app.css`** - Copy from `site/src/styles/app.css`, preserve all content:
- Figtree font import
- Tailwind imports
- Iconify plugin config
- Custom utilities (container, brand-gradient)
- Bounce animation

**File: `src/assets/css/daisyui.css`** - Copy from `site/src/styles/daisyui.css`:
- Complete theme configuration (light/dark)
- Component customizations

**Test CSS compilation**:
```bash
npm run css:build
```
Verify `docs/assets/css/main.css` is created (~80-100KB).

### 3. Convert Layouts and Includes (60 min)

**File: `src/_layouts/landing.liquid`** - New layout for landing page:

```liquid
<!DOCTYPE html>
<html lang="en" class="group/html">
<head>
    {% include "head.liquid" %}
</head>
<body>
    {% include "topbar.liquid" %}

    <main>
        {{ page.content }}
    </main>

    {% include "footer.liquid" %}
    {% include "theme-toggle.liquid" %}

    <script src="/assets/js/main.js"></script>
</body>
</html>
```

**File: `src/_includes/head.liquid`** - Convert from `site/src/partials/head.html`:
- Update stylesheet path to `/assets/css/main.css`
- Keep Swiper CDN
- Use Liquid variables for title

**File: `src/_includes/topbar.liquid`** - Convert from `site/src/partials/topbar.html`:
- Replace "daisyAI" with "Oxur"
- Update nav: Home, Features, Docs, Download, GitHub
- Update links (anchor links use `/#section`, docs/download are pages)

**File: `src/_includes/footer.liquid`** - Convert from `site/src/partials/footer.html`:
- Adapt social links for Oxur (GitHub, Twitter, Email)
- Update footer columns: Language, Resources, Community, About
- Keep structure and styling

**File: `src/_includes/theme-toggle.liquid`** - Direct copy from `site/src/partials/theme-toggle.html` (no changes)

**Key conversions**:
- `<load src="partials/file.html" />` → `{% include "file.liquid" %}`
- Preserve all DaisyUI classes
- Keep responsive breakpoints

### 4. Adapt Homepage Content (90 min)

**File: `src/index.md`** - Rewrite with adapted sections from `site/src/index.html`:

**Frontmatter**:
```yaml
---
layout: landing.liquid
title: Home
description: Oxur - A modern, expressive Lisp dialect for systems programming
---
```

**Sections to include** (adapt HTML from template):

1. **Hero Section** (`id="home"`):
   - Replace "daisyAI" headline with "Oxur - A Modern Lisp..."
   - Replace app store buttons with "Download Oxur" and "Read the Docs" buttons
   - Replace mobile mockup with code example (use DaisyUI `mockup-code`)
   - Update stats cards: Fast, Expressive, Complete, Open (replace download metrics)

2. **Features Section** (`id="features"`):
   - "Why choose Oxur?"
   - 4 feature cards: High Performance, Powerful Macros, Modern Tooling, Well Documented
   - Replace AI features with language features

3. **FAQ Section** (`id="faq"`):
   - 6 questions about Oxur Lisp
   - Topics: What is Oxur, Comparison to other Lisps, Use cases, Production-ready, Contributing, License

4. **Download CTA Section** (`id="download"`):
   - Final call-to-action
   - Download and Documentation buttons

**Sections to REMOVE**:
- "How It Works" (AI-specific)
- "Organize" (app-specific)
- "Testimonials" (not applicable yet)

### 5. Update JavaScript (20 min)

**File: `src/assets/js/main.js`** - Copy from `site/public/js/app.js` and enhance:

```javascript
// Topbar scroll effect
const html = document.documentElement
const topbar = document.getElementById("layout-topbar")
if (topbar) {
    const handleScroll = () =>
        topbar.setAttribute("data-at-top", window.scrollY < 30 ? "true" : "false")
    window.addEventListener("scroll", handleScroll, { passive: true })
    handleScroll()
}

// Theme toggle with localStorage persistence
document.querySelectorAll("[data-theme-control]").forEach((control) => {
    control.addEventListener("click", () => {
        const theme = control.getAttribute("data-theme-control")
        if (theme === "system") {
            html.removeAttribute("data-theme")
            localStorage.removeItem("theme")
        } else {
            html.setAttribute("data-theme", theme)
            localStorage.setItem("theme", theme)
        }
    })
})

// Restore saved theme
const savedTheme = localStorage.getItem("theme")
if (savedTheme) html.setAttribute("data-theme", savedTheme)

// Smooth scroll for anchor links
document.querySelectorAll('a[href^="/#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        const targetId = this.getAttribute('href').slice(2)
        const targetElement = document.getElementById(targetId)
        if (targetElement) {
            e.preventDefault()
            targetElement.scrollIntoView({ behavior: 'smooth', block: 'start' })
            history.pushState(null, null, this.getAttribute('href'))
        }
    })
})
```

### 6. Migrate Assets (30 min)

**Copy images**:
```bash
cp -r site/public/images/* src/assets/images/
```

**Review and remove irrelevant images**:
- Remove: `logo/appstore.png`, `logo/playstore.png` (app store badges)
- Remove: `landing/mobile-*.png` (or replace with code examples)
- Keep: `landing/bg-gradient.png`, `favicon.ico`
- Remove: `avatar/*.png` (testimonial avatars - no testimonials section)

**Ensure CNAME exists**: `src/CNAME` with content `oxur.ελ`

### 7. Update Configuration (15 min)

**File: `_cobalt.yml`** - Add reference to ignore:

```yaml
ignore:
  - "*.swp"
  - "reference/**"  # Ignore reference copy
```

**File: `.gitignore`** - Add:

```
node_modules/
src/reference/
```

### 8. Testing and Validation (60 min)

**Build tests**:
```bash
# Test CSS compilation
npm run css:build

# Test Cobalt build
npm run cobalt:build

# Test full build
npm run build

# Verify CNAME
cat docs/CNAME
```

**Visual testing checklist**:
- [ ] Navigation: mobile drawer, all links work, topbar scroll effect
- [ ] Theme toggle: light/dark/system, localStorage persistence
- [ ] Layout: hero, stats cards, features grid, FAQ accordions
- [ ] Responsive: test at 375px, 768px, 1280px, 1920px
- [ ] No console errors
- [ ] Compare with `src/reference/index.html` for visual match

**Development workflow**:
```bash
npm run dev  # Runs CSS watch + Cobalt serve in parallel
```

### 9. Content Branding Pass (30 min)

**Global replacements**:
- "daisyAI" → "Oxur"
- "AI mobile app" → "Lisp programming language"
- "virtual assistant" → "programming language"

**Review all text content** for consistency and Oxur voice.

## Critical Files

### Must Create:
1. `package.json` - Build system, dependencies, npm scripts
2. `postcss.config.js` - PostCSS configuration
3. `src/assets/css/app.css` - Main CSS with Tailwind imports
4. `src/assets/css/daisyui.css` - Theme configuration
5. `src/_layouts/landing.liquid` - New landing page layout
6. `src/_includes/head.liquid` - Head partial
7. `src/_includes/topbar.liquid` - Navigation partial
8. `src/_includes/footer.liquid` - Footer partial
9. `src/_includes/theme-toggle.liquid` - Theme switcher

### Must Modify:
1. `src/index.md` - Rewrite with adapted content
2. `src/assets/js/main.js` - Update with template JavaScript
3. `_cobalt.yml` - Add reference to ignore
4. `.gitignore` - Add node_modules, src/reference

### Will Be Created by Scripts:
- `src/reference/` - Copy of `site/html/*` via `npm run copy-reference`
- `docs/assets/css/main.css` - Compiled CSS via PostCSS

## Build Process

**Development**:
```bash
npm run dev
```
- Runs Tailwind watch + Cobalt serve in parallel
- CSS auto-compiles on changes
- Site auto-rebuilds on Liquid/Markdown changes

**Production**:
```bash
npm run build
```
- Compiles CSS (minified)
- Builds Cobalt site to `docs/`
- Ready for GitHub Pages

## Key Technical Notes

1. **Tailwind CSS 4** uses `@import "tailwindcss"` in CSS (not separate config file)
2. **DaisyUI 5 beta** configured via `@plugin` syntax in `daisyui.css`
3. **Iconify** provides Lucide icons via Tailwind plugin
4. **Build order**: CSS must compile before Cobalt build (CSS referenced in HTML)
5. **Vite partials** (`<load src="..." />`) convert to Liquid includes (`{% include "..." %}`)

## Success Criteria

- [ ] `npm run build` completes without errors
- [ ] Visual design matches original template
- [ ] All interactive features work (nav, theme toggle, smooth scroll)
- [ ] Responsive at all breakpoints
- [ ] "daisyAI" fully replaced with "Oxur"
- [ ] GitHub Pages deployment works
- [ ] CNAME preserved in `docs/`

## Estimated Time

Total: 6-8 hours

This plan provides a complete roadmap for converting the DaisyUI/Tailwind template to work with Cobalt while maintaining all visual design and interactivity.
