#!/usr/bin/env bash
# install.sh — one-shot Agent Gian marketplace + plugin registration.
#
# What this does:
#   Edits ~/.claude/settings.json to (a) add `agent-gian` as a known
#   marketplace source and (b) enable the `agent-gian` plugin from it.
#
# What this does NOT do:
#   Does NOT run `/agent-gian setup`. That flow writes to your CLAUDE.md
#   and (optionally) overrides Claude Code safety defaults, so it must
#   happen interactively inside Claude Code after you restart.
#
# Safety:
#   - Merges into existing settings.json (preserves other plugins, theme,
#     model, hooks, etc.).
#   - Idempotent — safe to re-run.
#   - Creates settings.json with minimal `{}` if missing.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/giansausa/agent-gian/main/install.sh | bash
#   (or clone the repo and run `bash install.sh` locally)
set -euo pipefail

SETTINGS="${HOME}/.claude/settings.json"
MARKETPLACE_NAME="agent-gian"
MARKETPLACE_REPO="giansausa/agent-gian"
PLUGIN_ID="agent-gian@agent-gian"

# Convert POSIX path to OS-native form for Node. On Git Bash for Windows,
# `cygpath -m` gives `/c/Users/x` -> `C:/Users/x`. No-op on macOS/Linux.
to_native() {
  if command -v cygpath >/dev/null 2>&1; then
    cygpath -m "$1"
  else
    echo "$1"
  fi
}

echo "Agent Gian — plugin registration"
echo "================================"

if ! command -v node >/dev/null 2>&1; then
  echo "ERROR: Node.js not found on PATH. Install from https://nodejs.org then re-run." >&2
  exit 1
fi

mkdir -p "$(dirname "${SETTINGS}")"

if [ ! -f "${SETTINGS}" ]; then
  echo "{}" > "${SETTINGS}"
  echo "Created new ${SETTINGS}"
fi

# Heal stale state from the v0.1.0 install bug where the marketplace was
# cached under the name `agent-gian-marketplace` instead of `agent-gian`.
# If the old cache dir or known_marketplaces.json entry exists, remove them
# so Claude Code re-fetches the marketplace under the correct name on next
# restart. Safe no-op on fresh installs.
STALE_CACHE="${HOME}/.claude/plugins/marketplaces/agent-gian-marketplace"
KNOWN_MKTS="${HOME}/.claude/plugins/known_marketplaces.json"
if [ -d "${STALE_CACHE}" ]; then
  rm -rf "${STALE_CACHE}"
  echo "- removed stale marketplace cache: agent-gian-marketplace"
fi
if [ -f "${KNOWN_MKTS}" ]; then
  KNOWN_MKTS_NATIVE="$(to_native "${KNOWN_MKTS}")"
  node - <<JSEOF2
const fs = require('fs');
const p = '${KNOWN_MKTS_NATIVE}';
try {
  const k = JSON.parse(fs.readFileSync(p, 'utf8'));
  if (k['agent-gian-marketplace']) {
    delete k['agent-gian-marketplace'];
    fs.writeFileSync(p, JSON.stringify(k, null, 2) + '\n');
    console.log('- removed stale entry from known_marketplaces.json: agent-gian-marketplace');
  }
} catch (e) { /* file may be absent or malformed; skip silently */ }
JSEOF2
fi

SETTINGS_NATIVE="$(to_native "${SETTINGS}")"

node - <<JSEOF
const fs = require('fs');
const path = '${SETTINGS_NATIVE}';

let cfg;
try {
  cfg = JSON.parse(fs.readFileSync(path, 'utf8'));
} catch (e) {
  console.error('ERROR: ' + path + ' is not valid JSON: ' + e.message);
  console.error('Fix the file manually (or move it aside) and re-run.');
  process.exit(1);
}

cfg.enabledPlugins = cfg.enabledPlugins || {};
cfg.extraKnownMarketplaces = cfg.extraKnownMarketplaces || {};

const pluginId = '${PLUGIN_ID}';
const mktName = '${MARKETPLACE_NAME}';
const mktRepo = '${MARKETPLACE_REPO}';

let changed = false;

if (cfg.enabledPlugins[pluginId] !== true) {
  cfg.enabledPlugins[pluginId] = true;
  changed = true;
  console.log('+ enabledPlugins: ' + pluginId);
} else {
  console.log('= enabledPlugins: ' + pluginId + ' (already set)');
}

const desired = { source: { source: 'github', repo: mktRepo } };
const existing = cfg.extraKnownMarketplaces[mktName];
if (!existing || JSON.stringify(existing) !== JSON.stringify(desired)) {
  cfg.extraKnownMarketplaces[mktName] = desired;
  changed = true;
  console.log('+ marketplace: ' + mktName + ' -> github:' + mktRepo);
} else {
  console.log('= marketplace: ' + mktName + ' (already set)');
}

if (changed) {
  fs.writeFileSync(path, JSON.stringify(cfg, null, 2) + '\n');
  console.log('');
  console.log('Wrote ' + path);
} else {
  console.log('');
  console.log('Nothing to change — already registered.');
}
JSEOF

cat <<EONEXT

Next steps:
  1. Restart Claude Code so it picks up the settings.json change
     and fetches the plugin from github.com/${MARKETPLACE_REPO}.
  2. Inside Claude Code, run:  /agent-gian setup
     (interactive consent for methodology block, pre-commit hook, auto-push)
  3. Verify with:              /agent-gian

Full guide + troubleshooting: https://github.com/${MARKETPLACE_REPO}/blob/main/INSTALL.md
EONEXT
