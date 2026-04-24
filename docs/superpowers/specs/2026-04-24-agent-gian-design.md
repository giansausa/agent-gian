# Agent Gian — Design Specification

**Date:** 2026-04-24
**Author:** Gian Clairon Sausa (@giansausa)
**Status:** Spec approved via brainstorming session 2026-04-24; pending implementation plan.

---

## 1. Purpose

Agent Gian is a distributable Claude Code plugin that installs a complete working methodology — communication style, analytical frameworks, code discipline, workflow patterns, and quality gates — onto any developer's Claude Code setup with a single command. It encodes the practices that let Gian Sausa ship at release-manager cadence (84 sessions · 270 hours · 704 commits in 30 days on Ask Nancy) into a form other developers can adopt.

**Non-goal:** Agent Gian is NOT a personal dotfile sync for Gian. Personal context (admin emails, Nancy-specific design tokens, dual-remote push config, project-specific domain rules) lives in a separate private dotfiles repo, not in this plugin.

## 2. Architecture

### 2.1 Distribution

Claude Code plugin published via a GitHub-hosted marketplace, following the same pattern Gian's own `settings.json` already uses for `superpowers-marketplace` (see `extraKnownMarketplaces` in `~/.claude/settings.json`).

The exact install commands depend on Claude Code's current plugin CLI — verified against official docs during implementation. The conceptual flow is:

1. User adds the marketplace source (GitHub repo: `giansausa/agent-gian-marketplace`)
2. User enables the plugin (`agent-gian`)
3. Claude Code fetches the plugin from the marketplace repo, which points at `github.com/giansausa/agent-gian` as source of truth

Users can fork `github.com/giansausa/agent-gian`, point their own marketplace repo at the fork, and install from their fork — customization without losing updates from upstream.

### 2.2 What the plugin installs

| Artifact | Location | Purpose |
|---|---|---|
| Methodology block | appended to user's `~/.claude/CLAUDE.md` between `<!-- agent-gian:start -->` / `<!-- agent-gian:end -->` sentinels | Loads the 40 rules into every session for the user, across all projects |
| Skill files (9 total) | `~/.claude/plugins/agent-gian/skills/` | Makes `/Agent-Gian` and all `/agent-*` commands available |
| Optional pre-commit tsc hook | `~/.claude/plugins/agent-gian/hooks/tsc-check-before-commit.sh` + settings.json registration | Blocks commits with tsc errors when user opts in during install |

Uninstall must remove everything: the skill files, the hook registration in settings.json, AND the methodology block from CLAUDE.md. The sentinels make the CLAUDE.md block a precise slice — the uninstall script deletes from `<!-- agent-gian:start -->` through `<!-- agent-gian:end -->` inclusive, leaving the user's own content intact above and below.

### 2.3 Claude Code priority order

Per Claude Code's instruction priority:
1. User's explicit instructions (their own CLAUDE.md content) — always wins
2. Agent Gian rules (loaded between sentinels) — override factory defaults
3. Claude Code system prompt defaults — lowest priority

This means Agent Gian can override safety defaults (e.g. auto-push) for users who opt in, but users can always override Agent Gian with their own CLAUDE.md above/below the sentinels.

## 3. The methodology (11 layers, 40 rules)

All rules source-cited from Gian's memory system. No rule is included without a verified source file or CLAUDE.md line.

### 3.1 Communication
- Peer tone — direct, no hedging, no optionality theater
- Lead with the answer + recommendation, not caveats
- A/B/C options with tradeoffs + your pick
- Ask one question at a time
- Short updates between tool calls, not running narration
- Visual-first for visual learners — push before/after mockups for each major decision, NOT after walls of text
- Don't assume or fabricate — only state what the user has told you or what you've verified

### 3.2 Reasoning
- Never recommend without verified basis — no vibes-based calls
- Don't flip recommendations under pushback (hallucination tell)
- State uncertainty once, then commit to a call
- If info is needed, ASK — never silently guess
- Reproduce bugs before fixing (the `/agent-diagnose-first` gate)

### 3.3 Analysis
- Dimension scoring 0–100 with evidence for readiness reviews
- Tiered action plans with time estimates
- Market/business context alongside technical
- Honesty over optimism; specifics over generalities

### 3.4 Output
- Copy-paste artifacts first, explanation second
- No internal checklists when paste-ready text is asked
- No section-by-section walkthroughs unless user opts in
- Split long outputs across tool calls — never hit token ceilings mid-deliverable

### 3.5 Code discipline
- Read before edit (always)
- Atomic commits — one logical change each
- Type-check before every commit
- No silent catch blocks — `} catch {}` without logging is banned
- No `git add -A` / `git add .` — explicit file staging
- Never force-push
- Auto-push after commit — no "should I push?" confirmation *(opt-in override of Claude Code default)*
- Model hardening at every layer — DB constraints + types + entry validators + read-time sanitization + exhaustive switches. Single-layer defense has escape hatches.
- Prefer ratio-based thresholds over hard cliffs

### 3.6 Workflow
- Invoke `superpowers:brainstorming` on EVERY creative work — no "too small" exceptions
- Explore project context (commits, files, memory) before asking questions
- Present design in sections with explicit approval gates
- Prefer INLINE execution over subagents for plan execution — subagents have drifted from spec before
- Multi-surface parity — web + mobile together when shared logic changes

### 3.7 Session management
- Close phases cleanly — update plan, commit, save handoff note
- `/agent-pause` to save-for-tomorrow; `/agent-resume` to pick up
- Trigger-phrase pattern: "action items", "updates" → pre-saved lists (implemented per-project)

### 3.8 Quality
- QA = whole-product coherence, not "does it crash"
- Every screen has meaningful empty state, dead-end recovery, premium feel, business sense
- UI reality check: type/test green ≠ works on device
- Device QA is the user's responsibility — hand off a checklist

### 3.9 Design principles *(stack- and brand-agnostic)*
- Mobile-first evaluation (test at realistic widths)
- Less is more — reduce clutter, shorter text, more whitespace
- Premium feel over prototype chunkiness
- Emphasis via weight/structure, not colored highlights
- Mockup fidelity — use the app's real icon system, never emoji placeholders

### 3.10 Product thinking
- Friction reduction is first-order
- Smart defaults > rich configurability
- Inferred data > re-entered data
- When presenting options, call out which minimizes taps/choices

### 3.11 Security / privacy
- Proactively flag privacy & security implications — don't wait for the user to ask
- Public-visibility ops (repos, APIs, env vars, links) surface the privacy call BEFORE proceeding

## 4. Skills (9 total)

### 4.1 Core skills (installed by default)

| Skill | Role | Enforces |
|---|---|---|
| `/Agent-Gian` | Menu + status dashboard. First invocation shows what's loaded + available sub-skills. Subsequent invocations verify the plugin is still active and lists skills. | Layer I |
| `/agent-diagnose-first` | Pre-fix gate for any bug report. Three-step protocol: reproduce → ranked hypotheses → wait for user confirmation before editing code. | Layer II |
| `/agent-review` | Dimension-scored readiness review. Produces 0–100 scores per dimension with evidence, overall composite, tiered action plan with time estimates, market/business context. | Layer III |
| `/agent-qa` | Whole-product QA audit — empty states, dead-end recovery, premium feel, business fit. NOT a crash check. | Layer VIII |
| `/agent-commit` | Verifies staged changes are atomic (one logical change) + tsc-clean. Auto-pushes after commit if opted in. | Layer V |
| `/agent-pause` | Save-for-tomorrow: commits WIP, writes handoff note to `project_next_session.md`, updates plan file status. | Layer VII |
| `/agent-resume` | Loads the last session's handoff note, summarizes current state, suggests what to tackle first. | Layer VII |

### 4.2 Opt-in stack-specific skills

| Skill | Stack | Role |
|---|---|---|
| `/agent-ship-mobile` | Expo / React Native | Version bump → tsc → atomic commit → `eas build` → `eas submit` → copy-paste tester notes |
| `/agent-ship-web` | Next.js / Vercel | tsc → test → atomic commit → push → terse deploy summary |

Opt-in extensions can be turned on at install time or later. Users on other stacks skip them cleanly and nothing about the core install depends on them.

## 5. Installation UX

### 5.1 First install flow

The plugin install itself follows Claude Code's native plugin mechanism (exact CLI verified during implementation — same pattern as `superpowers-marketplace`). The plugin ships in a minimal state: core skills registered, methodology block NOT yet written to CLAUDE.md.

The user then runs `/Agent-Gian setup` once, which is where the consent prompts happen via `AskUserQuestion`:

1. "Append the 40-rule methodology block to your `~/.claude/CLAUDE.md`?" (required — if no, plugin is inert)
2. "Enable the pre-commit `tsc --noEmit` hook? (Blocks commits with type errors.)"
3. "Enable auto-push after commits? **This overrides Claude Code's default `never push without explicit ask` safety.**" — default answer: NO
4. "Enable `/agent-ship-mobile` (Expo/EAS/TestFlight)?"
5. "Enable `/agent-ship-web` (Next.js/Vercel)?"

The setup command is idempotent — re-running it shows current settings and lets users toggle individual items. Everything written by setup is tracked so `/Agent-Gian uninstall` can reverse it precisely.

This two-step pattern (plugin install → explicit setup with consent) avoids any assumption about whether Claude Code supports interactive prompts during plugin install itself.

### 5.2 `/Agent-Gian` invocation output

```
🧠  Agent Gian v1.0 — by @giansausa
─────────────────────────────────────
A shipping methodology born from building Ask Nancy.
github.com/giansausa/agent-gian

ACTIVE (loaded into your session):
  • Communication: A/B/C + recommendation, terse, visual-first
  • Output: copy-paste first, no internal checklists
  • Reasoning: no hallucinated recommendations, ask don't guess
  • Code: atomic commits, tsc-before-commit, model hardening
  • Workflow: always brainstorm creative work, inline execution
  • Quality: whole-product QA, device reality check
  • Product: friction reduction, smart defaults

CORE SKILLS:
  /agent-diagnose-first    Bug pre-fix gate
  /agent-review            Dimension-scored readiness review
  /agent-qa                Whole-product QA audit
  /agent-commit            Atomic commit + tsc + auto-push
  /agent-pause             Save-for-tomorrow handoff
  /agent-resume            Load handoff, restore context

STACK EXTENSIONS:
  ✓ /agent-ship-mobile     Expo → EAS → TestFlight
  ✗ /agent-ship-web        Not installed (run /plugin enable to add)

STATUS: 7 skills active · 1 extension · methodology loaded
Uninstall: /plugin remove agent-gian
```

## 6. Conflict resolution

Agent Gian contains rules that can pull in opposite directions. Explicit resolutions are encoded in the methodology block so users don't have to infer them.

| Tension | Resolution |
|---|---|
| **Recommend confidently vs. don't recommend without verified basis** | If verified → commit to the recommendation. If not verified → state it once ("haven't checked X — let me look before recommending") and offer to verify. No middle-ground hedged lists. |
| **Atomic commits vs. multi-surface parity** | Multi-surface changes = multiple atomic commits, one per platform, labeled by platform. Not one big combined commit. |
| **Brainstorm everything vs. skip "too simple"** | Creative/feature work → always brainstorm. Pure bugfixes the user has already scoped → skip. The banned behavior is rationalizing "this is too simple" for actual feature work. |
| **Inline execution vs. using subagents** | Inline for plan execution (high-fidelity work). Subagents fine for parallel research/catalog/exploration where drift doesn't matter. |
| **Smart defaults vs. ask one question at a time** | Ask only major A/B/C decisions; infer minor choices from smart defaults. Don't bury the user in micro-decisions. |
| **Auto-push vs. Claude Code default "never push without explicit ask"** | Agent Gian explicitly overrides the default. Users opt in during install; they can decline and keep the safety default. |

## 7. Explicitly excluded (kept project-scoped, NOT in Agent Gian)

Project-specific rules stay in each project's `CLAUDE.md` or memory folder. They do not ship with Agent Gian.

| Project | Excluded items |
|---|---|
| Ask Nancy | Color tokens (#FCF7ED cream, #2A2520 charcoal, #FF30CC pink, #CCFD28 lime); fonts (Fraunces, Barlow, DM Sans); `border-radius: 999px` pill buttons; "no clinical language" rule; voice-pull-only design; subscription tier structure; admin email; dual-remote push config |
| CarPMS | Ford Ranger Raptor smart defaults; MaterialCommunityIcons-specific mockup fidelity; Vios incident specifics; 5,000km cliff-to-ratio migration details |
| SmartGasPH | Solo-developer privacy context (the PRINCIPLE — proactive security flagging — IS included in Agent Gian; only the specific project context is excluded) |

## 8. Versioning & evolution

- Semantic versioning: `MAJOR.MINOR.PATCH`
  - MAJOR: breaking changes to skill contracts or methodology (rule removals, renamed skills)
  - MINOR: new skills, new rules, additive changes
  - PATCH: bug fixes, documentation, rule wording refinements
- Each release tagged in the repo
- Users get updates via `/plugin update agent-gian`
- A `CHANGELOG.md` at repo root documents every version
- Rules added or removed must cite their source (a user feedback memory, a behavioral pattern from an insights report, or a reported pain point in GitHub issues) — no rule ships on vibes

## 9. Failure modes & mitigations

| Risk | Mitigation |
|---|---|
| User's existing CLAUDE.md conflicts with Agent Gian rules | Sentinels make Agent Gian's block visible + editable. User's own CLAUDE.md content above/below the sentinels always wins (per Claude Code priority). |
| Auto-push footgun for users who didn't understand the override | Install flow requires explicit `y/n` consent. Default answer is `n` (preserve safety). Users who say `y` get a README link explaining the tradeoff. |
| Subagents drift from methodology | Agent Gian's own skills prefer inline execution by default. `superpowers:subagent-driven-development` can still be invoked but Agent Gian's skills warn about drift when the user selects it. |
| Skill name collisions with other installed skills | All skills are namespaced `agent-*` except the menu (`/Agent-Gian`). Any collision is intentional/user-installed. |
| Plugin breaks on Claude Code version bumps | CI runs install + skill-invocation smoke tests against the current Claude Code stable. Versions flagged incompatible in `plugin.json`. |
| Methodology becomes stale | Annual review pass against the latest insights reports; rules without active use across ≥3 user projects get deprecation warnings. |

## 10. Success criteria

An Agent Gian install is successful when:
1. A new user runs the install command and `/Agent-Gian` responds within 30 seconds with the menu
2. All 7 core skills appear in Claude Code's skill list after install
3. `/plugin remove agent-gian` cleanly restores the user's CLAUDE.md (sentinels removed, block deleted)
4. A user can fork the repo, edit a skill, and have the edited version load on their own machine within 2 commands
5. The uninstall flow leaves zero traces — running `/Agent-Gian uninstall` followed by `/plugin remove agent-gian` returns the user's Claude Code setup to its pre-install state (verified by diff-ing CLAUDE.md and settings.json).

## 11. Open questions for implementation plan

- Exact plugin manifest format (need to study Claude Code's plugin system — similar to `superpowers-marketplace` pattern already in Gian's settings.json)
- Update mechanism — in-place vs. full re-install
- Telemetry — anonymous usage counts per skill? Opt-in only
- License — MIT for maximum adoption? Permissive so forks are unambiguous
- Marketplace distinction — is the marketplace repo the same as the plugin repo, or a separate thin manifest?

These are implementation concerns, not design concerns. They belong in the writing-plans phase.

## 12. What comes next

1. User reviews this spec
2. On approval, invoke `superpowers:writing-plans` to break this into numbered, executable tasks with exact file paths and code
3. Inline execution of the plan (per Gian's inline-over-subagents preference)
4. First release: v0.1.0 with core skills only, no stack-specific extensions, no telemetry
5. Iteration toward v1.0 as real users install and give feedback
