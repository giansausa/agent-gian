---
name: agent-gian-pause
version: 0.1.0
description: |
  Save-for-tomorrow handoff. Commits WIP, writes session handoff note
  capturing what's done + what's next + first action on resume, updates
  active plan file status. Use when user says "save for tomorrow", "pause
  here", "checkpoint", or at session end.
allowed-tools:
  - Bash
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - AskUserQuestion
triggers:
  - save for tomorrow
  - pause session
  - checkpoint this
  - wrap up
---

# Agent Gian Pause

## Steps (in order)

### 1. Capture WIP
If `git status --short` shows uncommitted changes, ask to commit as WIP.
If yes: `git add -u && git commit -m "wip: session pause $(date +%Y-%m-%d)"`.
Push if auto-push enabled.

### 2. Gather context
Run `git log --oneline -10` and `git branch --show-current`.
Ask: "One-line description of where you're leaving off?"

### 3. Pick handoff location (first that exists)
1. `memory/project_next_session.md` (if `memory/` exists)
2. `docs/HANDOFF.md` (if `docs/` exists)
3. `NEXT.md` at repo root (fallback)

Write file:
```markdown
# Next Session Handoff

**Paused:** <YYYY-MM-DD HH:MM>
**Branch:** <current-branch>
**Last commit:** <short-hash> <subject>

## Where we left off
<user's description>

## Done today
<bulleted list from git log since yesterday>

## First action on resume
<user's stated next action>

## Open questions / blockers
<any flagged issues>
```

### 4. Update active plan (if exists)
Glob `docs/superpowers/plans/*.md`. If found, ask to append status line:
```markdown
---
**Status (YYYY-MM-DD):** Paused. See <handoff path> for resume point.
```

### 5. Final commit
```bash
git add <handoff path> <plan path if updated>
git commit -m "chore(handoff): pause session — <one-line description>"
```
Push if auto-push enabled.

### 6. Summary
```
Session paused.
  Handoff: <path>
  Plan:    <updated / n/a>
  Commit:  <hash>
  Resume:  /agent-gian-resume
```
