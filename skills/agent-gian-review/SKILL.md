---
name: agent-gian-review
version: 0.1.0
description: |
  Dimension-scored readiness review. Produces 0-100 scores per dimension
  with evidence, overall composite, tiered action plan with time estimates,
  and market/business context alongside technical assessment. Use for
  pre-launch assessments, milestone checkpoints, "where are we" / "are we
  ready" moments.
allowed-tools:
  - Read
  - Bash
  - Grep
  - Glob
triggers:
  - readiness review
  - are we ready
  - where are we
  - launch review
---

# Agent Gian Review

## Output structure

### 1. Dimensions (0-100 each, 5-8 rows)
Pick relevant dimensions (examples): code quality, security, performance,
UX coherence, business readiness, operational readiness, content quality,
accessibility. For each: score + evidence (file paths, commits, test
results) + "why not higher" in one sentence.

### 2. Composite score
Honest number. No rounding up.

### 3. Tiered action plan
```
TIER 1 — Ship-blocker (must fix before launch)
  [ ] <item> · est: <time>
TIER 2 — Post-launch week 1 (credibility killers)
  [ ] <item> · est: <time>
TIER 3 — Nice-to-have
  [ ] <item> · est: <time>
```

### 4. Market / business context
1-2 paragraphs: competitive positioning, probability estimate with
conditions, revenue math if pricing known.

### 5. Bottom line
One paragraph. No fluff. What to do next.

## Style
- No hedging. If not ready, say so.
- Specifics over generalities — cite files, numbers, commits.
- Use a table for dimension scores.
