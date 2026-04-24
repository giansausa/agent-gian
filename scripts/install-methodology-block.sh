#!/usr/bin/env bash
# install-methodology-block.sh
# Appends methodology.md (from plugin root) to the user's ~/.claude/CLAUDE.md
# between <!-- agent-gian:start --> / <!-- agent-gian:end --> sentinels.
# Idempotent: if a block already exists, it is replaced with the current methodology.md.
set -euo pipefail

PLUGIN_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
METHODOLOGY_FILE="${PLUGIN_ROOT}/methodology.md"
CLAUDE_MD="${HOME}/.claude/CLAUDE.md"

if [ ! -f "${METHODOLOGY_FILE}" ]; then
  echo "ERROR: methodology.md not found at ${METHODOLOGY_FILE}" >&2
  exit 1
fi

mkdir -p "$(dirname "${CLAUDE_MD}")"
touch "${CLAUDE_MD}"

# If a block already exists, strip it first (same logic as uninstall)
if grep -q "<!-- agent-gian:start" "${CLAUDE_MD}"; then
  TMP=$(mktemp)
  awk '
    /<!-- agent-gian:start/ { skip = 1 }
    !skip { print }
    /<!-- agent-gian:end -->/ { skip = 0; next }
  ' "${CLAUDE_MD}" > "${TMP}"
  mv "${TMP}" "${CLAUDE_MD}"
fi

# Append the methodology block with a leading blank line for readability
{
  echo ""
  cat "${METHODOLOGY_FILE}"
  echo ""
} >> "${CLAUDE_MD}"

echo "Methodology block installed to ${CLAUDE_MD}"
