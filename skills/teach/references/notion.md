# The Notion lesson log

Every teaching session is mirrored to a Notion page. The conversation is disposable; the page is what survives, and it's what makes a lesson reviewable weeks later.

## Configuration

- **Parent page:** see `notion-config.md` in this directory for the stored parent page ID.
- **Server:** the hosted Notion MCP (`notion` in `claude mcp list`). If it reports *needs authentication*, tell the learner to run `/mcp` and authorize once.

If the parent page ID is missing or the page is gone, run `notion-search` for a page named "Learning" and use it; if there is none, create one at the workspace root and record its ID in `notion-config.md`.

## The contract

**Failure is never fatal.** If any Notion call fails, say so once in plain language, then continue teaching. A broken log must never block or slow a lesson. Do not retry more than once per checkpoint, and do not let logging chatter intrude on the teaching.

### Checkpoint 1 — create the page stub (before Phase 1a)

Create one child page under the parent, with `notion-create-pages`:

- **Title:** `<Topic> — <YYYY-MM-DD>`, e.g. `How TCP works — 2026-09-20`
- **Initial content:** exactly this, placeholders included —

```
## Goal

*Filled in after probing.*

## Starting point

*Filled in after probing.*

---
```

The page has to exist before Phase 1a because that's where math-bearing probe questions get asked (`notion-quiz.md`). Give the learner the link in one line when you create it, so they have the tab open before the first question lands.

### Checkpoint 1b — fill in the stub (after Phase 1b, before Phase 2)

Replace both placeholders with `notion-update-page`, `command: "update_content"`:

- `## Goal` — what they said they want, from Phase 1b, in their framing
- `## Starting point` — where their edge sits per Phase 1a: for each strand, what they have and where it runs out. Be concrete; "knows packets exist but not why ordering isn't free" is useful, "some familiarity" is not.

Replace rather than append: these belong at the top of the record, and by now the probe questions are sitting below them.

### Checkpoint 2 — the plan (when you present it, before they approve)

Append:

- `## Plan` — the prose approach, as presented
- The dependency-map ```mermaid block

This checkpoint comes *before* approval, not after, because the page is where they read the map — a terminal can't render mermaid, so writing it here is what presenting it means. Tell them it's up, then wait.

**If they correct it, edit in place** with `update_content` — replace the old mermaid block with the corrected one. The page should end up holding the map they approved, with no trace of the version they rejected. That's the same outcome the old "append only what they approved" rule was after; only the ordering changed.

### Checkpoint 3 — each node (as it lands)

After a node passes its quiz-check, append a `### <node name>` section containing the teaching text **verbatim as delivered** — the motivation, the establishment, the explicit dependency edge, any diagram.

**Verbatim means verbatim.** Do not summarize, tighten, or "clean up" the lesson on its way into the log. The phrasing that made it land is the artifact worth keeping; a compressed version is a set of notes about a lesson rather than the lesson. The one exception is stripping pure conversational filler ("great question", "let's move on").

Append per node as it lands, not in one dump at the end — a session that gets interrupted should still leave everything up to that point on the page.

### Checkpoint 4 — the quiz log (end of session)

Append a `## Quiz log` section: every graded question asked, their answer, and ✓ / ✗ / "didn't know". A compact table is ideal. This is the record of what was actually confirmed versus merely covered, and it is where a future session picks up.

**Log the terminal questions in full; log the Notion ones as one-line rows.** Questions asked on the page are already there, graded in place — restating them wholesale would duplicate half the document. Give each a row (`Q3 · chain rule · picked A · ✗`) so the table is still a complete index of what was tested, and let the question itself remain the detailed record. Terminal-asked questions exist nowhere else, so those rows carry the question and the options too.

## Formatting

Write Notion-flavored markdown. Three things to get right:

- **Math:** inline `` $`f(x)`$ `` — equation inside backticks, inside the dollars — and display `$$` on its own lines. Notion renders both as equations. Inside an equation, escape nothing.
- **Diagrams:** a fenced ```mermaid code block renders as a diagram in Notion.
- **Toggles:** `<details>` with a `<summary>` line and tab-indented children. Use them to collapse anything long that isn't the point — graded explanations, worked side-derivations — so the page stays skimmable and stays re-testable.

Everything else is ordinary markdown — headings, lists, bold, tables, code blocks.

## What not to log

Terminal-asked probe questions don't go on the page as they happen — they'd bury the lesson. Their *result* belongs in `## Starting point`, and the questions themselves in the end-of-session `## Quiz log`.

Math-bearing probe questions are the exception, because the page is the only place they can be asked at all. Keep them from taking over: put a `## Probe` heading before the first one, keep the stems tight, and collapse every grading into its toggle so the run reads as a short list of headings rather than a wall of worked answers. Once `## Plan` is appended below it, the probe section reads as preamble, which is what it is.
