# Contributing to Agent Gian

## Core principle

Every rule in Agent Gian is traceable to evidence. No rule ships on vibes.

If you want to propose a new rule, modify one, or remove one, your PR must cite:
- The **source** for the change (a user feedback memory file, a published article, a reported pain point in a GitHub issue, a behavioral pattern documented elsewhere)
- The **reasoning** for why this generalizes across projects (not just one)
- The **failure mode** the rule prevents

## Adding a new skill

1. Create `skills/<skill-name>/SKILL.md` with the standard frontmatter (name, version, description, allowed-tools, triggers).
2. Write the body with: clear purpose, step-by-step protocol, "never do" guardrails.
3. Add an entry to the `/agent-gian` menu dashboard (in `skills/agent-gian/SKILL.md`).
4. Update `CHANGELOG.md` with the addition.
5. Add a smoke test entry to `tests/smoke-invoke.sh`.
6. Bump the MINOR version in `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json`.

## Modifying a rule

1. Edit the rule in `methodology.md`.
2. Document the reason in the commit message (cite source).
3. If the change is a reversal (e.g., flipping from "always do X" to "never do X"), bump the MAJOR version.
4. Update `CHANGELOG.md` under a new Unreleased section.

## Testing locally

```bash
# Static check — all skills have valid frontmatter
bash tests/smoke-invoke.sh

# Full install → uninstall cycle against a scratch HOME
TEST_HOME=$HOME/.agent-gian-smoke-test bash tests/smoke-install.sh
TEST_HOME=$HOME/.agent-gian-smoke-test bash tests/smoke-uninstall.sh
rm -rf "$HOME/.agent-gian-smoke-test"
```

**Note for Windows users:** use a scratch dir inside your real HOME, not `/tmp`. Git Bash's `/tmp` maps to `AppData\Local\Temp` but Windows Node treats `/tmp` literally as `C:\tmp` which doesn't exist — the path doesn't round-trip.

## Commit message format

Conventional Commits:
- `feat(skill): add /agent-gian-<name>`
- `fix(hook): tsc hook crashes on monorepo root`
- `docs: update INSTALL troubleshooting`
- `refactor: rename skill prefix`

Subject lowercase, imperative, ≤72 chars.

## What NOT to contribute

- Project-specific rules (Nancy's "no clinical language", stack-specific ship flows for other frameworks) — those belong in forks or stack-specific marketplace entries.
- Changes that add friction without a corresponding benefit documented in the commit.
- Telemetry, tracking, analytics — not accepting.
- Opinionated taste changes (colors, fonts) — belong in user's project `CLAUDE.md`.

## Version discipline

Follow semver:
- MAJOR: removing a skill, renaming a slash command, reversing a rule
- MINOR: adding a skill, adding a rule, additive hook
- PATCH: wording, docs, bug fixes in scripts

Every release gets tagged: `git tag v0.1.0 && git push --tags`.
