---
name: presence-audit
description: Reviews the user's public professional presence — LinkedIn, portfolio or personal website, and the platforms that matter in their field (for example GitHub, Behance, Google Scholar, professional registers) — from the point of view of someone hiring for the user's goal, and gives a prioritized list of fixes. Works for any profession. Use this whenever the user asks to review or improve their LinkedIn, portfolio, website, GitHub, or online presence, asks "what do employers see when they look me up?", or wants their skills to be visible to the market.
---

# Presence Audit

Being good is half of being in demand. The other half is that the right people can **find** the user and **believe** they're good. Look at the user's public presence the way a busy recruiter, hiring manager, or client would: someone who spends 1–2 minutes and asks "Can this person do what I need?"

## Before you start

1. Find the profile folder: `echo "${CAREER_PROFILE_DIR:-$HOME/career-profile}"`. If there is no profile, use the `career-profile` skill first.
2. Read `about.md` (links, profession), the main active goal (or the one the user named), `skills.md`, and `cv.yaml`.
3. Read the latest gap analysis for that goal, if there is one. The audit should check whether the user's **strengths and edge** are visible, and whether any **proof gaps** can be closed just by showing existing work.
4. Decide which channels matter for this profession and goal. Read `references/channels.md`. If a link for an important channel is missing from `about.md`, ask for it.

Use only public information. Never change anything on the user's accounts or website.

## Collect the data

- **Websites and portfolios:** fetch and read them.
- **LinkedIn:** public profile pages are often blocked. If you can't read it, use the LinkedIn export in `imports/linkedin/` if there is one. Otherwise ask the user to copy and paste their profile text into the chat, or to use "Save to PDF" on their profile and give you the file. Copy any file into `imports/` yourself.
- **GitHub** (only when it matters for the goal):
  - If the GitHub CLI is installed and logged in, run the script in this skill's folder: `bash "<this skill's folder>/scripts/github_summary.sh" <username>`.
  - Otherwise read the public API directly, which needs no login: `https://api.github.com/users/<username>` and `https://api.github.com/users/<username>/repos?per_page=100&sort=pushed`.
  - Read the README of the 3–5 most important repos in full.
- **Other platforms** (Behance, Google Scholar, ORCID, professional registers, and so on): read the public page.
- **Search the user's name** plus their profession and city, and note what comes up on the first page.

## What to judge

**Findable**
- Does a search for the user's name + profession find their professional presence?
- Do their profiles use the words employers search for in this field (the job titles and skills from the market report)?

**Clear in 5 seconds**
- Headline or bio: does it say what they do and what they're aiming for?
- Photo, location, contact details, and links filled in (where normal in this field)?

**Proof visible**
- Are the user's strengths and edge from the gap analysis clearly visible, with results, not just claims?
- Do the key requirements of the goal show up anywhere public: work samples, case studies, certificates, recommendations, publications?
- Could any **proof gap** be closed simply by publishing something the user already has?

**Consistent**
- Do titles, dates, and skills match `cv.yaml`? Mismatches cost trust.
- Is there anything outdated, unfinished, or unprofessional that should be updated, archived, or made private? (Suggest; never delete anything yourself.)

**Channel-specific** checks are in `references/channels.md`.

Activity counts (posts, followers, GitHub contributions) matter much less than a few clear, good pieces of proof. Say so if the user worries about it.

## Report

Save to `reports/presence-audit-YYYY-MM-DD.md` and show the user a short version:

```markdown
# Presence audit — YYYY-MM-DD
Goal: goals/<goal-slug>.md

## The 30-second impression
What someone hiring for <target> would likely think, in 2–3 honest sentences.

## Top fixes (in order of impact)
1. <fix> — why it matters — rough effort (10 min / 1 hour / a weekend)
2. ...
(5–8 items at most)

## Channel by channel
| Channel | Keep / Improve / Create / Retire | What to do |
|---|---|---|

## Proof you already have but don't show
- ...

## Mismatches with the CV
- ...
```

Put quick wins (under an hour) first when their impact is similar. Add a line to the goal's progress log: `YYYY-MM-DD — Presence audit: <one-line impression>`.

## Offer to help with the fixes

After the report, offer to draft things for the user to review and publish themselves:

- LinkedIn headline (3 options), About section, and experience entries, from `cv.yaml` and the goal.
- A portfolio case study or an article from a real result in the profile.
- A request for a recommendation, addressed to a specific person.
- A GitHub profile README or project README.
- For website changes, if the site's code is in a local folder, offer to make the edits there.

Never post, publish, or send anything for the user.
