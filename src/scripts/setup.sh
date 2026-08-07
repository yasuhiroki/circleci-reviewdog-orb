#!/bin/bash

: "${REVIEWDOG_VERSION:=latest}"

install_dir="${HOME}/bin"
mkdir -p "${install_dir}"

curl -sfL \
  https://raw.githubusercontent.com/reviewdog/reviewdog/fd59714416d6d9a1c0692d872e38e7f8448df4fc/install.sh \
  | sh -s -- -b "${install_dir}" "${REVIEWDOG_VERSION}"

export PATH="${install_dir}:${PATH}"

if [ -n "${BASH_ENV:-}" ]; then
  # shellcheck disable=SC2016
  echo 'export PATH="$HOME/bin:$PATH"' >> "${BASH_ENV}"
fi
