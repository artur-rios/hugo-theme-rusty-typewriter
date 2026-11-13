#!/bin/sh
# The `lint` check: spelling, with codespell, over the theme and its example site (templates, styles, scripts,
# translations, content). The theme has no linter or formatter config of its own, and its CSS and JS were never
# formatted by one, so a formatter check would mean reformatting every file of the fork. Left out: git's files,
# images and static files, and the vendored, minified FlexSearch build.
#
# yggdrasil.yml runs it in the pinned Python image from the repository's root; codespell is pinned below. By hand:
#   docker run --rm -v "$PWD:/src" -w /src <image from yggdrasil.yml> sh ci/lint.sh
set -eu

# The repository's root, wherever this is run from.
cd "$(dirname "$0")/.."

# renovate: datasource=pypi depName=codespell
CODESPELL_VERSION=2.4.3

export PIP_DISABLE_PIP_VERSION_CHECK=1 PIP_ROOT_USER_ACTION=ignore
pip install --quiet --no-cache-dir "codespell==$CODESPELL_VERSION"
codespell --version
codespell --skip="./.git,./images,./static,*.png,*.jpg,*.svg,./assets/js/search/flexsearch.compact.js" .
