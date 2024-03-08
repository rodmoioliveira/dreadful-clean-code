#!make

help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?## "}; \
	{printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}' | \
	sort

bash-all: bash-fmt bash-check bash-lint ## Run all bash tests

bash-fmt: ## Format bash code
	@find . -type f -name "*.sh" | xargs shfmt -i 2 -w

bash-check: ## Check format bash code
	@find . -type f -name "*.sh" | xargs shfmt -i 2 -d

bash-lint: ## Check lint bash code
	@find . -type f -name "*.sh" | xargs shellcheck -o all

changelog: ## Autogenerate CHANGELOG.md
	@docker run -t -v "$(shell pwd)":/app/ orhunp/git-cliff:latest --config cliff.toml --output CHANGELOG.md

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
.PHONY: changelog
.PHONY: links-check
.PHONY: links-mirror
.PHONY: typos
.PHONY: typos-fix
