#!/usr/bin/env bash

set -euo pipefail

types_pattern="$(printf '%s\n' "$TYPES" | sed '/^$/d' | paste -sd '|')"
scopes_pattern="$(printf '%s\n' "$SCOPES" | sed '/^$/d' | paste -sd '|')"
pattern="^(${types_pattern})(\\((${scopes_pattern})\\))?(!)?: [a-z].+"

if ! printf '%s\n' "$TITLE" | grep -Eq "$pattern"; then
    cat <<EOF
Invalid pull request title:

  $TITLE

Expected format:

  <type>(<scope>)!: <subject>

Scope and breaking change (!) are optional.

Allowed types:

$(printf '%s\n' "$TYPES" | sed 's/^/  - /')

Allowed scopes:

$(printf '%s\n' "$SCOPES" | sed 's/^/  - /')

Rules:

  - Type must end with a colon (e.g. 'docs:')
  - Scope is optional
  - Append ! for breaking changes
EOF
    exit 1
fi
