# Career Assistant for Claude Code

A Claude Code plugin that works as your personal career coach, in any profession.

It helps you become someone the market wants. It learns where you stand, finds out what employers want right now for where you want to go, and helps you close the gap step by step. When you're good, and people can see it, the job follows.

You never fill in forms or edit files. You just talk to Claude.

## How it works

```
   you talk ──► profile & goals
                     │
                     ▼
            ┌─► market research ── what does the market want and pay?
            │        │
            │        ▼
            │   gap analysis ───── where do I stand? what matters most?
            │        │
            │        ▼
            │   growth plan ────── what do I learn, and how do I prove it?
            │        │
            └── check-ins ──────── progress updates your profile and plan
```

Alongside the loop:
- **Presence audit**: makes sure the right people can find you and see your proof.
- **CV builder**: turns your profile into a general or tailored PDF CV, with an honest match report.

## Skills and commands

Claude picks the right skill automatically when you talk about your career. You can also use the commands.

| Skill | What it does | Command |
|---|---|---|
| `career-profile` | Setup conversation, updates, and your goals | `/career-setup`, `/career-update`, `/career-goal` |
| `market-research` | Live research: requirements, rising skills, pay | `/market-check` |
| `gap-analysis` | Where you stand for a goal: strengths, edge, top gaps | `/gap-check` |
| `growth-plan` | A plan to close the top gaps, and progress check-ins | `/grow` |
| `presence-audit` | LinkedIn, portfolio, and field-specific platforms | `/presence-audit` |
| `cv-builder` | General or tailored PDF CV, match report, LinkedIn text | `/cv` |

If a command name clashes with another plugin, use the full name, for example `/career-assistant:grow`.

## Install

In Claude Code:

```
/plugin marketplace add Thodoris-Rizoulis/career-assistant
/plugin install career-assistant@career-tools
```

To try it from a local copy instead:

```
/plugin marketplace add ./path/to/career-assistant
/plugin install career-assistant@career-tools
```

Optional tools. Claude checks for these and offers to install them when they're needed:
- [RenderCV](https://docs.rendercv.com), for PDF CVs (needs Python).
- [GitHub CLI](https://cli.github.com), for a deeper GitHub review. Without it, Claude reads public GitHub data directly.

## First run

Run `/career-setup` and talk. Claude will ask who you are, where you want to go, and what you've done. Share an old CV or your LinkedIn export if you have them; just give Claude the file.

Then:

```
/gap-check               → where you stand for your main goal
/grow                    → a plan to close the most important gaps
/career-update <news>    → "finished the course", "got the promotion", "cut costs by 15%"
/grow check-in           → progress on your plan
/career-goal <goal>      → add or change a goal any time
/market-check <question> → "is a PMP worth it for me?"
/presence-audit          → what employers see when they look you up
/cv <job ad>             → tailored CV + match report
```

## Your profile folder

Everything about you lives in a private folder on your computer: `~/career-profile/` by default. Set the `CAREER_PROFILE_DIR` environment variable to use a different location.

```
~/career-profile/
├── CLAUDE.md          # tells Claude what this folder is
├── about.md           # who you are, your situation and constraints
├── cv.yaml            # every career fact (RenderCV format), the single source of truth
├── skills.md          # your skills, levels, and proof
├── goals/             # one file per goal, with its growth plan and progress log
├── market-notes.md    # dated market findings
├── imports/           # your old CV, LinkedIn export
├── cvs/               # generated CVs
└── reports/           # market reports, gap analyses, presence audits
```

The plugin itself holds only instructions and scripts, never personal data. Keep the profile folder out of public repositories. Claude offers to make it a private Git repository, so you get a history of every change.

## Principles

- **Better, not just better-looking.** The main job is growing real, provable skills that the market wants. CVs come second.
- **Proof, not claims.** Every skill has a level and a proof strength. Closing a proof gap is often the fastest win.
- **Live market data.** Market advice always comes from current searches, with dates and sources.
- **Never invent anything.** CVs and profiles contain only facts you gave or documents show.
- **Honest feedback.** Gap analyses and audits say what's weak, not just what's good.
- **No chores.** You talk; Claude does the file work.

## Project structure

```
.claude-plugin/marketplace.json          # marketplace listing
plugins/career-assistant/
├── .claude-plugin/plugin.json           # plugin manifest
├── commands/                            # slash commands
└── skills/
    ├── career-profile/   (SKILL.md, references/, templates/)
    ├── market-research/  (SKILL.md, references/sources.md)
    ├── gap-analysis/     (SKILL.md)
    ├── growth-plan/      (SKILL.md, references/ways-to-close-gaps.md)
    ├── presence-audit/   (SKILL.md, references/channels.md, scripts/github_summary.sh)
    └── cv-builder/       (SKILL.md, references/writing-guide.md, scripts/render_cv.sh)
evals/evals.json                         # test prompts for improving the skills
```

## Improving the skills

`evals/evals.json` has realistic test prompts from different professions. Anthropic's `skill-creator` skill can run them, compare results, and help tune the skill descriptions so Claude picks the right skill at the right time.

## License

MIT
