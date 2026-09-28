---
name: cv-builder
description: Builds PDF CVs from the user's career profile, in any profession — either a general CV for their main goal or one tailored to a specific job ad — and explains honestly how well the user matches a job. Use this whenever the user wants a CV or resume, wants to apply for a job, pastes a job description or job link, asks "am I a good fit for this role?", wants to improve CV wording, or wants LinkedIn text generated from their profile. Use it even if the user just says "make my CV" or "help me apply to this".
---

# CV Builder

Turns the profile into a finished PDF CV. The master `cv.yaml` is the source of truth. This skill **never edits it**. It works on copies.

## Before you start

1. Find the profile folder: `echo "${CAREER_PROFILE_DIR:-$HOME/career-profile}"`.
2. If `about.md` or `cv.yaml` is missing, or `cv.yaml` has no experience or education yet, use the `career-profile` skill to set it up first.
3. Read `cv.yaml`, `about.md`, and the main active goal in `goals/` (or the goal the job fits best).
4. Read `references/writing-guide.md` before writing or rewording any text. It also covers CV conventions by country and profession.

## The one rule that matters most

**Never invent anything.** No made-up jobs, titles, dates, numbers, skills, or results. You may reword, reorder, shorten, and choose what to show. If a job ad asks for something the user doesn't have, it goes in the gap list, not on the CV. Invented content can cost the user a job later, so this rule protects them.

If a highlight would be much stronger with a number and there isn't one, ask the user. Don't guess.

## Mode A — General CV

Use when there is no specific job.

1. Copy `cv.yaml` to `cvs/general/cv.yaml`.
2. Shape the copy around the main goal's target and market:
   - Rewrite the summary for that target (2–3 lines).
   - Keep the last 5–7 years detailed. Shorten older jobs to 1–2 highlights, or drop very old ones that add nothing.
   - Keep the 3–5 strongest highlights per recent job, favouring those that prove the goal's requirements.
   - Keep only the sections, projects, and certificates that support the target.
   - Trim skills to what is relevant and current.
   - Apply the conventions for the goal's country and profession (writing guide).
3. Render to `cvs/general/<Name>_CV.pdf` (see "Rendering").

## Mode B — Tailored CV for a job ad

Use when the user gives a job description, a link, or a file. If it's a link, fetch the page. If the page can't be read, ask the user to paste the text.

1. **Read the ad.** Pull out: job title, employer, must-haves, nice-to-haves, level, key responsibilities, and words or phrases that repeat.
2. **Match against the profile.** For each requirement, find evidence in `cv.yaml` and `skills.md`: strong match, partial match, or no match.
3. **Build the tailored copy** in `cvs/tailored/YYYY-MM-DD-<employer-slug>/cv.yaml`:
   - Rewrite the summary for this role, using only true facts.
   - Reorder highlights so the most relevant come first. Pick highlights that prove the must-haves.
   - Where the user's real experience matches, use the ad's own words for it (for example the ad says "stakeholder management" and the user ran monthly meetings with department heads → "stakeholder management with 6 department heads"). This helps with CV-scanning software, but only where it is true.
   - Reorder and trim the skills section so the ad's matching skills come first.
   - Include projects and certificates only if they support this role.
4. **Render** to `<Name>_CV_<Employer>.pdf` in the same folder.
5. **Write a match report** to `match-report.md` in the same folder and show it to the user:

```markdown
# Match report — <Job title> at <Employer>
Date: YYYY-MM-DD · Source: <link or "pasted text">

## Overall fit
Strong / Good / Stretch / Weak — one or two sentences why.

## Strong matches
- <requirement> → <evidence from profile>

## Partial matches
- <requirement> → <what the user has, and what's missing>

## Gaps
- <requirement> → honest suggestion (mention adjacent experience in the cover letter, learn it, or accept the gap)

## Pay check
Compare with the goal's pay target and market-notes.md if there's data. Say clearly if there isn't.

## Suggested next steps
2–4 concrete actions.
```

If the same gaps keep showing up across several match reports, suggest a gap analysis and growth plan for that goal: those gaps are what the market is asking for.

## Length and layout

- Target 1 page for under ~7 years of experience, 2 pages maximum otherwise, unless the writing guide says the profession or country expects more (for example academic CVs). The render script prints the page count. If it's over, cut the weakest highlights and older content, then render again.
- Keep the simple single-column RenderCV themes (`classic` by default). CV-scanning software reads them well. Don't add a photo or a multi-column layout unless the user asks or the country convention expects a photo, and explain the trade-off.
- Other built-in themes: `sb2nov`, `engineeringresumes`, `engineeringclassic`, `harvard`, `moderncv`, `ember`, `ink`, `opal`. Change `design: theme:` in the copy only.
- For a CV in another language, set `locale: language:` in the copy (see `../career-profile/references/cv-yaml-format.md`) and translate the text. Ask the user to review the translation.

## Rendering

Use the script in this skill's folder:

```bash
bash "<this skill's folder>/scripts/render_cv.sh" <input.yaml> <output.pdf>
```

- Exit code 2 means RenderCV is not installed. Tell the user in one line that it's needed to make PDFs and offer to install it (`pip install "rendercv[full]"`). Install it only after they say yes.
- A YAML error usually means bad indentation, a date not in `YYYY-MM` format, or text with `: ` that needs quotes. Fix it and try again.
- The first run needs internet, because RenderCV downloads its font packages once.

## LinkedIn text

If the user asks for LinkedIn content, generate it from `cv.yaml`, `skills.md`, and the main goal, and save it to `reports/linkedin-text.md`:

- **Headline** (max ~220 characters): role + main strengths + what they're aiming for. Give 3 options.
- **About**: first person, 3 short paragraphs, plain language, ending with what they're open to.
- **Experience** entries: 2–4 highlight lines per role, the same facts as the CV.

The user pastes it into LinkedIn themselves.

## Finish

Tell the user where the PDF is, the page count, and (for tailored CVs) the overall fit and the top gap. Keep it short.
