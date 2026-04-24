# Agent Gian

> Gian Sausa's shipping methodology — 40 rules, 7 skills, one installer.

Agent Gian is a Claude Code plugin that loads a complete working methodology into every session: communication style, analytical frameworks, code discipline, workflow patterns, and quality gates. Born from building Ask Nancy at release-manager cadence (84 sessions · 270 hours · 704 commits in 30 days).

## What's in the package

Installing Agent Gian gives you:

| Component | Count | What it is |
|---|---|---|
| **Methodology rules** | 40 | A block appended to your `~/.claude/CLAUDE.md` (between removable sentinels) that shapes how Claude talks, reasons, reviews, codes, and ships. 11 named layers: Communication, Reasoning, Analysis, Output, Code Discipline, Workflow, Session Management, Quality, Design Principles, Product Thinking, Security. |
| **Conflict resolutions** | 6 | Embedded rulings for tensions like "recommend confidently vs. don't recommend without evidence" — so Claude doesn't freeze when rules pull against each other. |
| **Slash-command skills** | 7 | See the table below. |
| **Optional hooks** | 1 | Pre-commit `tsc --noEmit` gate (opt-in during setup). Blocks git commits on TypeScript errors. Skips non-TS projects cleanly. |
| **Install scripts** | 1 | `install.sh` for the one-liner path. Also available: the manual JSON edit in [INSTALL.md](INSTALL.md). |

### The 7 skills

| Command | When you'd run it | What it does |
|---|---|---|
| `/agent-gian` | Anytime — verify install, see what's loaded, run setup or uninstall | Status dashboard + subcommand dispatcher |
| `/agent-gian-diagnose-first` | You hit a bug, a 500, or "why isn't X working" | Forces reproduce → ranked hypotheses → wait for user confirmation before any code edit |
| `/agent-gian-review` | Pre-launch, milestone checkpoint, "are we ready?" | Dimension-scored (0–100) readiness review with tiered action plan + market/business context |
| `/agent-gian-qa` | Before user testing; before shipping a feature | Whole-product audit: empty states, dead-end recovery, premium feel, business fit |
| `/agent-gian-commit` | You're about to run `git commit` | Atomicity check + `tsc --noEmit` + Conventional Commits + auto-push (if opted in) |
| `/agent-gian-pause` | End of day, switching context, about to close a session | Commits WIP, writes a handoff note, updates the active plan file |
| `/agent-gian-resume` | Start of day, returning to a project | Reads last session's handoff and restores context cleanly |

## Examples — see it in action

### Example 1: `/agent-gian-diagnose-first` on a real bug

**You type:**
> Users are reporting "Couldn't save progress" on Day 3 but it works on Days 1 and 2. Here's the error log line: `POST /api/exercise/complete 400` from ExerciseCompletion.tsx:87. `/agent-gian-diagnose-first`

**Agent Gian replies:**

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
   server's firstUncompletedDay is still 2 for this user. Confirm by:
   comparing client's effectiveDay value with server calc for a
   repro user.

3. Race condition with concurrent completions — unlikely given 400
   (not 409), but possible if a journey-switch lock was held.
   Confirm by: checking for acquireJourneyLock errors in logs.

## Awaiting confirmation
Which do you want me to pursue?
```

**Why this matters:** no code changes until you say which hypothesis to chase. No "symptom fix" (like retrying the POST) that would mask the real issue. The `} catch {}` anti-pattern gets surfaced as the reason you can't see the 400 message.

### Example 2: `/agent-gian-review` before launch

**You type:**
> We're 2 weeks from launching the wellness app. Pricing is $19.99/mo Starter, $39.99/3mo Committed, $79.99/yr All-In. `/agent-gian-review`

**Agent Gian replies (abbreviated):**

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

TIER 1 — Ship-blockers (must fix before launch, ~3-4 days)
  [ ] Switch Stripe to live mode + verify webhook · est: 4h
  [ ] Replace 14 silent catch blocks with logged errors · est: 6h
  [ ] Set Sentry production DSN · est: 1h
  [ ] Add 404 + empty-state recovery to Dashboard, Trend, Exercise · est: 8h

TIER 2 — Post-launch week 1 (credibility killers)
  [ ] Uptime monitor (Betterstack free tier) · est: 1h
  [ ] Bundle analysis + lazy image loading · est: 4h

TIER 3 — Nice-to-have
  [ ] 5-min product walkthrough video · est: half-day

## Market context
You're competing with Coral ($25/mo) and Blueheart ($60/mo) — your $19.99
Starter is priced aggressively but your UX coherence (65) is below what
paying users expect at that tier. Revenue math: 500 users x $19.99 = $120K
ARR, but churn risk is high until UX coherence hits 80+.

## Bottom line
You are ~4 days of focused work away from launchable. Biggest risk is
Stripe + operational readiness. UX gaps are fixable but won't be invisible
to early users. Fix Tier 1, launch soft (beta list), then sprint Tier 2.
```

**Why this matters:** no round-numbered "we're at 80%". Evidence-backed scoring, honest "why it's not higher", tiered plan you can actually execute against, business context so you can make the ship/don't-ship call.

### Example 3: `/agent-gian-commit` before a commit

**You type (after staging some TS changes):**
> `/agent-gian-commit`

**Agent Gian replies:**

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

**After you say y:**

```
Committed: a1b2c3d fix(exercise): surface real server error instead of silent catch
Pushed:    yes (origin/main)
```

**Why this matters:** tsc gate catches type errors before the commit lands. Atomicity check stops you from mixing unrelated concerns. Auto-push only runs because you opted in during setup.

### Example 4: `/agent-gian` — the menu

**You type:**
> `/agent-gian`

**Agent Gian replies:**

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

STATUS: 7 skills active, methodology installed, tsc hook enabled, auto-push OFF
Setup:     /agent-gian setup
Uninstall: /agent-gian uninstall
```

**Why this matters:** one command tells you exactly what Agent Gian is doing in your current session. If you ever wonder "is this active?", run `/agent-gian`.

## Install (3 minutes)

**1. One-line install:**

```bash
curl -fsSL https://raw.githubusercontent.com/giansausa/agent-gian/main/install.sh | bash
```

This merges the Agent Gian marketplace + plugin entry into your `~/.claude/settings.json` without touching anything else you already have installed. Idempotent — safe to re-run. Prefer to read before you pipe? The script is [install.sh](install.sh) — ~80 lines, Node + bash only.

**2. Restart Claude Code.** On restart, it fetches the plugin from this repo and registers the 7 skills.

**3. Run setup:**

```
/agent-gian setup
```

Answer the 3 consent prompts: methodology block = **yes**, pre-commit tsc hook = **yes** (if you use TypeScript), auto-push = **no** (unless you know the tradeoff).

**4. Verify:** run `/agent-gian` — you'll see the status dashboard listing all 7 skills and the methodology state.

📖 **Prefer manual JSON edit, or hit a snag? → [INSTALL.md](INSTALL.md)** covers the alternative path + full troubleshooting.

## Uninstall

```
/agent-gian uninstall
```

Then remove the `"agent-gian@agent-gian"` and `"agent-gian": {...}` entries from your `~/.claude/settings.json` and restart Claude Code. Smoke tests in this repo verify zero traces remain. Full steps in [INSTALL.md](INSTALL.md#fully-uninstall).

## Fork it

Fork `github.com/giansausa/agent-gian`, edit any rule in `methodology.md` or any skill in `skills/*/SKILL.md`, bump the version, and install from your fork. Your methodology, your call.

## Philosophy

See [docs/superpowers/specs/2026-04-24-agent-gian-design.md](docs/superpowers/specs/2026-04-24-agent-gian-design.md) for the full spec — why each rule exists, what source memory backed it, and how conflicts resolve.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Every rule in Agent Gian is traceable to evidence — PRs adding or changing rules must cite their source.

## License

MIT — see [LICENSE](LICENSE).
