#!/bin/bash

declare TRACE
[[ "${TRACE}" == 1 ]] && set -o xtrace
set -o errexit
set -o nounset
set -o pipefail
set -o noclobber

check-links() {
  lychee . --verbose --cache --max-cache-age 5d --exclude-path CHANGELOG.md
  cat .lycheecache | sort >.lycheecache_sorted && mv .lycheecache_sorted .lycheecache
}

main() {
  check-links
}

main
