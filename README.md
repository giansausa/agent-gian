# Agent Gian

> Gian Sausa's shipping methodology — 40 rules, 7 skills, one installer.

Agent Gian is a Claude Code plugin that loads a complete working methodology into every session: communication style, analytical frameworks, code discipline, workflow patterns, and quality gates. Born from building Ask Nancy at release-manager cadence (84 sessions · 270 hours · 704 commits in 30 days).

## What you get

- **40 rules** across 11 layers (communication, reasoning, analysis, output, code, workflow, session mgmt, quality, design, product, security) — loaded into every Claude Code session via your `CLAUDE.md`.
- **7 skills**:
  - `/agent-gian` — menu + setup + uninstall
  - `/agent-gian-diagnose-first` — bug pre-fix gate
  - `/agent-gian-review` — dimension-scored readiness review
  - `/agent-gian-qa` — whole-product audit
  - `/agent-gian-commit` — atomic commit gate
  - `/agent-gian-pause` — session handoff
  - `/agent-gian-resume` — pick up tomorrow
- **Optional pre-commit tsc hook** — blocks commits with TypeScript errors.
- **Explicit conflict resolutions** — 6 tensions between rules with explicit rulings.

## Install

1. Add `giansausa/agent-gian` as a Claude Code plugin marketplace source. The exact CLI verb depends on your Claude Code version — check `/plugin --help` or the Claude Code docs.
2. Enable the `agent-gian` plugin from that marketplace.
3. Run `/agent-gian setup` and answer the three consent prompts (methodology block, pre-commit hook, auto-push).

See [INSTALL.md](INSTALL.md) for the detailed flow + troubleshooting.

## Uninstall

```
/agent-gian uninstall    # reverse everything Agent Gian wrote
/plugin remove agent-gian   # remove the skill files
```

This removes the methodology block from your `CLAUDE.md`, unregisters the hook, deletes `~/.agent-gian/config`, and (after the second command) removes the skill files. Smoke tests verify zero traces remain.

## Fork it

Fork `github.com/giansausa/agent-gian`, edit any rule in `methodology.md` or any skill in `skills/*/SKILL.md`, bump the version, and install from your fork. Your methodology, your call.

## Philosophy

See [docs/superpowers/specs/2026-04-24-agent-gian-design.md](docs/superpowers/specs/2026-04-24-agent-gian-design.md) for the full spec — why each rule exists, what source memory backed it, and how conflicts resolve.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Every rule in Agent Gian is traceable to evidence — PRs adding or changing rules must cite their source.

## License

MIT — see [LICENSE](LICENSE).
