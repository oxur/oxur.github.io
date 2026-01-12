# Makefile for Oxur Website

# ANSI color codes
BLUE := \033[1;34m
GREEN := \033[1;32m
YELLOW := \033[1;33m
RED := \033[1;31m
CYAN := \033[1;36m
RESET := \033[0m

# Variables
SITE_NAME := Oxur Lisp
SITE_URL := https://oxur.li
BACKUP_SITE_URL := https://oxur.codeberg.page/
FUN_SITE_URL := https://oxur.ελ
BUILD_TIME := $(shell date -u '+%Y-%m-%dT%H:%M:%SZ')
GIT_COMMIT := $(shell git rev-parse --short HEAD 2>/dev/null || echo "unknown")
GIT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")
PUBLISH_BRANCH := pages
CODE_BRANCH := $(GIT_BRANCH)
NPM := npm
COBALT := cobalt
SOURCE_DIR := src
DEST_DIR := build
CSS_SOURCE := $(SOURCE_DIR)/styles/app.css
CSS_OUTPUT_DEV := $(SOURCE_DIR)/assets/css/main.css
CSS_OUTPUT_PROD := $(DEST_DIR)/assets/css/main.css
LOCALHOST := $(shell hostname | grep -q '\.local$$' && hostname || echo "$$(hostname).local")
LOCALPORT := 5099

# Default target
.DEFAULT_GOAL := help

# Help target
.PHONY: help
help:
	@echo ""
	@echo "$(CYAN)╔══════════════════════════════════════════════════════════╗$(RESET)"
	@echo "$(CYAN)║$(RESET)  $(BLUE)$(SITE_NAME) - Website Build System$(RESET)                        $(CYAN)║$(RESET)"
	@echo "$(CYAN)╚══════════════════════════════════════════════════════════╝$(RESET)"
	@echo ""
	@echo "$(GREEN)Development:$(RESET)"
	@echo "  $(YELLOW)make dev$(RESET)              - Start development server (CSS watch + Cobalt serve)"
	@echo "  $(YELLOW)make serve$(RESET)            - Serve site with Cobalt (localhost:1024)"
	@echo "  $(YELLOW)make css-watch$(RESET)        - Watch and compile CSS changes"
	@echo ""
	@echo "$(GREEN)Building:$(RESET)"
	@echo "  $(YELLOW)make build$(RESET)            - Build production site (Cobalt + CSS)"
	@echo "  $(YELLOW)make build-cobalt$(RESET)     - Build with Cobalt only"
	@echo "  $(YELLOW)make build-css$(RESET)        - Compile CSS"
	@echo ""
	@echo "$(GREEN)Cleaning:$(RESET)"
	@echo "  $(YELLOW)make clean$(RESET)            - Clean build artifacts and caches"
	@echo "  $(YELLOW)make clean-all$(RESET)        - Clean everything including node_modules"
	@echo "  $(YELLOW)make clean-css$(RESET)        - Clean generated CSS files"
	@echo ""
	@echo "$(GREEN)Dependencies:$(RESET)"
	@echo "  $(YELLOW)make install$(RESET)          - Install npm dependencies"
	@echo "  $(YELLOW)make update$(RESET)           - Update npm dependencies"
	@echo "  $(YELLOW)make copy-reference$(RESET)   - Copy template reference to src/reference"
	@echo ""
	@echo "$(GREEN)Git & Deployment:$(RESET)"
	@echo "  $(YELLOW)make status$(RESET)           - Show git status"
	@echo "  $(YELLOW)make commit$(RESET)           - Stage changes and commit (interactive)"
	@echo "  $(YELLOW)make push$(RESET)             - Push commits to origin"
	@echo "  $(YELLOW)make deploy$(RESET)           - Build and push to GitHub (triggers deployment)"
	@echo "  $(YELLOW)make tag VERSION=x.y.z$(RESET) - Create and push git tag"
	@echo ""
	@echo "$(GREEN)Blog Management:$(RESET)"
	@echo "  $(YELLOW)make draft TITLE='...'$(RESET) - Create a new draft post"
	@echo "  $(YELLOW)make publish POST=slug$(RESET) - Move draft to published posts"
	@echo "  $(YELLOW)make unpublish POST=slug$(RESET) - Move post back to drafts"
	@echo "  $(YELLOW)make show-drafts$(RESET)       - List draft posts (newest first)"
	@echo "  $(YELLOW)make show-posts$(RESET)        - List published posts (newest first)"
	@echo ""
	@echo "$(GREEN)Validation:$(RESET)"
	@echo "  $(YELLOW)make check$(RESET)            - Check for required tools"
	@echo "  $(YELLOW)make info$(RESET)             - Show build information"
	@echo ""
	@echo "$(CYAN)Current status:$(RESET) Branch: $(GIT_BRANCH) | Commit: $(GIT_COMMIT)"
	@echo ""

# Development targets
.PHONY: dev
dev:
	@echo "$(BLUE)Starting development server...$(RESET)"
	@echo "$(CYAN)• CSS watch + Cobalt serve$(RESET)"
	@echo "$(GREEN)→ Site will be available at http://localhost:1024$(RESET)"
	@$(NPM) run dev

.PHONY: serve
serve: clean build-css-dev
	@echo "$(BLUE)Updating build info...$(RESET)"
	@sed -i '' "s/    commit_id: \".*\"/    commit_id: \"$(GIT_COMMIT)\"/" _cobalt.yml
	@sed -i '' "s/    build_time: \".*\"/    build_time: \"$(BUILD_TIME)\"/" _cobalt.yml
	@echo "$(BLUE)Starting Cobalt server (with drafts)...$(RESET)"
	@echo "$(GREEN)→ Serving from $(SOURCE_DIR)/ at http://$(LOCALHOST):$(LOCALPORT)$(RESET)"
	@$(COBALT) serve --host $(LOCALHOST) --port $(LOCALPORT) --drafts

.PHONY: css-watch
css-watch:
	@echo "$(BLUE)Watching CSS files for changes...$(RESET)"
	@echo "$(CYAN)• Source: $(CSS_SOURCE)$(RESET)"
	@echo "$(CYAN)• Output: $(CSS_OUTPUT_DEV)$(RESET)"
	@$(NPM) run css:watch

# Build targets
.PHONY: build
build: build-cobalt build-css
	@cp $(SOURCE_DIR)/CNAME $(DEST_DIR)/CNAME
	@echo "$(GREEN)✓ Production build complete$(RESET)"
	@echo "$(CYAN)• Output directory: $(DEST_DIR)/$(RESET)"
	@echo "$(CYAN)• CSS size: $$(du -h $(CSS_OUTPUT_PROD) | cut -f1)$(RESET)"
	@echo "$(CYAN)• Total size: $$(du -sh $(DEST_DIR) | cut -f1)$(RESET)"

.PHONY: build-cobalt
build-cobalt:
	@echo "$(BLUE)Updating build info...$(RESET)"
	@sed -i '' "s/    commit_id: \".*\"/    commit_id: \"$(GIT_COMMIT)\"/" _cobalt.yml
	@sed -i '' "s/    build_time: \".*\"/    build_time: \"$(BUILD_TIME)\"/" _cobalt.yml
	@echo "$(BLUE)Building site with Cobalt...$(RESET)"
	@echo "$(CYAN)• Source: $(SOURCE_DIR)/$(RESET)"
	@echo "$(CYAN)• Destination: $(DEST_DIR)/$(RESET)"
	@$(COBALT) build
	@echo "$(GREEN)✓ Cobalt build complete$(RESET)"

.PHONY: build-css
build-css:
	@echo "$(BLUE)Compiling CSS for production...$(RESET)"
	@echo "$(CYAN)• Source: $(CSS_SOURCE)$(RESET)"
	@echo "$(CYAN)• Output: $(CSS_OUTPUT_PROD)$(RESET)"
	@$(NPM) run css:build
	@echo "$(GREEN)✓ CSS compilation complete$(RESET)"

.PHONY: build-css-dev
build-css-dev:
	@echo "$(BLUE)Compiling CSS for dev...$(RESET)"
	@echo "$(CYAN)• Source: $(CSS_SOURCE)$(RESET)"
	@echo "$(CYAN)• Output: $(CSS_OUTPUT_DEV)$(RESET)"
	@$(NPM) run css:build:dev
	@echo "$(GREEN)✓ CSS compilation complete$(RESET)"

# Cleaning targets
.PHONY: clean
clean:
	@echo "$(BLUE)Cleaning build artifacts...$(RESET)"
	@rm -rf $(DEST_DIR)/*.html
	@rm -rf $(DEST_DIR)/assets/*.css $(DEST_DIR)/assets/*.js
	@rm -rf .cobalt/
	@echo "$(GREEN)✓ Clean complete$(RESET)"

.PHONY: clean-css
clean-css:
	@echo "$(BLUE)Cleaning generated CSS files...$(RESET)"
	@rm -f $(CSS_OUTPUT_DEV)
	@rm -f $(CSS_OUTPUT_PROD)
	@rm -f $(DEST_DIR)/assets/css/app.css $(DEST_DIR)/assets/css/daisyui.css
	@echo "$(GREEN)✓ CSS files cleaned$(RESET)"

.PHONY: clean-all
clean-all: clean clean-css
	@echo "$(BLUE)Removing node_modules and reference...$(RESET)"
	@rm -rf node_modules/
	@rm -rf $(SOURCE_DIR)/reference/
	@echo "$(GREEN)✓ Deep clean complete$(RESET)"

# Dependency targets
.PHONY: install
install:
	@echo "$(BLUE)Installing npm dependencies...$(RESET)"
	@$(NPM) install
	@echo "$(GREEN)✓ Dependencies installed$(RESET)"

.PHONY: update
update:
	@echo "$(BLUE)Updating npm dependencies...$(RESET)"
	@$(NPM) update
	@echo "$(GREEN)✓ Dependencies updated$(RESET)"

.PHONY: setup
setup: install
	@echo "$(BLUE)Setting up worktree...$(RESET)"
	@git fetch origin
	@if [ ! -d "$(DEST_DIR)/.git" ]; then \
		if [ -d "$(DEST_DIR)" ]; then \
			echo "$(YELLOW)Removing existing build directory...$(RESET)"; \
			rm -rf $(DEST_DIR); \
		fi; \
		git worktree add $(DEST_DIR) pages && \
		echo "$(GREEN)✓ Worktree created$(RESET)"; \
	else \
		echo "$(YELLOW)Worktree already exists$(RESET)"; \
	fi
.PHONY: copy-reference
copy-reference:
	@echo "$(BLUE)Copying template reference...$(RESET)"
	@$(NPM) run copy-reference
	@echo "$(GREEN)✓ Reference copied to $(SOURCE_DIR)/reference/$(RESET)"

# Git targets
.PHONY: status
status:
	@echo "$(BLUE)Git status:$(RESET)"
	@git status

.PHONY: commit
commit:
	@echo "$(BLUE)Staging and committing changes...$(RESET)"
	@git add -A
	@echo "$(YELLOW)Enter commit message:$(RESET)"
	@read -p "> " msg; \
	git commit -m "$$msg"
	@echo "$(GREEN)✓ Changes committed$(RESET)"

.PHONY: push
push:
	@echo "$(BLUE)Pushing changes ...$(RESET)"
	@echo "$(CYAN)• Codeberg:$(RESET)"
	@git push codeberg $(CODE_BRANCH) && git push codeberg --tags
	@echo "$(GREEN)✓ Pushed$(RESET)"
	@echo "$(CYAN)• Github:$(RESET)"
	@git push github $(CODE_BRANCH) && git push github --tags
	@echo "$(GREEN)✓ Pushed$(RESET)"

.PHONY: deploy
deploy: build
	@echo "$(BLUE)Deploying site...$(RESET)"
	@echo "$(CYAN)Updating git worktree $(DEST_DIR) dir for $(PUBLISH_BRANCH) branch ...$(RESET)"
	@cd $(DEST_DIR) && \
	git add -A && \
	(git commit -m "Site rebuild - $(BUILD_TIME)" || echo "$(YELLOW)No changes to commit$(RESET)")
	@git checkout _cobalt.yml
	@echo "$(CYAN)• Codeberg:$(RESET)"
	@git push codeberg $(PUBLISH_BRANCH)
	@echo "$(GREEN)✓ Published$(RESET)"
	@echo "$(CYAN)• Github:$(RESET)"
	@git push github $(PUBLISH_BRANCH)
	@echo "$(GREEN)✓ Published$(RESET)"
	@echo "$(GREEN)✓ Deployment complete$(RESET)"
	@echo "$(CYAN)→ Site should now be live at$(RESET) $(BLUE)$(FUN_SITE_URL)$(RESET) $(CYAN)and$(RESET):"
	@echo "$(CYAN)• Codeberg: $(RESET)$(BLUE)$(BACKUP_SITE_URL)$(RESET)"
	@echo "$(CYAN)• Github: $(RESET)$(BLUE)$(SITE_URL)$(RESET)"

.PHONY: tag
tag:
	@if [ -z "$(VERSION)" ]; then \
		echo "$(RED)Error: VERSION not specified$(RESET)"; \
		echo "$(YELLOW)Usage: make tag VERSION=x.y.z$(RESET)"; \
		exit 1; \
	fi
	@echo "$(BLUE)Creating tag v$(VERSION)...$(RESET)"
	@git tag -a v$(VERSION) -m "Release v$(VERSION) - $(BUILD_TIME)"
	@echo "$(YELLOW)Pushing tag to origin...$(RESET)"
	@git push origin v$(VERSION)
	@echo "$(GREEN)✓ Tag v$(VERSION) created and pushed$(RESET)"

# Blog management targets
.PHONY: draft
draft:
	@if [ -z "$(TITLE)" ]; then \
		echo "$(RED)Error: TITLE not specified$(RESET)"; \
		echo "$(YELLOW)Usage: make draft TITLE='My Post Title'$(RESET)"; \
		exit 1; \
	fi
	@echo "$(BLUE)Creating new draft post...$(RESET)"
	@SLUG=$$(echo "$(TITLE)" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//' | sed 's/-$$//'); \
	DATE=$$(date '+%Y-%m-%d'); \
	FILENAME="$$DATE-$$SLUG.md"; \
	if [ -f "$(SOURCE_DIR)/_drafts/$$FILENAME" ]; then \
		echo "$(RED)Error: Draft already exists: $$FILENAME$(RESET)"; \
		exit 1; \
	fi; \
	echo "---" > "$(SOURCE_DIR)/_drafts/$$FILENAME"; \
	echo "title: \"$(TITLE)\"" >> "$(SOURCE_DIR)/_drafts/$$FILENAME"; \
	echo "description: \"\"" >> "$(SOURCE_DIR)/_drafts/$$FILENAME"; \
	echo "published_date: \"$$(date -u '+%Y-%m-%d %H:%M:%S +0000')\"" >> "$(SOURCE_DIR)/_drafts/$$FILENAME"; \
	echo "slug: $$SLUG" >> "$(SOURCE_DIR)/_drafts/$$FILENAME"; \
	echo "layout: post.liquid" >> "$(SOURCE_DIR)/_drafts/$$FILENAME"; \
	echo "tags:" >> "$(SOURCE_DIR)/_drafts/$$FILENAME"; \
	echo "  - rust" >> "$(SOURCE_DIR)/_drafts/$$FILENAME"; \
	echo "---" >> "$(SOURCE_DIR)/_drafts/$$FILENAME"; \
	echo "" >> "$(SOURCE_DIR)/_drafts/$$FILENAME"; \
	echo "Your content here..." >> "$(SOURCE_DIR)/_drafts/$$FILENAME"; \
	git add "$(SOURCE_DIR)/_drafts/$$FILENAME"; \
	echo "$(GREEN)✓ Created draft: $(CYAN)$$FILENAME$(RESET)"; \
	echo "$(YELLOW)→ Edit at: $(CYAN)$(SOURCE_DIR)/_drafts/$$FILENAME$(RESET)"; \
	echo "$(YELLOW)→ Don't forget to commit the change$(RESET)"

.PHONY: publish
publish:
	@if [ -z "$(POST)" ]; then \
		echo "$(RED)Error: POST not specified$(RESET)"; \
		echo "$(YELLOW)Usage: make publish POST=my-post-slug$(RESET)"; \
		exit 1; \
	fi
	@echo "$(BLUE)Publishing draft...$(RESET)"
	@DRAFT=$$(find $(SOURCE_DIR)/_drafts -name "*$(POST).md" 2>/dev/null | head -1); \
	if [ -z "$$DRAFT" ]; then \
		echo "$(RED)Error: Draft not found matching '$(POST)'$(RESET)"; \
		echo "$(YELLOW)Available drafts:$(RESET)"; \
		ls -1 $(SOURCE_DIR)/_drafts/*.md 2>/dev/null | xargs -n1 basename | sed 's/^/  /' || echo "  (none)"; \
		exit 1; \
	fi; \
	FILENAME=$$(basename "$$DRAFT"); \
	if [ -f "$(SOURCE_DIR)/posts/$$FILENAME" ]; then \
		echo "$(RED)Error: Post already exists: $$FILENAME$(RESET)"; \
		exit 1; \
	fi; \
	echo "$(CYAN)• Moving $$FILENAME to posts/$(RESET)"; \
	git mv "$$DRAFT" "$(SOURCE_DIR)/posts/$$FILENAME" && \
	echo "$(GREEN)✓ Published: $(CYAN)$$FILENAME$(RESET)" && \
	echo "$(YELLOW)→ Don't forget to commit the change$(RESET)"

.PHONY: unpublish
unpublish:
	@if [ -z "$(POST)" ]; then \
		echo "$(RED)Error: POST not specified$(RESET)"; \
		echo "$(YELLOW)Usage: make unpublish POST=my-post-slug$(RESET)"; \
		exit 1; \
	fi
	@echo "$(BLUE)Moving post to drafts...$(RESET)"
	@POST_FILE=$$(find $(SOURCE_DIR)/posts -name "*$(POST).md" 2>/dev/null | head -1); \
	if [ -z "$$POST_FILE" ]; then \
		echo "$(RED)Error: Post not found matching '$(POST)'$(RESET)"; \
		echo "$(YELLOW)Available posts:$(RESET)"; \
		ls -1 $(SOURCE_DIR)/posts/*.md 2>/dev/null | xargs -n1 basename | sed 's/^/  /' || echo "  (none)"; \
		exit 1; \
	fi; \
	FILENAME=$$(basename "$$POST_FILE"); \
	if [ -f "$(SOURCE_DIR)/_drafts/$$FILENAME" ]; then \
		echo "$(RED)Error: Draft already exists: $$FILENAME$(RESET)"; \
		exit 1; \
	fi; \
	echo "$(CYAN)• Moving $$FILENAME to _drafts/$(RESET)"; \
	git mv "$$POST_FILE" "$(SOURCE_DIR)/_drafts/$$FILENAME" && \
	echo "$(GREEN)✓ Moved to drafts: $(CYAN)$$FILENAME$(RESET)" && \
	echo "$(YELLOW)→ Don't forget to commit the change$(RESET)"

.PHONY: show-drafts
show-drafts:
	@echo "$(BLUE)Draft posts (newest first):$(RESET)"
	@if [ -d "$(SOURCE_DIR)/_drafts" ] && [ -n "$$(ls -A $(SOURCE_DIR)/_drafts/*.md 2>/dev/null)" ]; then \
		MAX_LEN=0; \
		for file in $$(ls -r $(SOURCE_DIR)/_drafts/*.md 2>/dev/null); do \
			NAME_LEN=$$(basename "$$file" .md | awk '{print length}'); \
			[ $$NAME_LEN -gt $$MAX_LEN ] && MAX_LEN=$$NAME_LEN; \
		done; \
		ls -r $(SOURCE_DIR)/_drafts/*.md 2>/dev/null | while read file; do \
			NAME=$$(basename "$$file" .md); \
			printf "  $(CYAN)%-$${MAX_LEN}s$(RESET)  %s\n" "$$NAME" "$$file"; \
		done; \
	else \
		echo "  $(YELLOW)(no drafts)$(RESET)"; \
	fi

.PHONY: show-posts
show-posts:
	@echo "$(BLUE)Published posts (newest first):$(RESET)"
	@if [ -d "$(SOURCE_DIR)/posts" ] && [ -n "$$(ls -A $(SOURCE_DIR)/posts/*.md 2>/dev/null)" ]; then \
		MAX_LEN=0; \
		for file in $$(ls -r $(SOURCE_DIR)/posts/*.md 2>/dev/null); do \
			NAME_LEN=$$(basename "$$file" .md | awk '{print length}'); \
			[ $$NAME_LEN -gt $$MAX_LEN ] && MAX_LEN=$$NAME_LEN; \
		done; \
		ls -r $(SOURCE_DIR)/posts/*.md 2>/dev/null | while read file; do \
			NAME=$$(basename "$$file" .md); \
			printf "  $(CYAN)%-$${MAX_LEN}s$(RESET)  %s\n" "$$NAME" "$$file"; \
		done; \
	else \
		echo "  $(YELLOW)(no posts)$(RESET)"; \
	fi

# Validation targets
.PHONY: check
check:
	@echo "$(BLUE)Checking for required tools...$(RESET)"
	@command -v $(COBALT) >/dev/null 2>&1 && echo "$(GREEN)✓ cobalt found$(RESET)" || echo "$(RED)✗ cobalt not found (install: cargo install cobalt-bin)$(RESET)"
	@command -v $(NPM) >/dev/null 2>&1 && echo "$(GREEN)✓ npm found$(RESET)" || echo "$(RED)✗ npm not found$(RESET)"
	@command -v node >/dev/null 2>&1 && echo "$(GREEN)✓ node found (version: $$(node --version))$(RESET)" || echo "$(RED)✗ node not found$(RESET)"
	@command -v git >/dev/null 2>&1 && echo "$(GREEN)✓ git found$(RESET)" || echo "$(RED)✗ git not found$(RESET)"
	@test -f package.json && echo "$(GREEN)✓ package.json found$(RESET)" || echo "$(RED)✗ package.json not found$(RESET)"
	@test -f _cobalt.yml && echo "$(GREEN)✓ _cobalt.yml found$(RESET)" || echo "$(RED)✗ _cobalt.yml not found$(RESET)"

.PHONY: info
info:
	@echo ""
	@echo "$(CYAN)╔══════════════════════════════════════════════════════════╗$(RESET)"
	@echo "$(CYAN)║$(RESET)  $(BLUE)Build Information$(RESET)                                       $(CYAN)║$(RESET)"
	@echo "$(CYAN)╚══════════════════════════════════════════════════════════╝$(RESET)"
	@echo ""
	@echo "$(GREEN)Site:$(RESET)"
	@echo "  Name:           $(SITE_NAME)"
	@echo "  URL:            $(SITE_URL)"
	@echo ""
	@echo "$(GREEN)Paths:$(RESET)"
	@echo "  Source:         $(SOURCE_DIR)/"
	@echo "  Destination:    $(DEST_DIR)/"
	@echo "  CSS Source:     $(CSS_SOURCE)"
	@echo ""
	@echo "$(GREEN)Git:$(RESET)"
	@echo "  Branch:         $(GIT_BRANCH)"
	@echo "  Commit:         $(GIT_COMMIT)"
	@echo "  Build Time:     $(BUILD_TIME)"
	@echo ""
	@echo "$(GREEN)Tools:$(RESET)"
	@echo "  NPM:            $$(command -v $(NPM) 2>/dev/null || echo 'not found')"
	@echo "  Node:           $$(node --version 2>/dev/null || echo 'not found')"
	@echo "  Cobalt:         $$(command -v $(COBALT) 2>/dev/null || echo 'not found')"
	@echo ""
