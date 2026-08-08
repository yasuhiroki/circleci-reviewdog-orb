#!/bin/bash

set -eu

curl -sfL \
  https://raw.githubusercontent.com/reviewdog/action-rubocop/b6d5e953a5fc0bf3ab65254e77730ea2174d6d6d/rdjson_formatter/rdjson_formatter.rb \
  -O

rubocop \
  --require ./rdjson_formatter.rb \
  --format RdjsonFormatter \
  --fail-level error \
  | reviewdog -f=rdjson \
      -name="rubocop" \
      -reporter="github-pr-check" \
      -filter-mode="added" \
      -fail-level="none" \
      -fail-on-error="false" \
      -level="error"
