---
name: agent-gian
version: 0.1.0
description: |
  Agent Gian control surface — menu, setup, and uninstall. Invoke with no
  args to see the status dashboard. Invoke with `setup` to run consent
  prompts. Invoke with `uninstall` to reverse everything Agent Gian added.
  Use when the user says "agent gian", "agent gian setup",
  "agent gian uninstall", or when they want to check what's loaded.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
  - AskUserQuestion
triggers:
  - agent gian
  - agent-gian
  - agent gian setup
  - agent gian uninstall
---

# Agent Gian — Control Surface

## Dispatch

Parse the first argument:
- No argument / `status` / `menu` → show the status dashboard
- `setup` → run the setup flow
- `uninstall` → run the uninstall flow
- anything else → show the dashboard and list recognized subcommands

## Status dashboard

Check whether `~/.claude/CLAUDE.md` contains the `<!-- agent-gian:start`
sentinel. If yes, methodology is installed; if no, prompt the user to run
`/agent-gian setup`. Then render (update status markers based on actual
install state):

```
Agent Gian v0.1.0 — by @giansausa
A shipping methodology born from building Ask Nancy.

ACTIVE (loaded into your session):
  Communication · Output · Reasoning · Code · Workflow · Quality · Product

CORE SKILLS:
  /agent-gian-diagnose-first    Bug pre-fix gate
  /agent-gian-review            Dimension-scored readiness review
  /agent-gian-qa                Whole-product QA audit
  /agent-gian-commit            Atomic commit + tsc + auto-push
  /agent-gian-pause             Save-for-tomorrow handoff
  /agent-gian-resume            Load handoff, restore context

STATUS: <N> skills active, methodology <installed|missing>
Setup:     /agent-gian setup
Uninstall: /agent-gian uninstall
```

## Setup flow

Ask via `AskUserQuestion` one at a time:

1. "Append the 40-rule methodology block to your `~/.claude/CLAUDE.md`?
   This is what makes Agent Gian active in every session." — yes/no
   - No → stop, report "Installed but inert."
   - Yes → run `bash scripts/install-methodology-block.sh`

2. "Enable the pre-commit `tsc --noEmit` hook? Blocks commits with type
   errors in staged TS files. Skips for non-TS projects." — yes/no
   - Yes → run `bash scripts/register-hook.sh`

3. "Enable auto-push after commit? WARNING: overrides Claude Code's
   default 'never push without explicit ask' safety. Agent Gian skills
   will `git push` immediately after every successful commit." — yes/no
   - Write `auto_push=true|false` to `~/.agent-gian/config`

Final report:
```
Agent Gian setup complete.
  methodology block installed
  pre-commit tsc hook enabled / skipped
  auto-push enabled / safety default kept
Run /agent-gian to verify.
```

## Uninstall flow

Confirm once: "Remove Agent Gian? This deletes the methodology block,
unregisters the hook, removes `~/.agent-gian/config`. Skill files stay
until you run `/plugin remove agent-gian`." — yes/no

If yes:
1. `bash scripts/uninstall-methodology-block.sh`
2. `bash scripts/unregister-hook.sh`
3. Delete `~/.agent-gian/config`

Report what was removed.

## Never do
- Write to CLAUDE.md outside the sentinel block.
- Skip uninstall confirmation.
- Enable auto-push without explicit yes.
