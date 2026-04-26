# Changelog

All notable changes to Agent Gian are documented here.
This project uses semantic versioning (MAJOR.MINOR.PATCH).

## [Unreleased]

### Added
- `/agent-gian-pitch-site` — one-shot Carnage-style pitch site scaffold. Captures every decision, every code template, and every Gemini Pro prompt from the Carnage Off-road Autoshop build (carnageautoshop.vercel.app) so the same workflow can be replayed for any small business in a fresh project. Stack: Next.js 16 + Tailwind v4 + Vercel. Includes a 13-question onboarding interview, full file tree, embedded code for all 9 home sections + 4 product components + 5 primitives + Quote modal, the FB photo-extraction trick (mobile-UA curl), 11 Playwright smoke tests, the Taglish FB outreach DM template, pricing guidance (PHP 20k–45k tiers), and a Bayan Coffee Roasters worked example. Skill folder: `skills/agent-gian-pitch-site/`. Total skill count is now 8.

### Fixed
- `curl | bash` installer now produces a plugin that actually loads. Previously the marketplace manifest declared `name: agent-gian-marketplace` while `install.sh` registered it as `agent-gian`, so Claude Code cached the marketplace under the canonical name from the manifest and the `agent-gian@agent-gian` plugin ID never resolved. Renamed the manifest `name` to `agent-gian` and added self-healing cleanup of the stale cache dir + `known_marketplaces.json` entry on re-run.

### Changed
- README: installation moved above the feature tour; prose tightened throughout.
- README: skill count bumped 7 → 8, table extended with `/agent-gian-pitch-site`, dashboard mock includes new entry.

## [0.1.0] — 2026-04-24

### Added
- Initial release.
- 7 core skills: `/agent-gian` (menu + setup + uninstall), `/agent-gian-diagnose-first`, `/agent-gian-review`, `/agent-gian-qa`, `/agent-gian-commit`, `/agent-gian-pause`, `/agent-gian-resume`.
- 40-rule methodology block appended to user's `~/.claude/CLAUDE.md` between `<!-- agent-gian:start -->` / `<!-- agent-gian:end -->` sentinels.
- Optional pre-commit `tsc --noEmit` hook (opt-in).
- Install/uninstall scripts that leave zero traces on removal.
- 6 conflict-resolution rules embedded in the methodology block.

### Not included (deferred)
- `/agent-gian-ship-mobile` and `/agent-gian-ship-web` stack-specific extensions — planned for v0.2.0.
- Telemetry — not planned; see spec §11 open question.
