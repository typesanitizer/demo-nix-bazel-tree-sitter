#!/usr/bin/env bash
set -eux
cd "$(dirname "${BASH_SOURCE[0]}")"
git init -b main
git add .
GIT_AUTHOR_EMAIL="_" GIT_AUTHOR_NAME="_" GIT_COMMITTER_EMAIL="_" GIT_COMMITTER_NAME="_" git commit -m "Initial commit"
tree-sitter generate
rm -rf bindings/node binding.gyp package.json
test -z "$(git ls-files --exclude-standard --others)"
exec git --no-pager diff --exit-code
