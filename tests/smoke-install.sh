#!/usr/bin/env bash
# smoke-install.sh — verifies a fresh install produces the expected artifacts.
# Run with TEST_HOME=$HOME/.agent-gian-smoke-test (or any scratch dir inside
# your real HOME) to avoid touching the real ~/.claude.
# Avoid /tmp on Windows — Git Bash's /tmp doesn't round-trip through Node.
set -euo pipefail

: "${TEST_HOME:?Set TEST_HOME to a scratch directory — do not run against real HOME}"
export HOME="${TEST_HOME}"
PLUGIN_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Convert POSIX paths to OS-native form (matches scripts/register-hook.sh).
to_native() {
  if command -v cygpath >/dev/null 2>&1; then
    cygpath -m "$1"
  else
    echo "$1"
  fi
}

rm -rf "${HOME}"
mkdir -p "${HOME}/.claude"
echo "# existing user content" > "${HOME}/.claude/CLAUDE.md"
echo "{}" > "${HOME}/.claude/settings.json"

echo "--- Pre-install state ---"
cat "${HOME}/.claude/CLAUDE.md"

echo "--- Running install-methodology-block.sh ---"
bash "${PLUGIN_ROOT}/scripts/install-methodology-block.sh"

echo "--- Running register-hook.sh ---"
bash "${PLUGIN_ROOT}/scripts/register-hook.sh"

echo "--- Verifying CLAUDE.md contains methodology block ---"
grep -q "<!-- agent-gian:start" "${HOME}/.claude/CLAUDE.md" || { echo "FAIL: start sentinel missing"; exit 1; }
grep -q "<!-- agent-gian:end -->" "${HOME}/.claude/CLAUDE.md" || { echo "FAIL: end sentinel missing"; exit 1; }
grep -q "# existing user content" "${HOME}/.claude/CLAUDE.md" || { echo "FAIL: user content lost"; exit 1; }

echo "--- Verifying settings.json has hook registered ---"
SETTINGS_NATIVE="$(to_native "${HOME}/.claude/settings.json")"
node -e "
const fs = require('fs');
const c = JSON.parse(fs.readFileSync('${SETTINGS_NATIVE}', 'utf8'));
const hooks = (c.hooks && c.hooks.PreToolUse) || [];
const found = hooks.some(g => (g.hooks || []).some(h => h._agentGian));
if (!found) { console.error('FAIL: _agentGian hook not found'); process.exit(1); }
console.log('Hook registered.');
"

echo "PASS: install smoke test"
