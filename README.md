# Oxur Website

Official website for [Oxur](https://oxur.li) - a modern Lisp dialect for systems programming.

Built with [Cobalt](https://cobalt-org.github.io/) static site generator, [Tailwind CSS 4](https://tailwindcss.com/), and [DaisyUI 5](https://daisyui.com/).

## Prerequisites

- [Cobalt](https://cobalt-org.github.io/) - Static site generator
  ```bash
  cargo install cobalt-bin
  ```
- [Node.js](https://nodejs.org/) and npm - For CSS compilation
- Git - For version control

## Quick Start

```bash
# Install dependencies
npm install

# Start development server
make dev
# or: npm run dev

# Visit http://localhost:1024
```

## Development

The development workflow uses parallel processes for CSS watching and Cobalt serving:

```bash
make dev
```

This runs:
- Tailwind CSS watch mode (compiles CSS on file changes)
- Cobalt serve (rebuilds site on content changes)

The site will be available at http://localhost:1024 with live reload.

## Building

Build the production site:

```bash
make build
```

This compiles optimized CSS and builds the static site to `docs/`.

## Project Structure

```
.
├── src/                    # Source files
│   ├── _layouts/          # Liquid templates
│   ├── _includes/         # Reusable partials
│   ├── assets/            # Static assets (images, JS)
│   ├── styles/            # CSS source files
│   └── index.md           # Homepage content
├── docs/                   # Build output (GitHub Pages source)
├── site/                   # Original DaisyUI template reference
├── _cobalt.yml            # Cobalt configuration
├── package.json           # npm dependencies and scripts
├── postcss.config.js      # PostCSS configuration
└── Makefile               # Build automation
```

## Available Commands

Run `make help` to see all available commands. Key targets:

**Development:**
- `make dev` - Start development server (CSS watch + Cobalt serve)
- `make serve` - Serve site with Cobalt only
- `make css-watch` - Watch and compile CSS changes

**Building:**
- `make build` - Build production site (Cobalt + CSS)
- `make build-cobalt` - Build with Cobalt only
- `make build-css` - Compile CSS for production

**Cleaning:**
- `make clean` - Clean build artifacts
- `make clean-all` - Deep clean (includes node_modules)

**Git & Deployment:**
- `make status` - Show git status
- `make commit` - Stage and commit changes (interactive)
- `make push` - Push commits to origin
- `make deploy` - Build and deploy to GitHub Pages

**Validation:**
- `make check` - Check for required tools
- `make info` - Show build information

## Technology Stack

- **Static Site Generator:** [Cobalt](https://cobalt-org.github.io/) (Rust-based, uses Liquid templating)
- **CSS Framework:** [Tailwind CSS 4](https://tailwindcss.com/) (utility-first CSS)
- **Component Library:** [DaisyUI 5](https://daisyui.com/) (Tailwind components)
- **Icons:** [Iconify](https://iconify.design/) with Lucide icon set
- **Build Tool:** npm + PostCSS
- **Hosting:** GitHub Pages

## CSS Compilation

The project uses a dual-build strategy:

- **Development:** CSS builds to `src/assets/css/main.css` (Cobalt copies from source)
- **Production:** CSS builds to `docs/assets/css/main.css` (final output)

This allows `cobalt serve` to use the latest CSS without rebuilding the entire site.

## Deployment

The site deploys to GitHub Pages from the `docs/` directory:

```bash
make deploy
```

This builds the site, commits the `docs/` directory, and pushes to GitHub.

## License

MIT License - See the main [Oxur project](https://github.com/oxur) for details.

## Links

- Live Site: https://oxur.li
- Oxur GitHub: https://github.com/oxur
- Documentation: https://oxur.li/docs
