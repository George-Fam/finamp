#!/usr/bin/env bash
# Builds the web (streaming-only) target: ./tools/build_web.sh [extra `flutter build web` args, e.g. --base-href /finamp/]
#
# Isar's generated schemas hold 64-bit ids as integer literals, which dart2js refuses since JavaScript can't
# represent them. The web build never opens Isar, so for the length of the build those literals are cut to
# 15 digits, and the generated files are put back afterwards.
set -euo pipefail
cd "$(dirname "$0")/.."

mapfile -t generated < <(grep -lE "^\s*id: -?[0-9]{16,}," lib -r --include='*.g.dart')
backup=$(mktemp -d)
restore() {
  for f in "${generated[@]}"; do cp "$backup/$(echo "$f" | tr / _)" "$f"; done
  rm -rf "$backup"
}
for f in "${generated[@]}"; do cp "$f" "$backup/$(echo "$f" | tr / _)"; done
trap restore EXIT
for f in "${generated[@]}"; do perl -pi -e 's/^(\s*id: -?)[0-9]*([0-9]{15}),/$1$2,/' "$f"; done

${FLUTTER:-flutter} build web --no-wasm-dry-run "$@"
