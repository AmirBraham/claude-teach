# claude-teach

A **Claude Code** port of a teaching system I found in the video
**[How I Use AI to Learn Things](https://www.youtube.com/watch?v=kzcI5F4tGiU&t=867s)**
by [Eero Alvar](https://www.youtube.com/@EeroAlvar).

The original is a [**pi**](https://github.com/earendil-works/pi) config published at
[`amosblomqvist/learn`](https://github.com/amosblomqvist/learn). This repo re-implements
the same pedagogy as Claude Code skills, with the lesson log going to **Notion** instead
of Obsidian.

I did not invent the teaching method. See [Attribution](#attribution).

---

## What it does

`/teach <topic>` runs a structured lesson built on two principles:

1. **Unconditional truths first** — start from facts the learner can accept at face
   value, with no caveats, and build everything explicitly on top of them. Not because
   bottom-up is logically tidy, but because caveat-free facts are the *easiest* thing
   for a brain to commit to.
2. **"How could I have discovered this?"** — never assert a fact that feels decreed.
   Walk the motivated path that someone could have followed to reach it themselves
   (the 3Blue1Brown move).

The goal is a **dependency graph in the learner's head** — principle 1 supplies the
nodes, principle 2 supplies the edges. Memorized facts rot; facts held in place by
their connections don't.

### The session shape

| Phase | What happens |
|---|---|
| **1a. Probe** | Graded questions until the *edge* of the learner's knowledge is bracketed — something they get right (floor) **and** something they miss (ceiling). All-correct means the questions were too easy, not that probing is done. |
| **1b. Goal** | One open question: what do they actually want out of this? |
| **2. Plan** | The approach in prose, plus a mermaid DAG with unconditional truths at the roots and the goal as the sink. Roots get stress-tested, then the learner approves before any teaching starts. |
| **3. Teach** | Per node: motivate → establish → connect → quiz-check. A node that fails its check gets fixed before anything is built on it. |

Everything is mirrored to Notion at four checkpoints, so an interrupted session still
leaves a usable record.

## Contents

```
skills/teach/SKILL.md                      the two principles + the 3-phase process
skills/teach/references/quiz.md            how to write graded questions that don't leak their answer
skills/teach/references/notion-quiz.md     asking + grading math questions in Notion, where LaTeX renders
skills/teach/references/dependency-map.md  how to draw a Phase 2 map that's actually readable
skills/teach/references/notion.md          the lesson-log contract (5 checkpoints)
skills/teach/references/notion-config.md   where lessons get logged (set up on first run)
skills/visualize/SKILL.md                  one minimal mermaid diagram, when a picture earns its place
agents/researcher.md                       fact-verification subagent
```

The most transferable file is probably [`quiz.md`](skills/teach/references/quiz.md).
`AskUserQuestion` was built for decisions, not quizzes, and multiple-choice options
written casually leak their own answer — the correct one ends up longest and most
qualified. It documents a *construction* procedure (write the correct claim, then
mutate it into each distractor) so evenness falls out by design rather than by audit.

## Install

```bash
git clone https://github.com/AmirBraham/claude-teach
cd claude-teach
./install.sh
```

This copies into `~/.claude/skills/` and `~/.claude/agents/`. It will not overwrite
existing files without asking.

### Notion setup

The lesson log needs the hosted Notion MCP server:

```bash
claude mcp add --transport http --scope user notion https://mcp.notion.com/mcp
```

Then run `/mcp` inside Claude Code and authorize. On the first `/teach`, the skill
searches for a page named "Learning", offers to create one if there isn't one, and
records the ID in `notion-config.md` so it never asks again.

Notion is optional in practice — if it's unreachable, the skill says so once and
teaches anyway. A broken log must never block a lesson.

## Attribution

The pedagogy, the session structure, and most of the design judgement here are **not
mine**. They come from the video and repo linked above. What I wrote is the port: the
Claude Code skill format, the Notion logging contract, and the `AskUserQuestion`
workarounds that replace pi's custom tooling.

> [!IMPORTANT]
> `amosblomqvist/learn` carries **no license file**, which under default copyright
> means all rights reserved. This port is published in good faith as a
> credit-forward reimplementation, not as a claim of ownership, and it deliberately
> ships no license of its own. **If you are the original author and would like this
> repo changed, relicensed, or taken down, open an issue and I'll act on it.**

### Deliberate differences from the original

These are not bugs — they're the zero-dependency path, taken on purpose:

| Original (pi) | Here (Claude Code) |
|---|---|
| Custom `quiz` tool with inline ✓/✗ grading | `AskUserQuestion` + grading in the next message |
| Renders diagrams and visually verifies them | Mermaid written straight into Notion, unverified |
| `svg-maker` agent for geometric visuals | Dropped — so no number lines, vectors, or plots |
| `md-log` mirroring to Obsidian | Checkpoint-based writes to Notion |

The two dropped capabilities are the real losses. Mermaid is nodes-and-edges and has
no coordinate system, so anything genuinely spatial has to fall back to prose.
`visualize` states this limit explicitly rather than producing a mangled diagram.
