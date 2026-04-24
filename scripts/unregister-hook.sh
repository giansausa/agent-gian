#!/usr/bin/env bash
# unregister-hook.sh
# Removes any hook entries marked with _agentGian: true from
# ~/.claude/settings.json. Idempotent.
set -euo pipefail

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
SETTINGS_NATIVE="$(to_native "${SETTINGS}")"

if [ ! -f "${SETTINGS}" ]; then
  echo "settings.json not found. Nothing to do."
  exit 0
fi

node - <<JSEOF
const fs = require('fs');
const path = '${SETTINGS_NATIVE}';
const config = JSON.parse(fs.readFileSync(path, 'utf8'));

if (!config.hooks || !config.hooks.PreToolUse) {
  console.log('No PreToolUse hooks. Nothing to do.');
  process.exit(0);
}

let removed = 0;
config.hooks.PreToolUse = config.hooks.PreToolUse
  .map(group => ({
    ...group,
    hooks: (group.hooks || []).filter(h => {
      if (h._agentGian) { removed++; return false; }
      return true;
    })
  }))
  .filter(group => (group.hooks || []).length > 0);

if (removed === 0) {
  console.log('No Agent Gian hooks found. Nothing to do.');
  process.exit(0);
}

fs.writeFileSync(path, JSON.stringify(config, null, 2));
console.log('Removed ' + removed + ' Agent Gian hook entry(ies) from ' + path);
JSEOF
