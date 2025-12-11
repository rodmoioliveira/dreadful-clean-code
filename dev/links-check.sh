#!/bin/bash

declare TRACE
[[ "${TRACE}" == 1 ]] && set -o xtrace
set -o errexit
set -o nounset
set -o pipefail
set -o noclobber

links-check() {
  if ! lychee \
    --base-url 'https://git.sr.ht/~rodmoi/dreadful-clean-code' \
    --exclude '(linkedin|substack|dreadful-clean-code)' \
    --exclude-path CHANGELOG.md \
    --no-progress \
    --timeout 3 \
    --verbose \
    './**/*.md'; then
    echo error
  else
    echo ok
  fi
}

main() {
  links-check
}

main
