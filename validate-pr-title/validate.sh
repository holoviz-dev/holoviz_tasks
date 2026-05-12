#!/usr/bin/env bash

set -euo pipefail

clean_lines() {
    printf '%s\n' "$1" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | sed '/^$/d'
}

to_pattern() {
    clean_lines "$1" | paste -sd '|'
}

to_list() {
    clean_lines "$1" | sort | sed 's/^/  - /'
}

types_pattern="$(to_pattern "$TYPES")"
scopes_pattern="$(to_pattern "$SCOPES")"
pattern="^(${types_pattern})(\\((${scopes_pattern})\\))?(!)?: [a-zA-Z].+"

if ! printf '%s\n' "$TITLE" | grep -Eq "$pattern"; then
    cat <<EOF
Invalid pull request title:

  $TITLE

Expected format:

  <type>(<scope>)!: <subject>

Scope and breaking change (!) are optional.

Rules:

  - Must end with a colon (e.g. 'docs:')
  - Scope is optional
  - Append ! for breaking changes

Allowed types:

$(to_list "$TYPES")

Allowed scopes:

$(to_list "$SCOPES")

EOF
    exit 1
fi
