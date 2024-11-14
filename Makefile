.DEFAULT_GOAL := help

.PHONY: help
help:  ## Show this help.
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(firstword $(MAKEFILE_LIST)) | \
			awk 'BEGIN {FS = ":.*## "}; {printf "%-30s %s\n", $$1, $$2}'

.PHONY: test
test:  ## Run all test.
	pdm run pytest -n auto tests -ra

.PHONY: unit
unit:  ## Run unit test in changed files.
	scripts/tests/unit.sh

.PHONY: integration
integration:  ## Run integration test in changed files.
	scripts/tests/integration.sh

.PHONY: all-unit
all-unit:  ## Run all unit test.
	pdm run pytest -n auto -m "unit" -ra

.PHONY: all-integration
all-integration:  ## Run all integration test.
	pdm run pytest -n auto -m "integration" -ra

.PHONY: all-acceptance
all-acceptance:  ## Run all acceptance test.
	pdm run pytest -n auto -m "acceptance" -ra

.PHONY: coverage
coverage:  ## Run all test with coverage.
	pdm run coverage run --branch -m pytest tests
	pdm run coverage html
	@xdg-open "${PWD}/htmlcov/index.html"

.PHONY: local-setup
local-setup:  ## Setup git hooks and install dependencies.
	scripts/local-setup.sh
	make install

.PHONY: install
install:  ## Install dependencies.
	pdm install

.PHONY: update
update:  ## Update dependencies.
	pdm update

.PHONY: add-dep
add-dep:  ## Add a new dependency.
	scripts/add-dependency.sh

.PHONY: remove-dep
remove-dep:  ## Remove a dependency.
	scripts/remove-dependency.sh

.PHONY: check-typing
check-typing:  ## Run mypy type checking.
	pdm run mypy

.PHONY: check-lint
check-lint:  ## Run ruff linting check.
	pdm run ruff check src tests

.PHONY: lint
lint:  ## Apply ruff linting fix.
	pdm run ruff check --fix src tests

.PHONY: check-format
check-format:  ## Run ruff format check.
	pdm run ruff format --check src tests

.PHONY: format
format:  ## Apply ruff format fix.
	pdm run ruff format src tests

.PHONY: pre-commit
pre-commit: check-typing check-lint check-format all-unit ## Run pre-commit checks.

.PHONY: pre-push
pre-push:  all-integration all-acceptance ## Run pre-push checks.

.PHONY: watch
watch:  ## Run all test with every change.
	pdm run ptw --runner "pytest -n auto tests -ra"

.PHONY: insert-template
insert-template:  ## Insert a template class among the existing ones.
	pdm run python -m scripts.insert_template

.PHONY: create-aggregate
create-aggregate:  ## Create a new aggregate inside contexts folder.
	pdm run python -m scripts.create_aggregate

.PHONY: show
show:  ## Show installed dependencies.
	pdm list

.PHONY: search
search:  ## Show package details.
	@read -p "Enter package name to search: " package;\
	pdm show $$package