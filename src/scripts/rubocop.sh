#!/bin/bash

set -eu

curl -sfL \
  https://raw.githubusercontent.com/reviewdog/action-rubocop/b6d5e953a5fc0bf3ab65254e77730ea2174d6d6d/rdjson_formatter/rdjson_formatter.rb \
  -O

: "${REVIEWDOG_REPORTER:=github-pr-review}"
: "${RUBOCOP_EXEC:=rubocop}"
: "${RUBOCOP_OPTS:=}"

rubocop_opts=()
if [ -n "$RUBOCOP_OPTS" ]; then
  read -r -a rubocop_opts <<< "$RUBOCOP_OPTS"
fi

${RUBOCOP_EXEC} \
  --require ./rdjson_formatter.rb \
  --format RdjsonFormatter \
  --fail-level error \
  "${rubocop_opts[@]}" \
  | \
  reviewdog -f=rdjson \
    -name="rubocop" \
    -reporter="${REVIEWDOG_REPORTER}" \
    -filter-mode="added" \
    -fail-level="none" \
    -fail-on-error="false" \
    -level="error"
