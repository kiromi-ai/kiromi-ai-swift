#!/usr/bin/env bash
# Download a kiromi-mem-released KiromiAIFFI.xcframework into ./Frameworks/
# and verify the SwiftPM checksum.
#
# Usage:
#   bash scripts/fetch-xcframework.sh v0.2.0
#
# Auth: uses the operator's `gh` CLI auth to read from the private
# kiromi-ai/kiromi-mem repo. CI must `gh auth login` (or set GH_TOKEN)
# before invoking.

set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "usage: $(basename "$0") <tag>" >&2
    exit 1
fi

TAG="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
FRAMEWORKS_DIR="$ROOT/Frameworks"

mkdir -p "$FRAMEWORKS_DIR"
cd "$FRAMEWORKS_DIR"

echo "=> downloading KiromiAIFFI.xcframework.zip from kiromi-ai/kiromi-mem@$TAG"
rm -rf KiromiAIFFI.xcframework KiromiAIFFI.xcframework.zip
gh release download "$TAG" \
    -R kiromi-ai/kiromi-mem \
    -p 'KiromiAIFFI.xcframework.zip' \
    -p 'KiromiAIFFI.xcframework.zip.sha256'

echo "=> verifying checksum"
EXPECTED="$(awk '{print $1}' KiromiAIFFI.xcframework.zip.sha256)"
ACTUAL="$(shasum -a 256 KiromiAIFFI.xcframework.zip | awk '{print $1}')"
if [[ "$EXPECTED" != "$ACTUAL" ]]; then
    echo "checksum mismatch:" >&2
    echo "  expected: $EXPECTED" >&2
    echo "  actual:   $ACTUAL"   >&2
    exit 1
fi
echo "ok: $ACTUAL"

echo "=> extracting"
unzip -q KiromiAIFFI.xcframework.zip
rm KiromiAIFFI.xcframework.zip KiromiAIFFI.xcframework.zip.sha256

echo
echo "Done. Frameworks/KiromiAIFFI.xcframework is in place."
