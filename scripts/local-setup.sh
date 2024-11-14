#!/bin/bash
set -e

function main {
  echo "Installing git hooks..."
  redirect_hooks_location
  echo "Git hooks installed."
}

function redirect_hooks_location {
  # Default location for git hooks is .git/hooks
  git config core.hooksPath scripts/hooks
}

main