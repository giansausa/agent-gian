#!/usr/bin/env bash
# smoke-install-script.sh — verifies install.sh safely adds marketplace
# + plugin entries AND preserves existing settings.json content AND
# is idempotent on re-run.
set -euo pipefail

: "${TEST_HOME:?Set TEST_HOME to a scratch directory — do not run against real HOME}"
export HOME="${TEST_HOME}"
PLUGIN_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

to_native() {
  if command -v cygpath >/dev/null 2>&1; then
    cygpath -m "$1"
  else
    echo "$1"
  fi
}

SETTINGS_NATIVE="$(to_native "${HOME}/.claude/settings.json")"

# --- TEST 1: fresh install (no settings.json pre-existing) ---
echo "=== TEST 1: fresh install (no prior settings.json) ==="
rm -rf "${HOME}"
bash "${PLUGIN_ROOT}/install.sh"

node -e "
const c = JSON.parse(require('fs').readFileSync('${SETTINGS_NATIVE}', 'utf8'));
if (c.enabledPlugins['agent-gian@agent-gian'] !== true) { console.error('FAIL: plugin not enabled'); process.exit(1); }
if (!c.extraKnownMarketplaces['agent-gian']) { console.error('FAIL: marketplace missing'); process.exit(1); }
const src = c.extraKnownMarketplaces['agent-gian'].source;
if (src.source !== 'github' || src.repo !== 'giansausa/agent-gian') { console.error('FAIL: marketplace source wrong: ' + JSON.stringify(src)); process.exit(1); }
console.log('PASS: fresh install adds both entries');
"

# --- TEST 2: merge with existing plugins — does not stomp ---
echo ""
echo "=== TEST 2: merge with existing settings.json ==="
rm -rf "${HOME}"
mkdir -p "${HOME}/.claude"
cat > "${HOME}/.claude/settings.json" <<'JSON'
{
  "model": "claude-opus-4-7",
  "theme": "dark",
  "enabledPlugins": {
    "superpowers@claude-plugins-official": true
  },
  "extraKnownMarketplaces": {
    "superpowers-marketplace": {
      "source": { "source": "github", "repo": "obra/superpowers-marketplace" }
    }
  },
  "hooks": {
    "PreToolUse": [{"matcher":"Bash","hooks":[{"type":"command","command":"echo existing"}]}]
  }
}
JSON

bash "${PLUGIN_ROOT}/install.sh"

node -e "
const c = JSON.parse(require('fs').readFileSync('${SETTINGS_NATIVE}', 'utf8'));
if (c.model !== 'claude-opus-4-7') { console.error('FAIL: model setting lost'); process.exit(1); }
if (c.theme !== 'dark') { console.error('FAIL: theme setting lost'); process.exit(1); }
if (c.enabledPlugins['superpowers@claude-plugins-official'] !== true) { console.error('FAIL: superpowers plugin disabled'); process.exit(1); }
if (c.enabledPlugins['agent-gian@agent-gian'] !== true) { console.error('FAIL: agent-gian not enabled'); process.exit(1); }
if (!c.extraKnownMarketplaces['superpowers-marketplace']) { console.error('FAIL: superpowers-marketplace lost'); process.exit(1); }
if (!c.extraKnownMarketplaces['agent-gian']) { console.error('FAIL: agent-gian marketplace missing'); process.exit(1); }
if (!c.hooks || !c.hooks.PreToolUse || c.hooks.PreToolUse.length === 0) { console.error('FAIL: existing hooks lost'); process.exit(1); }
console.log('PASS: merge preserves model, theme, existing plugins, existing marketplaces, hooks');
"

# --- TEST 3: idempotent re-run prints no-change indicators ---
echo ""
echo "=== TEST 3: idempotent re-run ==="
OUTPUT=$(bash "${PLUGIN_ROOT}/install.sh" 2>&1)
echo "${OUTPUT}"
if echo "${OUTPUT}" | grep -q "Nothing to change"; then
  echo "PASS: idempotent re-run is a no-op"
else
  echo "FAIL: expected 'Nothing to change' on second run"
  exit 1
fi

# --- TEST 4: invalid JSON in settings.json gives a clear error ---
echo ""
echo "=== TEST 4: invalid JSON produces clear error ==="
echo "not valid json {" > "${HOME}/.claude/settings.json"
set +e
OUTPUT=$(bash "${PLUGIN_ROOT}/install.sh" 2>&1)
EXIT=$?
set -e
if [ ${EXIT} -ne 0 ] && echo "${OUTPUT}" | grep -q "not valid JSON"; then
  echo "PASS: invalid JSON is refused clearly (exit ${EXIT})"
else
  echo "FAIL: expected non-zero exit with 'not valid JSON' message. Got:"
  echo "${OUTPUT}"
  exit 1
fi

echo ""
echo "ALL TESTS PASSED: install.sh is safe, merge-preserving, idempotent, and rejects malformed JSON"
