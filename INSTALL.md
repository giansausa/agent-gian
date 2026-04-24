# Install Guide

## Prerequisites

- Claude Code installed and authenticated
- Node.js available on PATH (used by hook scripts)
- `git` available on PATH
- Bash (Git Bash on Windows, native on macOS/Linux)

## Conceptual flow (3 steps)

### 1. Add Agent Gian as a marketplace source

In Claude Code, add `github.com/giansausa/agent-gian` as a plugin marketplace source. The exact slash command varies by Claude Code version — check `/plugin --help` or Claude Code's official plugin docs for the current syntax.

Once added, Claude Code treats the repo as a trusted source of plugins.

### 2. Enable the plugin

Enable `agent-gian` from the marketplace. Claude Code fetches the plugin files to `~/.claude/plugins/agent-gian/` and registers its skills. At this point you can invoke `/agent-gian`, but it'll just tell you to run setup — the methodology block isn't in your CLAUDE.md yet.

### 3. Run setup

```
/agent-gian setup
```

You'll be asked three yes/no questions (one at a time):

| Prompt | What it does | Recommendation |
|---|---|---|
| Append methodology block to CLAUDE.md? | Makes the 40 rules active in every session | **Yes** (required for activation) |
| Enable pre-commit tsc hook? | Blocks `git commit` when staged TS files have type errors | **Yes** if you work in TypeScript |
| Enable auto-push after commit? | Overrides Claude Code's safety default; auto-pushes after every successful commit | **No** unless you have a fast-iteration workflow and understand the tradeoff |

## Verifying install

```
/agent-gian
```

Expected output: a status dashboard showing "methodology installed" and the 7 core skills listed.

## Turning features on/off later

Re-run `/agent-gian setup`. It's idempotent — re-running replaces the existing methodology block (preserving your CLAUDE.md content above and below the sentinels) and lets you toggle hook/auto-push settings.

## Upgrading

Use Claude Code's plugin update mechanism (e.g. `/plugin update agent-gian` or the equivalent in your version). After updating, re-run `/agent-gian setup` to refresh the methodology block to the new version.

## Uninstalling

```
/agent-gian uninstall       # reverse everything Agent Gian wrote
/plugin remove agent-gian      # remove the skill files
```

The first command:
- Deletes the methodology block from `~/.claude/CLAUDE.md` (content above and below the sentinels is preserved)
- Removes the pre-commit hook entry from `~/.claude/settings.json`
- Deletes `~/.agent-gian/config`

The second command removes the plugin files themselves.

Smoke tests in this repo (`tests/smoke-uninstall.sh`) verify zero traces remain after uninstall.

## Forking

If you want your own flavor:

1. Fork `github.com/giansausa/agent-gian`
2. Edit rules in `methodology.md` or skills in `skills/*/SKILL.md`
3. Update the version in `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json`
4. Add your fork as a marketplace source instead of the upstream
5. Install from your fork

See [CONTRIBUTING.md](CONTRIBUTING.md) for rule-citation requirements if you want to upstream changes.

## Troubleshooting

**`/agent-gian` shows "methodology missing"**
You skipped the methodology prompt during setup. Re-run `/agent-gian setup` and answer yes.

**Hook blocks commits unexpectedly**
The pre-commit tsc hook runs `npx --no-install tsc --noEmit`. If TypeScript isn't installed in the package, it fails. Either install TypeScript locally (`npm install -D typescript`) or disable the hook via `/agent-gian setup`.

**Auto-push pushing somewhere I didn't expect**
Auto-push uses `git push origin <current-branch>`. Check `git remote -v` to see where `origin` points.

**Smoke tests fail on Windows with `ENOENT: /tmp/...`**
Use a scratch dir inside your real HOME instead of `/tmp` — e.g. `TEST_HOME=$HOME/.agent-gian-smoke-test`. Git Bash's `/tmp` doesn't round-trip through Windows Node.

**Install on a non-Windows machine and register-hook says `cygpath: command not found`**
The `to_native` helper in the scripts falls back to pass-through on systems without `cygpath`. This is expected on macOS/Linux — paths are already native-form there.
