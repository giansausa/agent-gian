---
name: agent-gian-resume
version: 0.1.0
description: |
  Pick up from yesterday's pause. Reads handoff note, summarizes current
  state, shows first action, surfaces open questions. Use at session
  start when returning to a project after /agent-gian-pause.
allowed-tools:
  - Read
  - Bash
  - Grep
  - Glob
triggers:
  - resume session
  - where were we
  - pick up where I left off
---

# Agent Gian Resume

## Steps

### 1. Find handoff note (first that exists)
1. `memory/project_next_session.md`
2. `docs/HANDOFF.md`
3. `NEXT.md`

If none: "No handoff note found. Run /agent-gian-pause at session end."

### 2. Verify repo state
```bash
git status --short
git log --oneline -5
git branch --show-current
```
Cross-check: does handoff's branch match current? Last commit match?
If diverged, flag to user.

### 3. Summary output
```
Resuming from <handoff date>.

Branch: <current> (handoff: <recorded>) ✓/✗
Last commit: <short-hash> <subject>

Where we left off:
  <from handoff>

First action:
  <from handoff>

Open questions:
  <from handoff, or "none">
```

### 4. Offer next step
"Ready to start on: <first action>? (y/n)"
If yes, hand control back. If no, ask what instead.

## Not this skill
This restores context. It does NOT start implementing the first action
automatically — that's the user's call.
