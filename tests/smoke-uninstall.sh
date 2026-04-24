#!/usr/bin/env bash
# smoke-uninstall.sh — verifies uninstall leaves zero traces.
# Requires smoke-install.sh to have been run first (same TEST_HOME).
# Use TEST_HOME=$HOME/.agent-gian-smoke-test — avoid /tmp on Windows.
set -euo pipefail

: "${TEST_HOME:?Set TEST_HOME to the same scratch dir used by smoke-install.sh}"
export HOME="${TEST_HOME}"
PLUGIN_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Convert POSIX paths to OS-native form (matches scripts/unregister-hook.sh).
to_native() {
  if command -v cygpath >/dev/null 2>&1; then
    cygpath -m "$1"
  else
    echo "$1"
  fi
}

[ -f "${HOME}/.claude/CLAUDE.md" ] || { echo "FAIL: run smoke-install.sh first"; exit 1; }

# The user content marker that smoke-install.sh wrote before installing.
# This line MUST survive uninstall.
USER_MARKER="# existing user content"

echo "--- Pre-uninstall state ---"
echo "CLAUDE.md line count: $(wc -l < "${HOME}/.claude/CLAUDE.md")"
grep -q "${USER_MARKER}" "${HOME}/.claude/CLAUDE.md" || { echo "FAIL: user marker missing pre-uninstall — install state is wrong"; exit 1; }

echo "--- Running uninstall-methodology-block.sh ---"
bash "${PLUGIN_ROOT}/scripts/uninstall-methodology-block.sh"

echo "--- Running unregister-hook.sh ---"
bash "${PLUGIN_ROOT}/scripts/unregister-hook.sh"

echo "--- Verifying methodology block is gone ---"
if grep -q "agent-gian" "${HOME}/.claude/CLAUDE.md"; then
  echo "FAIL: agent-gian traces still in CLAUDE.md"
  exit 1
fi

echo "--- Verifying user content preserved ---"
grep -q "${USER_MARKER}" "${HOME}/.claude/CLAUDE.md" || { echo "FAIL: user marker lost during uninstall"; exit 1; }
echo "Post-uninstall line count: $(wc -l < "${HOME}/.claude/CLAUDE.md")"

echo "--- Verifying hook is gone from settings.json ---"
SETTINGS_NATIVE="$(to_native "${HOME}/.claude/settings.json")"
node -e "
const fs = require('fs');
const c = JSON.parse(fs.readFileSync('${SETTINGS_NATIVE}', 'utf8'));
const hooks = (c.hooks && c.hooks.PreToolUse) || [];
const found = hooks.some(g => (g.hooks || []).some(h => h._agentGian));
if (found) { console.error('FAIL: _agentGian hook still present'); process.exit(1); }
console.log('Hook removed.');
"

echo "PASS: uninstall smoke test"
