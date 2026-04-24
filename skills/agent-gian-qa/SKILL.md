---
name: agent-gian-qa
version: 0.1.0
description: |
  Whole-product QA audit. Checks every screen for empty states, dead-end
  recovery, premium feel, and business fit — not just "does it crash."
  Use before testing with real users, before shipping, or when user says
  "QA" / "audit" / "does this make sense as a product".
allowed-tools:
  - Read
  - Bash
  - Grep
  - Glob
triggers:
  - qa audit
  - product audit
  - whole product qa
---

# Agent Gian QA

## Six checks per screen

1. **Empty states** — meaningful vs blank div
2. **Error recovery** — actionable recovery path vs "something went wrong"
3. **Dead ends** — clear next action always available
4. **Premium feel** — paid product vs prototype
5. **Domain accuracy** — factual/domain content verified + sourced
6. **Business fit** — would a paying user value this?

## Output format

Table: rows = screens, columns = 6 checks, cells = ✓/✗/?. Plus "Critical
gaps" section listing ✗ rows with severity + fix estimate.

```
| Screen       | Empty | Error | DeadEnd | Premium | Domain | Biz |
|--------------|-------|-------|---------|---------|--------|-----|
| Dashboard    |   ✓   |   ✓   |    ✓    |    ✓    |   ✓    |  ✓  |
| Exercise     |   ✗   |   ✓   |    ✗    |    ✓    |   ✓    |  ✓  |

## Critical gaps
- [BLOCKER] Exercise — no confirmation state · est: 2h
```

## Not this skill
For code bugs, use `/agent-gian-diagnose-first`. For readiness scoring,
use `/agent-gian-review`.
