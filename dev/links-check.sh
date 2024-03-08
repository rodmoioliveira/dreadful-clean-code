#!/bin/bash

declare TRACE
[[ "${TRACE}" == 1 ]] && set -o xtrace
set -o errexit
set -o nounset
set -o pipefail
set -o noclobber

links_check() {
  lychee . --verbose --cache --max-cache-age 5d --exclude-path CHANGELOG.md
  cat .lycheecache | sort >.lycheecache_sorted && mv .lycheecache_sorted .lycheecache
}

main() {
  links_check
}

main
