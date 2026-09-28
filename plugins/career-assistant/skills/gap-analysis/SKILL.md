---
name: gap-analysis
description: Compares the user's skills, experience, and proof with what the market currently wants for one of their goals, in any profession, and shows where they stand — their strengths and edge, the gaps, and which gaps matter most. Use this whenever the user asks "where do I stand?", "how far am I from <role>?", "what am I missing?", "am I competitive?", "what's holding me back?", "what should I improve?", or after a goal is added or changed. The growth-plan skill uses its results.
---

# Gap Analysis

Shows the user honestly where they stand against the market for one goal, and which gaps matter most. The aim is not a score. It is a short list of the things that would make the biggest difference to how much the market wants this person.

## Before you start

1. Find the profile folder: `echo "${CAREER_PROFILE_DIR:-$HOME/career-profile}"`. If there is no profile, use the `career-profile` skill first.
2. Pick the goal. If the user didn't say and there are several active goals, use the main one and say which one you used.
3. Read the goal file, `about.md`, `skills.md`, and `cv.yaml`. If there is a recent `reports/presence-audit-*.md`, read it too.
4. Find the latest demand profile for this goal: `reports/market-<goal-slug>-*.md`. If there is none, or it is older than ~60 days, or the goal's target or market changed after it was written, use the `market-research` skill first. Never compare against remembered or assumed market needs.
5. Read the previous gap report for this goal, if any (`reports/gap-<goal-slug>-*.md`), so you can show progress.

## Compare

Go through each requirement in the demand profile and match it to the user's evidence in `skills.md` and `cv.yaml`. Put each one in exactly one group:

| Group | Meaning |
|---|---|
| **Strength** | At or above the level the market expects, with proof that is Shown or Verified. |
| **Proof gap** | The user has the skill at the right level, but can't prove it (proof is None or Claimed). Usually the cheapest gap to close. |
| **Level gap** | The user has it, but below the level the market expects. |
| **Missing** | The user doesn't have it. |

Then look for the user's **edge**: things they have that are valued but less common among people aiming for the same target. Examples: a rare combination of skills, domain knowledge from an earlier career, an extra language, a result much better than typical. The edge is what makes someone stand out, not just qualify. Name it, so the user can lean into it.

For experience requirements ("5+ years"), calculate the user's years from the dates in `cv.yaml` and today's date. Don't copy a number written elsewhere in the profile; if it disagrees, fix it.

If the user's level for an important requirement is unclear, ask 1–2 quick questions ("Have you done this on your own, without help?", "Could you show someone an example?") rather than guess. Update `skills.md` with what you learn.

## Prioritize

Rank the gaps. The most important ones score well on all three:

- **Impact:** must-have beats rising beats nice-to-have; the more often it appears in the ads, the higher.
- **Effort:** proof gaps are fastest, then level gaps, then missing skills. Skills close to what the user already knows are faster to learn well.
- **Fit:** the user wants to move in that direction and it fits their constraints in `about.md`.

Pick the **top 3–5 gaps**. More than that is a list, not a priority.

## Readiness

Give a plain, honest picture without fake precision. Count, don't score:

- Must-haves: how many are covered with proof, how many without proof, and how many are missing, for example "7 of 10 must-haves: 5 proven, 2 not provable yet, 3 missing".
- Then one sentence: how competitive that makes the user today (for example "You'd get interviews at some employers, but the missing license rules out most of them").

## Save

1. Write the full report to `reports/gap-<goal-slug>-YYYY-MM-DD.md`:

```markdown
# Where I stand — <goal target>
Date: YYYY-MM-DD · Goal: goals/<goal-slug>.md · Market data: reports/market-<goal-slug>-<date>.md

## In short
2–3 honest sentences.

## Readiness
Must-haves: X of Y covered (A proven, B not provable yet), Z missing.
Compared with the last analysis (<date>): what moved.

## My edge
- ...

## Strengths
| Requirement | Evidence |
|---|---|

## Gaps
| Requirement | Must/Nice/Rising | Kind of gap | Now → needed | Priority |
|---|---|---|---|---|
| ... | Must | Proof gap / Level gap / Missing | Level 3, Claimed → Level 3, Shown | 1 |

## Top priorities
1. <gap> — why it matters most, and a rough idea of the fastest way to close it.
2. ...
```

2. Replace the **Where I stand** section of the goal file with the date, a link to the report, the readiness line, the edge, and the top gaps (5–8 lines in total).
3. Add a line to the goal's progress log: `YYYY-MM-DD — Gap analysis: <readiness line>`.
4. Update `skills.md` with any levels or proof you learned about during the analysis.

## Answer the user

Keep it short and encouraging but honest:

1. Where they stand, in 2–3 sentences, including what improved since last time.
2. Their edge.
3. The top 3 gaps, and why each matters.
4. Next step: offer to turn these into a growth plan (the `growth-plan` skill).
