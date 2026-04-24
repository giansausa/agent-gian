# Agent Gian

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/giansausa/agent-gian/main/install.sh | bash
```

Then restart Claude Code, run `/agent-gian setup`, and verify with `/agent-gian`.

**Step-by-step:**

1. **Run the one-liner above.** Merges the marketplace + plugin entry into `~/.claude/settings.json` without touching anything else. Idempotent. Read it first if you want — ~80 lines, Node + bash only: [install.sh](install.sh).
2. **Restart Claude Code.** It fetches the plugin from this repo and registers the 7 skills.
3. **Run `/agent-gian setup`.** Three prompts: methodology block (**yes**), pre-commit tsc hook (**yes** for TS projects), auto-push (**no** unless you know the tradeoff).
4. **Verify with `/agent-gian`** — you should see the status dashboard.

Hit a snag or prefer manual JSON? → **[INSTALL.md](INSTALL.md)** has the alternative path + troubleshooting.

---

> Gian Sausa's shipping methodology — 40 rules, 7 skills, one installer.

A Claude Code plugin that loads a complete working methodology into every session: communication style, analytical frameworks, code discipline, workflow patterns, and quality gates. Born from building Ask Nancy at release-manager cadence (84 sessions · 270 hours · 704 commits in 30 days).

## What this changes

Three before/afters — one per methodology pillar the plugin enforces.

### Communication

**Default Claude**
> I could perhaps help you with that. There are several approaches we might consider. Let me walk through a few options in detail before making a recommendation…

**Agent Gian**
> A/B/C. A = fastest, skips tests. B = safer, slower. C = hybrid. Pick B — it's two weeks from launch; skipped tests bite post-ship.

### Reasoning

**Default Claude (after user pushback)**
> You're right — actually let's do A instead.

**Agent Gian**
> I was confident in B because of the launch timeline. If you have info I don't, tell me what changed. Otherwise I'm staying on B.

### Analysis

**Default Claude**
> The app is in good shape overall. A few small things to polish before launch.

**Agent Gian**
> Composite 66/100. Code 72, UX 65, Ops 40. Ops is the ship-blocker: no uptime monitor, no on-call. ~4 days of Tier 1 work to launchable.

*Plus 8 more pillars — Output, Code Discipline, Workflow, Session Mgmt, Quality, Design, Product, Security. See [methodology.md](methodology.md) for all 40 rules.*

## What you get

| Component | Count | What it is |
|---|---|---|
| **Methodology rules** | 40 | Appended to `~/.claude/CLAUDE.md` (between removable sentinels). 11 layers: Communication, Reasoning, Analysis, Output, Code Discipline, Workflow, Session Management, Quality, Design Principles, Product Thinking, Security. |
| **Conflict resolutions** | 6 | Embedded rulings for rule tensions — so Claude doesn't freeze when rules pull against each other. |
| **Slash-command skills** | 7 | See table below. |
| **Optional hooks** | 1 | Pre-commit `tsc --noEmit` gate (opt-in). Blocks commits on TS errors. Skips non-TS projects. |
| **Install scripts** | 1 | `install.sh` for the one-liner. Manual JSON edit documented in [INSTALL.md](INSTALL.md). |

### The 7 skills

| Command | When you'd run it | What it does |
|---|---|---|
| `/agent-gian` | Anytime — verify install, see what's loaded, setup, uninstall | Status dashboard + subcommand dispatcher |
| `/agent-gian-diagnose-first` | Bug, 500, "why isn't X working" | Forces reproduce → ranked hypotheses → wait for confirmation before editing |
| `/agent-gian-review` | Pre-launch, milestone checkpoint, "are we ready?" | Dimension-scored (0–100) readiness review with tiered action plan |
| `/agent-gian-qa` | Before user testing or shipping | Whole-product audit: empty states, dead-end recovery, premium feel |
| `/agent-gian-commit` | About to run `git commit` | Atomicity check + `tsc --noEmit` + Conventional Commits + auto-push (if opted in) |
| `/agent-gian-pause` | End of day, context switch | Commits WIP, writes handoff note, updates active plan file |
| `/agent-gian-resume` | Start of day, returning to a project | Reads last handoff, restores context cleanly |

## Examples

### `/agent-gian-diagnose-first` on a real bug

**You:**
> Users report "Couldn't save progress" on Day 3 but it works Days 1–2. Error: `POST /api/exercise/complete 400` from ExerciseCompletion.tsx:87. `/agent-gian-diagnose-first`

**Agent Gian:**

```
## Reproduced
Confirmed: POST /api/exercise/complete returns 400 for planDay=3 from
ExerciseCompletion.tsx:87. The `catch {}` on line 89 swallows the server
message, collapsing every distinct 400 reason into the same alert.

## Top hypotheses
1. [MOST LIKELY] Sequential gate — server rejects Day 3 because Day 2
   hasn't been completed. Evidence: /api/exercise/complete enforces
   sequential progression (lib/day-calculation.ts:42). Confirm by:
   query exercise_completions WHERE user_id=$1 AND plan_day=2.

2. Stale client UI after track switch — UI shows Day 3 unlocked but
   server's firstUncompletedDay is still 2 for this user.

3. Race condition with concurrent completions — unlikely given 400
   (not 409), but possible if a journey-switch lock was held.

## Awaiting confirmation
Which do you want me to pursue?
```

No code changes until you pick a hypothesis. No symptom-fix. The `} catch {}` anti-pattern gets surfaced as the reason you can't see the 400 message.

### `/agent-gian-review` before launch

**You:**
> We're 2 weeks from launching the wellness app. Pricing: $19.99/mo, $39.99/3mo, $79.99/yr. `/agent-gian-review`

**Agent Gian (abbreviated):**

```
## Readiness assessment

| Dimension            | Score | Why not higher                                       |
|----------------------|-------|------------------------------------------------------|
| Code quality         |  72   | 14 `catch {}` blocks without logging across mobile   |
| Security             |  85   | Secrets rotated; missing Sentry prod DSN             |
| Performance          |  80   | Bundle 2.1MB; no image lazy-loading on Dashboard     |
| UX coherence         |  65   | 3 screens with blank empty states; no 404 recovery   |
| Business readiness   |  55   | Stripe still in test mode; webhook not verified live |
| Operational readiness|  40   | No alerts, no uptime monitor, no on-call rotation    |

Composite: 66/100 — NOT ready for public launch.

## Action plan

TIER 1 — Ship-blockers (~3-4 days)
  [ ] Switch Stripe to live mode + verify webhook · 4h
  [ ] Replace 14 silent catch blocks with logged errors · 6h
  [ ] Set Sentry production DSN · 1h
  [ ] Add 404 + empty-state recovery to Dashboard, Trend, Exercise · 8h

TIER 2 — Post-launch week 1 (credibility killers)
  [ ] Uptime monitor · 1h
  [ ] Bundle analysis + lazy image loading · 4h

## Bottom line
~4 days of focused work from launchable. Biggest risk is Stripe + ops
readiness. Fix Tier 1, launch soft (beta list), sprint Tier 2.
```

Evidence-backed scoring, honest "why it's not higher," tiered plan you can execute against.

### `/agent-gian-commit` before a commit

**You (after staging some TS changes):** `/agent-gian-commit`

**Agent Gian:**

```
Staged:
  apps/web/lib/exercise-completion.ts
  apps/web/components/ExerciseError.tsx
  apps/mobile/components/ExerciseCompletion.tsx

Atomicity check: ✓ all staged files relate to exercise-completion error handling.

Running tsc --noEmit on affected packages:
  apps/web   — PASS (0 errors)
  apps/mobile — PASS (0 errors)

Proposed commit message (Conventional Commits):
  fix(exercise): surface real server error instead of silent catch

  Replaces `} catch {}` with logged ApiError handling on both web and
  mobile. Users now see "Complete Day 2 first" instead of the generic
  "Couldn't save progress" alert.

Commit? (y/n)
```

tsc gate catches type errors before the commit lands. Atomicity check stops mixed concerns. Auto-push only runs if you opted in during setup.

### `/agent-gian` — the menu

```
Agent Gian v0.1.0 — by @giansausa

ACTIVE (loaded into your session):
  Communication · Output · Reasoning · Code · Workflow · Quality · Product

CORE SKILLS:
  /agent-gian-diagnose-first    Bug pre-fix gate
  /agent-gian-review            Dimension-scored readiness review
  /agent-gian-qa                Whole-product QA audit
  /agent-gian-commit            Atomic commit + tsc + auto-push
  /agent-gian-pause             Save-for-tomorrow handoff
  /agent-gian-resume            Load handoff, restore context

STATUS: 7 skills active, methodology installed, tsc hook enabled, auto-push OFF
Setup:     /agent-gian setup
Uninstall: /agent-gian uninstall
```

One command tells you exactly what Agent Gian is doing in your session.

## Uninstall

```
/agent-gian uninstall
```

Then remove the `"agent-gian@agent-gian"` and `"agent-gian": {...}` entries from `~/.claude/settings.json` and restart. Smoke tests in this repo verify zero traces remain. Full steps in [INSTALL.md](INSTALL.md#fully-uninstall).

## Fork it

Fork `github.com/giansausa/agent-gian`, edit any rule in `methodology.md` or any skill in `skills/*/SKILL.md`, bump the version, install from your fork. Your methodology, your call.

## Philosophy

See [docs/superpowers/specs/2026-04-24-agent-gian-design.md](docs/superpowers/specs/2026-04-24-agent-gian-design.md) for the full spec — why each rule exists, what source memory backed it, how conflicts resolve.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Every rule is traceable to evidence — PRs adding or changing rules must cite their source.

## License

MIT — see [LICENSE](LICENSE).
