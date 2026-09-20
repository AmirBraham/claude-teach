---
name: visualize
description: Add one correct, minimal mermaid diagram to a lesson when an idea is genuinely clearer as a picture — a dependency graph, system/flow, sequence, state machine, tree, or comparison. Used by the teach skill; written to the Notion lesson page, where mermaid renders.
---

# Visualize

A picture earns its place only when it shows something words can't — shape, structure, direction, relationship. This skill produces ONE such picture as a mermaid diagram, written to the Notion lesson page.

You are the **creative director and the author**. You decide the exact idea, distil it to its fewest carrying elements, and write the mermaid yourself.

## When to visualize (and when not to)

This teaching system builds a **dependency graph in the learner's head** — unconditional truths at the root, derived facts hanging off them. A visual is powerful exactly when it makes that structure visible. Reach for one when the idea is a **structure or relationship**: dependencies, a system with parts and arrows, a flow/pipeline, a sequence of exchanges, a state machine, a tree/hierarchy, a comparison, a containment.

Do NOT visualize when prose or a single equation already carries it. A decorative diagram that just restates the sentence next to it adds noise and a chance to be wrong. **When in doubt, don't — a missing visual is cheaper than a false one.**

### What this skill cannot do

Mermaid is nodes-and-edges. It has no exact coordinates, so it cannot draw **spatial or geometric** things: coordinate geometry, number lines, vectors, function plots, physical layouts. If the idea needs precise positions, do not force it into mermaid — a mangled geometric diagram is worse than none. Describe it in prose instead, or work through the geometry step by step in LaTeX.

## One idea, fewest elements

The most common failure is **cramming** — every extra label makes the picture harder to read AND more likely to lay out badly. Before writing, prune to the fewest elements that carry the idea, and for each ask: *"if I delete this, is the idea still clear?"* If yes, delete it.

If you're about to draw more than ~7 nodes, stop and simplify. A diagram of 4 nodes that each pull weight beats one of 12 that fight for space.

(The Phase 2 **dependency map** is the exception and is not drawn by this skill — it's as large as the lesson is long, and has its own construction procedure in `teach/references/dependency-map.md`.)

**Width is the budget, not height.** Notion renders into a fixed-width column: the page scrolls vertically, so height is free, but anything wider than the column is scaled down until the text shrinks with it. The widest rank sets the font size for the whole diagram — so one long label makes *every* node harder to read, not just its own.

- BAD brief to yourself: "a diagram about how TCP works"
- GOOD: "`graph TD`: node 'packet' at top; arrows down to 'ordering' and 'retransmit on loss'; both down into 'reliable stream'. Shows that reliability is built FROM packets, not alongside them."

## Correctness — the part you own

Nothing renders this diagram back to you before the learner sees it. There is no verification loop to catch you. So the check has to happen while you write, deliberately:

- **Is every arrow pointing the right way?** Direction *is* the claim in a dependency graph. A reversed arrow asserts the opposite of what you mean and will be read as truth.
- **Is every edge actually true?** If you're unsure whether a dependency really holds, omit it. An absent edge is a gap; a wrong edge is a lie the learner will build on.
- **Are the labels right and unambiguous?** Short — a term or brief phrase, never a sentence. Long labels wreck layout. Hard ceiling ~28 characters. If a label contains `→`, `:`, or "so"/"then"/"because", it's two nodes wearing one box — split it, and put the connective **on the edge**: `sample -->|loss happens| retransmit`. An edge label is where a "why" belongs anyway.
- **Does it say only what you mean?** Don't invent content to fill space. Draw the smaller true thing.

Read the finished source back once, edge by edge, and say what each one claims out loud. That pass catches reversed arrows better than staring at the whole.

## Diagram types

- `graph TD` / `graph LR` — dependency graphs, flows. **`graph TD` with foundations at the top flowing down to conclusions is the natural shape for this pedagogy** and should be your default.
- `sequenceDiagram` — exchanges over time between parties
- `stateDiagram-v2` — states and transitions
- `erDiagram`, `classDiagram` — entities and their relations
- `mindmap`, `timeline` — loose hierarchies, chronology

## Emitting it

Write the diagram as a fenced ```mermaid block **into the Notion lesson page** (see `teach/references/notion.md`), where Notion renders it as a diagram. Introduce it in a sentence there, then let it carry the idea — don't narrate every element back in prose afterwards.

**Never paste the mermaid source into chat.** A terminal shows it as a pile of brackets and arrows, which buries the sentence the picture was meant to clarify. Chat gets a few words pointing at it — *"the shape of this is on the page"* — and nothing more. This is the general rule in `teach/SKILL.md` under *Two surfaces*.

Keep mermaid labels plain: **no LaTeX inside node labels** — it will not render, in the terminal or in Notion. Put the notation in the surrounding prose instead.
