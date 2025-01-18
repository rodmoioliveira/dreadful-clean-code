#!/bin/bash

declare TRACE
[[ "${TRACE}" == 1 ]] && set -o xtrace
set -o errexit
set -o nounset
set -o pipefail
set -o noclobber

links-mirror() {
  cat .lycheecache |
    awk -F, '{print $1}' |
    sort -u |
    grep -E '(youtu|mastodon|github|twitch)' -v |
    xargs -n1 wget \
      --convert-links \
      --backup-converted \
      --page-requisites \
      --adjust-extension \
      --no-parent \
      --timestamping \
      --tries=3 \
      --user-agent 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:40.0) Gecko/20100101 Firefox/40.0' \
      --execute robots=off \
      --directory-prefix=".mirrors"
}

main() {
  links-mirror
}

main
