---
name: growth-plan
description: Turns the user's most important skill gaps into a concrete, realistic growth plan — what to learn, how to prove it, with which resources, by when — and runs progress check-ins that update the plan and the profile. Works for any profession. Use this whenever the user asks "how do I get better?", "what should I learn next?", "how do I close this gap?", "what should I do to get promoted?", "how do I become more valuable?", wants a learning or development plan, asks which course or certificate to take, wants a project idea to prove a skill, or reports progress on their plan ("I finished the course", "how am I doing?", "check-in").
---

# Growth Plan

A good growth plan does two things for each gap: **builds the skill** and **creates proof** that others can see. A skill nobody can see doesn't make the user more valuable to the market. Proof without the skill doesn't last.

The plan must fit the user's real life: their hours, their budget, and how they like to learn. A small plan that gets done beats a big one that doesn't.

## Before you start

1. Find the profile folder: `echo "${CAREER_PROFILE_DIR:-$HOME/career-profile}"`. If there is no profile, use the `career-profile` skill first.
2. Pick the goal. If the user didn't say and there are several active goals, use the main one and say which.
3. Read the goal file (including its current plan and progress log), `about.md` (the constraints: hours per week, budget, learning style, things they won't do), and `skills.md`.
4. Read the latest `reports/gap-<goal-slug>-*.md`. If there is none, or it is older than ~90 days, use the `gap-analysis` skill first.

Then decide: is this a **new plan**, or a **check-in** on an existing one?

## New plan

### 1. Choose the focus

Pick **2–3 gaps** from the top priorities of the gap analysis. Not more: focus is what makes progress visible.

- Always start with any **proof gaps** in the top priorities. They are quick wins: the skill is already there, only the proof is missing.
- Then the highest-priority level gaps and missing skills that fit the user's time and budget.

### 2. For each focus gap, choose how to close it and how to prove it

Read `references/ways-to-close-gaps.md`. For each gap, pick:

- **Learn:** the way to build the skill that fits the user's learning style and constraints.
- **Prove:** the evidence that will exist at the end. It must be something a stranger could check, and the stronger the better (Verified > Shown). Prefer the kind of proof the market asks for: if job ads name a certificate, the certificate is the proof.

Prefer ways that do both at once. The best of these is usually **inside the user's current job**: a stretch task, a new responsibility, or an improvement project with a measurable result. It builds the skill, creates a result for the CV, costs nothing, and often gets noticed by the people who decide on promotions.

### 3. Find real resources

When the plan names a course, certificate, book, program, event, or community, **search live** and check that it exists now. Give the link, the price, the duration or effort, and the date you checked. Prefer well-known, reputable providers, professional bodies, and free options when they're good. Never invent a course name, price, or provider.

### 4. Make it concrete

For each focus gap:

- **Actions:** 3–6 steps, each small enough to start this week.
- **Time and cost:** estimated hours, and money if any.
- **Milestones:** dated, based on the user's hours per week. Be realistic: people have weeks off.
- **Done when:** the proof exists (the certificate is passed, the result is measured and written down, the portfolio piece is published).
- **CV line to aim for:** a draft highlight for when it's done. It goes into the profile only after it really happens, with real numbers.

Then lay out the first 30 days week by week, and the rest as monthly milestones.

**Check that it fits.** Split every action into **at work** (done as part of the job) or **own time**. Add up the own-time hours per week: they must fit the user's hours in `about.md`, with some slack. If they don't, cut or move things; don't just hope. Make sure the dates in the focus sections and the 30-day schedule agree.

### 5. Save and show

Replace the **Growth plan** section of the goal file:

```markdown
## Growth plan
_Made YYYY-MM-DD · based on reports/gap-<goal-slug>-<date>.md · <hours>/week, budget <amount>_

### Focus 1 — <gap> (<proof gap / level gap / missing>)
- **Learn:** ...
- **Prove:** ...
- **Resources:** [name](link) — price, duration (checked YYYY-MM-DD)
- **Actions:**
  - [ ] ...
- **Milestones:** YYYY-MM-DD ..., YYYY-MM-DD ...
- **Done when:** ...
- **CV line to aim for:** ...

### Focus 2 — ...

### First 30 days
- Week 1: ...
- Week 2: ...

### Next, after these
<the next 1–2 gaps from the gap analysis, to pick up when a focus is done>
```

If there was a previous plan, add a line to the progress log (`YYYY-MM-DD — New plan; previous plan: <what was done, what was dropped>`).

Show the user a short version: the focus gaps, why these, what to do this week, and when the first milestone is. Tell them to come back with `/grow check-in` (or just tell you what happened) whenever they make progress. Don't offer automatic reminders unless this session has a scheduling tool and the user asks for them.

## Check-in

When the user reports progress or asks how they're doing:

1. If they haven't said what happened, ask one open question: "What have you done since <last log date>?"
2. Tick off finished actions and milestones in the plan.
3. Add dated lines to the progress log.
4. Update the profile the way the `career-profile` skill describes: a new certificate or result goes into `cv.yaml`, a new level or proof into `skills.md`. Ask for the real number behind a result if it's missing.
5. **Behind schedule?** No guilt. Find out what got in the way, then make the plan fit reality: smaller steps, a later date, or a different way to learn. Update the plan and log the change.
6. **A focus gap is closed** (the proof exists)? Celebrate it, then move the next gap from "Next, after these" into focus.
7. Show progress in market terms, using the gap analysis: for example "Proven must-haves: 5 → 6 of 10". Suggest a fresh gap analysis every ~3 months, or when several focus gaps are closed.

## Honesty rules

- Never add a skill, level, certificate, or result to the profile before it has really happened.
- Don't promise outcomes ("this certificate will get you promoted"). Say what the market data shows ("8 of 12 ads for the next level ask for it").
- If a gap can't realistically be closed within the user's constraints (for example a 3-year degree requirement with 2 hours a week), say so clearly and suggest options: a longer timeline, a different target, or leaning on the user's edge instead.
