# The Notion lesson log

Every teaching session is mirrored to a Notion page. The conversation is disposable; the page is what survives, and it's what makes a lesson reviewable weeks later.

## Configuration

- **Parent page:** see `notion-config.md` in this directory for the stored parent page ID.
- **Server:** the hosted Notion MCP (`notion` in `claude mcp list`). If it reports *needs authentication*, tell the learner to run `/mcp` and authorize once.

If the parent page ID is missing or the page is gone, run `notion-search` for a page named "Learning" and use it; if there is none, create one at the workspace root and record its ID in `notion-config.md`.

## The contract

**Failure is never fatal.** If any Notion call fails, say so once in plain language, then continue teaching. A broken log must never block or slow a lesson. Do not retry more than once per checkpoint, and do not let logging chatter intrude on the teaching.

### Checkpoint 1 — create the page (after Phase 1b, before Phase 2)

Create one child page under the parent, with `notion-create-pages`:

- **Title:** `<Topic> — <YYYY-MM-DD>`, e.g. `How TCP works — 2026-09-20`
- **Initial content:**
  - `## Goal` — what they said they want, from Phase 1b, in their framing
  - `## Starting point` — where their edge sits per Phase 1a: for each strand, what they have and where it runs out. Be concrete; "knows packets exist but not why ordering isn't free" is useful, "some familiarity" is not.

Create it *after* probing, not before — the starting point is half the value of the record and you don't have it until Phase 1a is done.

### Checkpoint 2 — the plan (after they approve it)

Append:

- `## Plan` — the prose approach, as presented
- The dependency-map ```mermaid block, verbatim

Append the version they **approved**, not the version you first proposed. If they corrected a root, the log records the corrected map.

### Checkpoint 3 — each node (as it lands)

After a node passes its quiz-check, append a `### <node name>` section containing the teaching text **verbatim as delivered** — the motivation, the establishment, the explicit dependency edge, any diagram.

**Verbatim means verbatim.** Do not summarize, tighten, or "clean up" the lesson on its way into the log. The phrasing that made it land is the artifact worth keeping; a compressed version is a set of notes about a lesson rather than the lesson. The one exception is stripping pure conversational filler ("great question", "let's move on").

Append per node as it lands, not in one dump at the end — a session that gets interrupted should still leave everything up to that point on the page.

### Checkpoint 4 — the quiz log (end of session)

Append a `## Quiz log` section: every graded question asked, their answer, and ✓ / ✗ / "didn't know". A compact table is ideal. This is the record of what was actually confirmed versus merely covered, and it is where a future session picks up.

## Formatting

Write Notion-flavored markdown. Two things to get right:

- **Math:** inline `$f(x)$`, display `$$` on its own lines. Notion renders both as equations.
- **Diagrams:** a fenced ```mermaid code block renders as a diagram in Notion.

Everything else is ordinary markdown — headings, lists, bold, tables, code blocks.

## What not to log

Do not write the probe questions from Phase 1a into the page as they happen — they'd bury the lesson. Their *result* belongs in `## Starting point`, and the questions themselves in the end-of-session `## Quiz log`.
