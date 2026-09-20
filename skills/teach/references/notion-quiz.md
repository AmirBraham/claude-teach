# Graded questions in Notion

`AskUserQuestion` renders in a terminal, and terminals cannot render math. A question about $`\frac{d}{dx} e^{x^2}`$ degrades to "d/dx of e to the x squared" — which is not the same question, and is a worse one. Notion renders LaTeX natively, so math-bearing questions are asked **there** and answered **there**.

This file covers only the mechanics of the Notion surface. The option-construction procedure in `quiz.md` is surface-independent and still governs every question you write here — read it first.

## Which surface

| Question | Surface |
|---|---|
| Graded, contains math notation | **Notion** |
| Graded, no math | `AskUserQuestion` |
| Open (no right answer) | `AskUserQuestion`, always |

Math in *any* part of the question — the stem, a single option, or the explanation you're about to give — sends the whole thing to Notion. Splitting one question across two surfaces is worse than either surface alone.

Open questions never go to Notion. They're conversational, they steer the session, and routing them through a page round-trip adds latency to the one exchange that most needs to be fast.

If the learner asks for everything in Notion, or everything in the terminal, do that instead. Their preference beats the table.

## Posting a question

Append to the lesson page with `notion-update-page`, `command: "insert_content"`, `position: {"type": "end"}`, `allow_async: false` — you need it actually on the page before you tell them it's there.

```
### Q3 · check: chain rule

What is $`\frac{d}{dx} e^{x^2}`$?

- [ ] A. $`e^{x^2}`$
- [ ] B. $`2x\,e^{x^2}`$
- [ ] C. $`x^2 e^{x^2-1}`$
- [ ] I don't know

*Q3 — awaiting answer…*
```

Four things are load-bearing:

- **The heading** is `### Q<n> · <probe | check: node name>`, numbered across the whole session. It's how you find the block again on fetch, and how the page reads as a record later.
- **The to-do list is the input widget.** `- [ ]` round-trips: tick one in the Notion UI and a later `notion-fetch` returns `- [x]`. This is verified behaviour, not an assumption.
- **"I don't know" is still an option**, exactly as in `quiz.md`. Notion has no 4-option cap, but that was never why the option exists — an unsure learner who guesses corrupts your map of their edge regardless of surface.
- **The last line is the grading sentinel.** It must contain the question number so it's unique on the page. You will replace this exact string when you grade.

Then say one line in the terminal and **end your turn**:

> Q3 is up — tick one in Notion, then say `go`.

Do not paste the question into the terminal as well. It will render badly, which is the entire problem you are solving, and a learner reading the terminal copy will answer from the degraded version.

**One live question at a time.** Batching costs adaptivity (`quiz.md`), and it also makes a fetch ambiguous about which question a tick belongs to. The exception is the same one as always: genuinely independent strands probed together — number them and post them in one append.

## Reading the answer

On their nudge, `notion-fetch` the lesson page and look at the to-dos under the `### Q3` heading:

| What you see | What it means |
|---|---|
| Exactly one `- [x]` | That's their answer. Grade it. |
| No `- [x]` | Not answered yet. Say so plainly and wait — do not guess, and do not treat it as "I don't know". |
| More than one `- [x]` | Ask them to leave one ticked, unless you posted it as multi-select. |

If they typed something instead of ticking — a paragraph under the question, or a comment — read it and grade that. Free text is more diagnostic than a tick (`quiz.md` on the "Other" slot), so treat it as a gift rather than a protocol violation.

## Grading in place

Replace the sentinel with the verdict, using `notion-update-page`, `command: "update_content"`:

```json
{"old_str": "*Q3 — awaiting answer…*", "new_str": "<the verdict block>"}
```

The verdict block is a toggle — verdict visible, reasoning collapsed:

```
<details>
<summary>✓ Q3 — correct. The answer is B.</summary>
	The outer $`e^u`$ differentiates to itself; the inner $`u = x^2`$ contributes $`2x`$ by the chain rule.
</details>
```

```
<details>
<summary>✗ Q3 — you picked A. The answer is B.</summary>
	A is $`e^{x^2}`$ with no inner derivative — the chain rule's second factor dropped. That's the misconception to fix: $`e^{f(x)}`$ differentiates to $`f'(x)\,e^{f(x)}`$, not $`e^{f(x)}`$.
	The outer $`e^u`$ differentiates to itself; the inner $`u = x^2`$ contributes $`2x`$.
</details>
```

Collapsing the reasoning is deliberate: it leaves the page re-readable as a quiz weeks later instead of as an answer key. The grading content itself follows `quiz.md` exactly — correct answer stated even when they were right, the *reason* not a restatement, and for a wrong answer, what their specific choice reveals.

**In the terminal, give the verdict in one line** and nothing more:

> ✓ Q3 — correct, it's B. Reasoning is on the page.

The "verdict first, unmissable" rule from `quiz.md` still binds; it's satisfied by that line. The explanation lives in Notion because the explanation is where the math is.

## Escaping

Notion-flavored Markdown wants `\ * ~ \` $ [ ] < > { } | ^` escaped in ordinary text — which is most of LaTeX. **Inside an equation you do not escape anything.** Write the LaTeX exactly as you mean it:

- Inline: `` $`\frac{d}{dx} e^{x^2}`$ `` — backticks inside the dollars
- Display: `$$` fenced on its own lines

Bare `$...$` also works (Notion coerces it into an equation), but the backticked form is the spec and won't surprise you next to a literal dollar sign.

## When Notion is down

Same contract as `notion.md`: never fatal, mention it once, keep teaching. Fall back to `AskUserQuestion` with the math written out in words, and say that's what you're doing so they know why the question suddenly looks clumsy. A degraded question beats a blocked lesson.
