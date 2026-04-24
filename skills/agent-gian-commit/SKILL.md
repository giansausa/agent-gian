---
name: agent-gian-commit
version: 0.1.0
description: |
  Atomic commit + tsc gate. Verifies staged changes are one logical unit,
  runs tsc --noEmit on affected packages, commits with Conventional
  Commits format, auto-pushes if opted in. Use when user says "commit
  this" or is about to run git commit themselves.
allowed-tools:
  - Bash
  - Read
  - Grep
  - AskUserQuestion
triggers:
  - commit this
  - make a commit
  - agent commit
---

# Agent Gian Commit — Atomic Gate

## Sequence (stop on first failure)

### 1. Show staged state
```bash
git status --short
git diff --cached --stat
```
If nothing staged, stop and ask user what to stage.

### 2. Atomicity check
If staged files span unrelated concerns, ask: "Split into separate
commits? (y/n)". If yes, help split.

### 3. Type-check affected packages
For each package with staged `.ts`/`.tsx` files:
```bash
cd <package-dir> && npx --no-install tsc --noEmit
```
If errors, STOP. Surface errors. Do not proceed.

### 4. Build Conventional Commits message
`<type>(<scope>): <subject>` — type ∈ {feat, fix, docs, style, refactor,
perf, test, build, ci, chore}. Subject lowercase, imperative, ≤72 chars.
Ask user for type + subject if not obvious from diff.

### 5. Commit
```bash
git commit -m "<type>(<scope>): <subject>

<body if needed>

Co-Authored-By: Claude Opus 4.7 <noreply@anthropic.com>"
```

### 6. Auto-push (if opted in)
Read `~/.agent-gian/config`. If `auto_push=true`:
```bash
git push origin <current-branch>
```
Otherwise print "Committed. Push manually when ready."

### 7. Terse summary
```
Committed: <short hash> <subject>
Pushed:    <yes / deferred>
```

## Never do
- Never `git add -A` or `git add .`.
- Never skip step 3 (tsc).
- Never force-push.
- Never commit with non-Conventional-Commits subject.
