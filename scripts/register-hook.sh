#!/usr/bin/env bash
# register-hook.sh
# Adds the Agent Gian pre-commit tsc hook to user's ~/.claude/settings.json
# under hooks.PreToolUse, matcher "Bash".
# Idempotent: skips if the hook is already present.
set -euo pipefail

PLUGIN_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOOK_PATH="${PLUGIN_ROOT}/hooks/tsc-check-before-commit.sh"
SETTINGS="${HOME}/.claude/settings.json"

# Convert a POSIX path to OS-native form for Node/JSON consumption.
# On Git Bash for Windows, `cygpath -m` gives forward-slash Windows form
# (e.g. `/c/Users/x` → `C:/Users/x`) which Node handles. On Linux/macOS,
# paths pass through unchanged.
to_native() {
  if command -v cygpath >/dev/null 2>&1; then
    cygpath -m "$1"
  else
    echo "$1"
  fi
}
HOOK_PATH_NATIVE="$(to_native "${HOOK_PATH}")"
SETTINGS_NATIVE="$(to_native "${SETTINGS}")"

if [ ! -f "${HOOK_PATH}" ]; then
  echo "ERROR: hook script not found at ${HOOK_PATH}" >&2
  exit 1
fi

if [ ! -f "${SETTINGS}" ]; then
  echo "{}" > "${SETTINGS}"
fi

node - <<JSEOF
const fs = require('fs');
const path = '${SETTINGS_NATIVE}';
const hookCmd = 'bash ${HOOK_PATH_NATIVE}';
const config = JSON.parse(fs.readFileSync(path, 'utf8'));
config.hooks = config.hooks || {};
config.hooks.PreToolUse = config.hooks.PreToolUse || [];

const already = config.hooks.PreToolUse.some(group =>
  group.matcher === 'Bash' &&
  (group.hooks || []).some(h => h.command === hookCmd)
);

if (already) {
  console.log('Hook already registered; no change.');
  process.exit(0);
}

config.hooks.PreToolUse.push({
  matcher: 'Bash',
  hooks: [{
    type: 'command',
    command: hookCmd,
    timeout: 90,
    _agentGian: true
  }]
});

fs.writeFileSync(path, JSON.stringify(config, null, 2));
console.log('Hook registered in ' + path);
JSEOF
