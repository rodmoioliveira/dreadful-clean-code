#!make

help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?## "}; \
	{printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}' | \
	LC_ALL=C sort

bash-all: bash-fmt bash-check bash-lint ## Run all bash tests

bash-fmt: ## Format bash code
	@find . -type f -name "*.sh" | xargs shfmt -i 2 -w

bash-check: ## Check format bash code
	@find . -type f -name "*.sh" | xargs shfmt -i 2 -d

bash-lint: ## Check lint bash code
	@find . -type f -name "*.sh" | xargs shellcheck -o all

doc-readme: ## Write README.md
	@./dev/doc-readme.sh

doc-changelog: ## Write CHANGELOG.mode
	@git cliff -o CHANGELOG.md

links-check: ## Check links
	@./dev/links-check.sh

links-mirror: ## Mirror links
	@./dev/links-mirror.sh

typos: ## Check typos
	@typos

typos-fix: ## Fix typos
	@typos -w

.PHONY: help
.PHONY: bash-all
.PHONY: bash-check
.PHONY: bash-fmt
.PHONY: bash-lint
.PHONY: doc-changelog
.PHONY: doc-readme
.PHONY: links-check
.PHONY: links-mirror
.PHONY: typos
.PHONY: typos-fix
