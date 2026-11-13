#!/bin/sh
# The `build` check: exampleSite built with the theme, as netlify.toml builds the demo (there with Hugo 0.167.0, which
# the hugomods images do not have yet; the pinned Hugo of yggdrasil.yml is the one the blog that uses this theme is
# built with, and the theme asks for 0.116.0 or newer, not extended). Hugo exits 0 on a warning, so any WARN fails it
# too (but not a missing translation: the theme looks one up for every taxonomy and falls back to its name, so i18n
# warnings are not asked for), and so does a site with no home page.
#
# exampleSite/hugo.toml finds the theme as `rusty-typewriter` in its themesdir, ../.. (Netlify renames the checkout's
# directory to that), so the checkout, whatever its directory is called, is linked under that name in a temporary
# directory, given as HUGO_THEMESDIR (the file's themesdir wins over --themesDir; the environment wins over both). The
# directory also takes the built site: nothing is written to the checkout but Hugo's own cache,
# exampleSite/resources/ (ignored by git).
#
# yggdrasil.yml runs it in the pinned Hugo image from the repository's root. By hand:
#   docker run --rm -v "$PWD:/src" -w /src <image from yggdrasil.yml> sh ci/build.sh
set -eu

# The repository's root, wherever this is run from.
cd "$(dirname "$0")/.."
root=$(pwd)

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
mkdir "$work/themes"
ln -s "$root" "$work/themes/rusty-typewriter"

hugo version
cd exampleSite
status=0
HUGO_THEMESDIR="$work/themes" hugo --destination "$work/public" \
  --printPathWarnings >"$work/hugo.log" 2>&1 || status=$?
cat "$work/hugo.log"
[ "$status" -eq 0 ] || exit "$status"
# The site must have been written, and without a single warning.
test -s "$work/public/index.html"
if grep -q '^WARN' "$work/hugo.log"; then
  echo "ci/build.sh: Hugo emitted warnings (above)" >&2
  exit 1
fi
