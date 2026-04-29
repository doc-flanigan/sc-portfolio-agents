#!/usr/bin/env bash
# Sync agents/*.md into ~/.claude/agents/
# Run from the repo root: ./sync.sh

set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/agents"
DEST_DIR="${HOME}/.claude/agents"

if [[ ! -d "$SRC_DIR" ]]; then
  echo "error: source directory not found: $SRC_DIR" >&2
  exit 1
fi

mkdir -p "$DEST_DIR"

count=0
for f in "$SRC_DIR"/*.md; do
  [[ -e "$f" ]] || continue
  cp -f "$f" "$DEST_DIR/"
  echo "synced: $(basename "$f")"
  count=$((count + 1))
done

echo ""
echo "done — $count agent(s) deployed to $DEST_DIR"
