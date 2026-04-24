---
name: agent-gian-diagnose-first
version: 0.1.0
description: |
  Forces reproduce-before-fix discipline on any bug report. Three-step gate:
  (1) prove the bug with a concrete repro, (2) list 2-3 ranked root-cause
  hypotheses with evidence, (3) WAIT for user confirmation before editing.
  Use when the user reports a bug, 500, broken feature, or "why isn't X
  working". Lighter than /investigate — this is a pre-fix gate.
allowed-tools:
  - Bash
  - Read
  - Grep
  - Glob
  - AskUserQuestion
triggers:
  - diagnose first
  - diagnose before fix
  - reproduce first
---

# Diagnose First — Pre-Fix Gate

## Iron Rule
Do not edit code until the user confirms the diagnosis. Symptom-level fixes
ship broken patches.

## Three steps

### 1. Reproduce
Prove the bug with concrete evidence (failing test, exact `file:line`, or
repro sequence). If you cannot reproduce in ≤2 tool calls, ASK for info.

### 2. Rank hypotheses
```
1. [MOST LIKELY] <hypothesis> — evidence: <file:line / log / repro>
   Confirm by: <check>
2. <hypothesis> — evidence: <...>
   Confirm by: <...>
3. <hypothesis> — evidence: <...>
   Confirm by: <...>
```

### 3. Wait for confirmation
Show repro + hypotheses. STOP. Edit only after user picks one or says
"just fix it." If top hypothesis is disproven, revert and report.

## Output template
```
## Reproduced
<short description>

## Top hypotheses
1. [MOST LIKELY] ...
2. ...
3. ...

## Awaiting confirmation
Which do you want me to pursue?
```
