#!/bin/bash

function get_bounded_contexts_with_changes {
  changed_files=$(git diff --name-only HEAD)
  bounded_contexts=$(echo "$changed_files" | grep -E 'src/contexts/([^/]*/)*(application|domain)' | sed -E 's|src/contexts/([^/]*)/.*|\1|' | sort -u)
  echo "$bounded_contexts"
}

function has_bounded_contexts {
  local contexts="$1"

  if [[ -z "$contexts" ]]; then
    echo "No changes detected in application or domain folders of any bounded context."
    return 1
  fi

  return 0
}

function run_tests {
  local contexts="$1"

  for context in $contexts; do
    echo "Running application and domain tests for: $context"
    application_folders=$(find tests/contexts/"$context" -type d -name "application")
    domain_folders=$(find tests/contexts/"$context" -type d -name "domain")
    pdm run pytest -n auto $application_folders $domain_folders -ra
  done
}

function main {
  local bounded_contexts
  bounded_contexts=$(get_bounded_contexts_with_changes)

  if has_bounded_contexts "$bounded_contexts"; then
    run_tests "$bounded_contexts"
  fi
}

main