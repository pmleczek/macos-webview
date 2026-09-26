#!/usr/bin/env bash
# Verifies that branches are named <type>/<name>,
# where <type> is a Conventional Commits type, e.g. chore/set-up-repository
#
# As a pre-push hook, git passes the refs being pushed on stdin:
#   <local ref> <local sha> <remote ref> <remote sha>
# and the remote branch name is verified. When run manually (no stdin),
# the current branch is verified instead.

set -euo pipefail

TYPES='build|chore|ci|docs|feat|fix|perf|refactor|revert|style|test'
PATTERN="^(${TYPES})/[a-z0-9]+(-[a-z0-9]+)*$"
ALLOWED_BRANCHES=('main')
ZERO_SHA_PATTERN='^0+$'

is_valid() {
  local branch="$1"
  local allowed

  for allowed in "${ALLOWED_BRANCHES[@]}"; do
    if [[ "${branch}" == "${allowed}" ]]; then
      return 0
    fi
  done

  [[ "${branch}" =~ ${PATTERN} ]]
}

branches=()

if [[ -t 0 ]]; then
  current="$(git branch --show-current)"
  # Detached HEAD has no branch to verify
  if [[ -n "${current}" ]]; then
    branches+=("${current}")
  fi
else
  while read -r _local_ref local_sha remote_ref _remote_sha; do
    # Skip tags and other non-branch refs
    [[ "${remote_ref}" == refs/heads/* ]] || continue
    # Skip branch deletions
    [[ "${local_sha}" =~ ${ZERO_SHA_PATTERN} ]] && continue
    branches+=("${remote_ref#refs/heads/}")
  done
fi

invalid=()
for branch in "${branches[@]+"${branches[@]}"}"; do
  is_valid "${branch}" || invalid+=("${branch}")
done

if ((${#invalid[@]} > 0)); then
  for branch in "${invalid[@]}"; do
    echo "Invalid branch name: \"${branch}\"" >&2
  done
  echo "Expected: <type>/<kebab-case-name>, e.g. chore/set-up-repository" >&2
  echo "Allowed types: ${TYPES//|/, }" >&2
  exit 1
fi
