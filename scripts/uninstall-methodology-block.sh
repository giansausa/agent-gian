#!/usr/bin/env bash
# uninstall-methodology-block.sh
# Removes the Agent Gian sentinel block from ~/.claude/CLAUDE.md.
# Leaves user's own content intact above and below.
set -euo pipefail

CLAUDE_MD="${HOME}/.claude/CLAUDE.md"

if [ ! -f "${CLAUDE_MD}" ]; then
  echo "CLAUDE.md not found at ${CLAUDE_MD}. Nothing to do."
  exit 0
fi

if ! grep -q "<!-- agent-gian:start" "${CLAUDE_MD}"; then
  echo "No Agent Gian block found in ${CLAUDE_MD}. Nothing to do."
  exit 0
fi

TMP=$(mktemp)
awk '
  /<!-- agent-gian:start/ { skip = 1 }
  !skip { print }
  /<!-- agent-gian:end -->/ { skip = 0; next }
' "${CLAUDE_MD}" > "${TMP}"

mv "${TMP}" "${CLAUDE_MD}"
echo "Methodology block removed from ${CLAUDE_MD}"
