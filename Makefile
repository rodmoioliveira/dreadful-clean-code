#!make

help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		sed -E 's/:.+## /@/g' | \
		LC_ALL=C sort -t@ -k1,1 | \
		column -s@ -t

bash-all: bash-fmt bash-check bash-lint ## Run all bash tests

bash-check: ## Check format bash code
	@find . -type f -name "*.sh" -not -path "./target/*" | xargs shfmt -i 2 -d

bash-deps: ## Install bash dependencies
	@sudo apt-get install -y moreutils

bash-fmt: ## Format bash code
	@find . -type f -name "*.sh" -not -path "./target/*" | xargs shfmt -i 2 -w

bash-lint: ## Check lint bash code
	@find . -type f -name "*.sh" -not -path "./target/*" | xargs shellcheck -o all

doc-changelog: ## Write CHANGELOG.md
	@git cliff -o CHANGELOG.md

doc-readme: ## Write README.md
	@./dev/doc-readme.sh

dprint-check: ## Dprint check
	@dprint check

dprint-fmt: ## Dprint format
	@dprint fmt

links-check: ## Check links
	@./dev/links-check.sh

links-mirror: ## Mirror links
	@./dev/links-mirror.sh

makefile-descriptions: ## Check if all Makefile rules have descriptions
	@./dev/makefile-descriptions.sh

typos: ## Check typos
	@typos

typos-fix: ## Fix typos
	@typos -w

.PHONY: bash-all
.PHONY: bash-check
.PHONY: bash-deps
.PHONY: bash-fmt
.PHONY: bash-lint
.PHONY: doc-changelog
.PHONY: doc-readme
.PHONY: dprint-check
.PHONY: dprint-fmt
.PHONY: help
.PHONY: links-check
.PHONY: links-mirror
.PHONY: makefile-descriptions
.PHONY: typos
.PHONY: typos-fix
