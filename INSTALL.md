# Install Guide

**Total time:** ~3 minutes.
**What you'll do:** edit one JSON file, restart Claude Code, run one command.

---

## Prerequisites

Before you start, confirm you have:

- [x] Claude Code installed and authenticated (`claude --version` works)
- [x] Node.js on PATH (`node --version` works)
- [x] `git` on PATH (`git --version` works)
- [x] A bash shell (Git Bash on Windows, Terminal on macOS, any shell on Linux)

If any are missing, install them first — nothing in this guide works without them.

---

## Step 1: Locate your Claude Code settings file

| OS | Path |
|---|---|
| **macOS** | `~/.claude/settings.json` |
| **Linux** | `~/.claude/settings.json` |
| **Windows** | `C:\Users\<your-username>\.claude\settings.json` |

Open it in any text editor. If the file doesn't exist, create it with `{}` as the content.

---

## Step 2: Register Agent Gian as a plugin + marketplace

You need to add **two entries** to your `settings.json`:

1. A marketplace source pointing at `github.com/giansausa/agent-gian`
2. An enabled-plugins entry turning on `agent-gian` from that marketplace

### If your `settings.json` is empty or fresh

Replace the whole file with this:

```json
{
  "enabledPlugins": {
    "agent-gian@agent-gian": true
  },
  "extraKnownMarketplaces": {
    "agent-gian": {
      "source": {
        "source": "github",
        "repo": "giansausa/agent-gian"
      }
    }
  }
}
```

### If you already have plugins installed (e.g. Superpowers)

**Add** these entries alongside the existing ones — don't replace anything. Example of what a combined file looks like:

```json
{
  "enabledPlugins": {
    "superpowers@claude-plugins-official": true,
    "agent-gian@agent-gian": true
  },
  "extraKnownMarketplaces": {
    "superpowers-marketplace": {
      "source": {
        "source": "github",
        "repo": "obra/superpowers-marketplace"
      }
    },
    "agent-gian": {
      "source": {
        "source": "github",
        "repo": "giansausa/agent-gian"
      }
    }
  }
}
```

Save the file. Make sure the JSON is valid (no trailing commas, balanced braces).

---

## Step 3: Restart Claude Code

Close Claude Code completely and reopen it. On restart, it reads your `settings.json`, fetches the plugin from GitHub, and registers the 7 Agent Gian skills.

**How to verify the plugin loaded:** type `/` in Claude Code and look for `agent-gian` in the skill list. If you see it, the plugin installed. If you don't, skip to [Troubleshooting](#troubleshooting).

---

## Step 4: Run setup

In any Claude Code session, run:

```
/agent-gian setup
```

You'll be asked three yes/no questions — one at a time. Answer them based on this table:

| Prompt | What it does | Our recommendation |
|---|---|---|
| Append the 40-rule methodology block to your `~/.claude/CLAUDE.md`? | Makes the methodology active in every Claude Code session, across every project | **Yes** (without this, the plugin is inert) |
| Enable the pre-commit `tsc --noEmit` hook? | Blocks `git commit` when staged TypeScript files have type errors. Auto-skips on non-TS projects. | **Yes** if you work in TypeScript. **No** if you don't. |
| Enable auto-push after commit? **This overrides Claude Code's default safety.** | Agent Gian skills `git push` immediately after every successful commit | **No** unless you have a solo/fast-iteration workflow and you understand the tradeoff. Default is safer. |

---

## Step 5: Verify

Type:

```
/agent-gian
```

You should see a status dashboard showing:
- `methodology installed` (if you said yes to prompt 1)
- The 7 core skills listed
- The status of your optional toggles (hook enabled/skipped, auto-push enabled/skipped)

**If the dashboard shows `methodology missing`**, re-run `/agent-gian setup` and answer yes to the first prompt.

---

## You're installed. What now?

Try one of the skills in a real session:

- Hit a bug? → `/agent-gian-diagnose-first` and paste the error
- Thinking about a launch? → `/agent-gian-review`
- About to commit? → `/agent-gian-commit`
- Wrapping up for the day? → `/agent-gian-pause`
- Coming back the next day? → `/agent-gian-resume`

Full skill reference is in [README.md](README.md).

---

## Changing your mind later

### Toggle individual settings
Re-run `/agent-gian setup`. It's idempotent — the methodology block gets replaced cleanly (your own CLAUDE.md content above and below the sentinels is preserved), and you can flip hook/auto-push on or off.

### Update to a new version
Claude Code updates installed plugins via its built-in plugin update mechanism. After the update completes, re-run `/agent-gian setup` once to refresh the methodology block to the new version's text.

### Fully uninstall

Two commands, in this order:

```
/agent-gian uninstall
```

This deletes the methodology block from your `CLAUDE.md` (content above and below the sentinels is preserved), removes the hook from `settings.json`, and deletes `~/.agent-gian/config`.

Then, to remove the plugin files themselves, open your `~/.claude/settings.json` and:
1. Delete the `"agent-gian@agent-gian": true` line from `enabledPlugins`
2. Delete the `"agent-gian": { ... }` block from `extraKnownMarketplaces`

Restart Claude Code. The plugin is fully gone — smoke tests verify zero traces remain.

---

## Forking & customizing

Don't like a rule? Fork it:

1. Fork `github.com/giansausa/agent-gian`
2. Edit rules in `methodology.md` or any skill in `skills/*/SKILL.md`
3. Bump the version in `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json`
4. In your `settings.json`, change the `repo` under `extraKnownMarketplaces.agent-gian.source` to point at your fork (e.g. `"repo": "yourusername/agent-gian"`)
5. Restart Claude Code. You're running your own flavor.

See [CONTRIBUTING.md](CONTRIBUTING.md) if you want to upstream your changes.

---

## Troubleshooting

### `/agent-gian` doesn't appear after restart
- Confirm your `settings.json` is valid JSON. Paste it into any JSON validator.
- Check the Claude Code logs / status for plugin-load errors.
- Confirm internet access — Claude Code needs to clone `github.com/giansausa/agent-gian` on first load.
- Verify the repo slug is exactly `giansausa/agent-gian` (no typos).

### `/agent-gian` shows "methodology missing"
You skipped the methodology prompt during setup. Re-run `/agent-gian setup` and answer yes to prompt 1.

### Pre-commit hook blocks commits with `npx: command not found`
The hook calls `npx --no-install tsc --noEmit`. You need Node.js installed with npx available. Either install Node or disable the hook via `/agent-gian setup`.

### Pre-commit hook blocks commits with `tsc: command not found`
TypeScript isn't installed locally in the package. Either run `npm install -D typescript` in the affected package, or disable the hook via `/agent-gian setup`.

### Auto-push pushing somewhere I didn't expect
Auto-push runs `git push origin <current-branch>`. Check `git remote -v` to see where `origin` points. If your `origin` has multiple push URLs (e.g. mirroring to two repos), auto-push goes to all of them.

### On Windows, `register-hook.sh` crashes with `ENOENT: /c/...`
This was fixed in v0.1.0 via the `to_native()` / `cygpath -m` helper. If you see it, you're running a pre-release or fork that predates the fix — upgrade to `v0.1.0` or later.

### On macOS/Linux, scripts warn `cygpath: command not found`
Not an error — the `to_native()` helper falls back to pass-through on systems without `cygpath`. Paths are already native-form on macOS/Linux, so this is expected.

### Running smoke tests on Windows fails with `/tmp/...` paths
Use a scratch dir inside your real HOME, not `/tmp`. Example: `TEST_HOME=$HOME/.agent-gian-smoke-test bash tests/smoke-install.sh`. Git Bash's `/tmp` doesn't round-trip through Windows Node.

---

## Still stuck?

Open an issue at [github.com/giansausa/agent-gian/issues](https://github.com/giansausa/agent-gian/issues) with:
- Your OS + Claude Code version
- Your `settings.json` (redact any secrets)
- The exact error message or symptom
