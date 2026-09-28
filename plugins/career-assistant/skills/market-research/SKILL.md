---
name: market-research
description: Researches what the job market currently wants and pays for the user's goal in any profession — which skills, certificates, and experience employers ask for, what separates the next level or the top earners, which skills are rising, and pay ranges — using live web search, and saves dated findings. Use this whenever the user asks what employers look for, which skills are in demand, what they could earn, whether a skill or certificate is worth getting, how the market looks for a role or location, or asks for a market report. The gap-analysis and growth-plan skills use it to refresh stale market data.
---

# Market Research

Answers "what does the market want right now for where I want to go, and what does it pay?" for the user's specific goal. Markets change quickly, so **always search live**. Never rely on what you already believe about which skills are wanted or what salaries are.

## Before you start

1. Find the profile folder: `echo "${CAREER_PROFILE_DIR:-$HOME/career-profile}"`.
2. Read `about.md`, `skills.md`, and the relevant goal in `goals/`. If the user didn't say which goal and there are several active ones, use the main one, and say which one you used.
3. Read `market-notes.md` and any `reports/market-*` for this goal. If there is research under ~60 days old on the same question, start from it and only search for what is missing or changed.

If there is no profile, you can still answer a general market question, but suggest setting up the profile for personal advice.

## Decide the questions

Turn the request into 1–3 concrete questions. Examples:

- "Which skills and certificates do hospitals in Athens ask for in senior ICU nurse ads right now?"
- "What separates a senior accountant from an accountant in UK job ads and career frameworks?"
- "What does a mid-level UX designer earn in Berlin vs remote for a US company?"
- "Is demand for Power BI growing in finance analyst roles?"

If the request is broad ("check the market"), use the goal's target and market.

## Research

Read `references/sources.md` for where to look and how much to trust each source.

- **Requirements:** sample **10–20 real, recent job ads** for the target role and market. Record for each requirement whether it is a must-have or a nice-to-have. This is more reliable than trend articles.
- **Stay in the user's market.** Count only ads the user could actually get: the right location, and for remote roles, open to where the user lives (no "US only" or "must live in Germany" when they don't). Mention how many ads you excluded and why.
- **Next level:** if the goal is growth in the current role or a promotion, also look at what separates levels: job ads for the next level, published career frameworks and competency frameworks for the profession, and professional body requirements.
- **Rising skills:** note requirements that appear in newer ads but not older ones, or that sources say are growing. Mark these as interpretation unless the data clearly shows it.
- **Pay:** collect ranges from at least 2–3 sources. Note gross or net, per year or per month, currency, level, and location. Pay data online is noisy; say so.
- Note the date of every source. Ignore, or clearly mark, anything older than about a year.
- Keep every link you use.

Requirements are more than skills. Record them by type: **skill**, **tool**, **certificate or license**, **experience** (for example "3+ years managing a team"), **education**, **language**, and **trait** (for example "comfortable presenting to clients").

## Be honest about the data

- Separate **what the data shows** from **your interpretation**.
- Say how confident you are and why ("based on 14 ads from LinkedIn and Indeed, and one national salary survey").
- If sources disagree, show the range rather than picking one number.
- "I couldn't find solid data for this" is a valid answer. Never present a guess as a fact.

## Save findings

**1. Demand profile.** For goal-level research, write `reports/market-<goal-slug>-YYYY-MM-DD.md`. The `gap-analysis` skill reads its table, so keep the format:

```markdown
# Market report — <target> · <market>
Date: YYYY-MM-DD · Goal: goals/<goal-slug>.md · Based on: <N ads, other sources>

## Summary
3–5 sentences.

## Demand profile
| Requirement | Type | Must / Nice / Rising | Seen in | Level expected | User has it? |
|---|---|---|---|---|---|
| ... | skill / tool / certificate / experience / education / language / trait | Must | 12 of 15 ads | ... | Yes / Partly / No / Unknown |

## What separates the next level (if relevant)
- ...

## Pay
| Source | Role / level | Location | Range | Gross/net, period | Date |
|---|---|---|---|---|---|

## What changed since the last report
Compare with earlier entries for this goal. "First report" if there are none.

## Sources
- <links>
```

**2. Market notes.** Always add a short entry at the **top** of `market-notes.md` (under the header):

```markdown
## YYYY-MM-DD — <topic>
- <finding> (source: <link>)
**Takeaway:** what this means for the user, in 1–2 sentences.
```

Link to sources rather than copying text from them.

## Answer the user

Short and plain first, then details:

1. The direct answer to their question.
2. How it compares with their skills and pay target (from the profile).
3. 1–3 practical suggestions. For goal-level research, the natural next step is usually a gap analysis.
4. Sources.

## Report mode

When asked for a "market report" or "update", or when running without the user present (for example from a scheduled task), do not ask questions. Use the active goals as the brief, write one demand profile per active goal, and add the usual `market-notes.md` entry.
