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

## Install (3 minutes)

**Quick version** — open `~/.claude/settings.json` and add these two entries (merge with anything already there):

```json
{
  "enabledPlugins": {
    "agent-gian@agent-gian": true
  },
  "extraKnownMarketplaces": {
    "agent-gian": {
      "source": {
        "source": "github",
        "repo": "giansausa/agent-gian"
      }
    }
  }
}
```

Then **restart Claude Code** and run:

```
/agent-gian setup
```

Answer the 3 consent prompts (methodology block = yes, pre-commit tsc hook = yes if you use TypeScript, auto-push = no unless you know what you're opting into).

**Verify:** run `/agent-gian` — you should see the status dashboard.

📖 **Full walkthrough + troubleshooting → [INSTALL.md](INSTALL.md)**

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
