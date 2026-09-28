#!/usr/bin/env bash
# Render a RenderCV YAML file to a single PDF.
#
# Usage: render_cv.sh <input.yaml> <output.pdf>
#
# Only the PDF is kept. Temporary files go to a scratch folder.
# Needs: rendercv  (pip install "rendercv[full]")
# The first run needs internet so RenderCV can download its font packages.

set -euo pipefail

if [ $# -ne 2 ]; then
  echo "Usage: $0 <input.yaml> <output.pdf>" >&2
  exit 1
fi

INPUT="$1"
OUTPUT="$2"

if ! command -v rendercv >/dev/null 2>&1; then
  echo "ERROR: rendercv is not installed. Install it with:  pip install \"rendercv[full]\"" >&2
  exit 2
fi

if [ ! -f "$INPUT" ]; then
  echo "ERROR: input file not found: $INPUT" >&2
  exit 1
fi

# Absolute paths, because RenderCV resolves paths relative to the input file.
INPUT_ABS="$(cd "$(dirname "$INPUT")" && pwd)/$(basename "$INPUT")"
mkdir -p "$(dirname "$OUTPUT")"
OUTPUT_ABS="$(cd "$(dirname "$OUTPUT")" && pwd)/$(basename "$OUTPUT")"

SCRATCH="$(mktemp -d)"
trap 'rm -rf "$SCRATCH"' EXIT

# Run from the scratch folder so any default output folder lands there, not next to the user's files.
(
  cd "$SCRATCH"
  rendercv render "$INPUT_ABS" \
    --pdf-path "$OUTPUT_ABS" \
    --typst-path "$SCRATCH/cv.typ" \
    --dont-generate-markdown \
    --dont-generate-html \
    --dont-generate-png \
    --quiet
)

if [ ! -f "$OUTPUT_ABS" ]; then
  echo "ERROR: RenderCV finished but no PDF was created. Run without --quiet to see details:" >&2
  echo "  rendercv render \"$INPUT_ABS\"" >&2
  exit 3
fi

# Report page count when possible (1–2 pages is the target).
PAGES=""
if command -v pdfinfo >/dev/null 2>&1; then
  PAGES="$(pdfinfo "$OUTPUT_ABS" 2>/dev/null | awk '/^Pages:/ {print $2}')"
fi
if [ -z "$PAGES" ]; then
  # python3 on macOS/Linux; python or py on Windows. The Windows Store "python3" stub fails, so try each.
  for PY in python3 python py; do
    command -v "$PY" >/dev/null 2>&1 || continue
    PAGES="$("$PY" - "$OUTPUT_ABS" <<'PY' 2>/dev/null || true
import sys
try:
    from pypdf import PdfReader
    print(len(PdfReader(sys.argv[1]).pages))
except Exception:
    pass
PY
)"
    [ -n "$PAGES" ] && break
  done
fi

echo "OK: $OUTPUT_ABS"
[ -n "$PAGES" ] && echo "Pages: $PAGES"
exit 0
