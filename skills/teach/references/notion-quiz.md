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

Then say one line in the terminal, **arm the watch** (below), and end your turn:

> Q3 is up in Notion — tick a box or type your answer; I'm watching.

Do not paste the question into the terminal as well. It will render badly, which is the entire problem you are solving, and a learner reading the terminal copy will answer from the degraded version.

**One live question at a time.** Batching costs adaptivity (`quiz.md`), and it also makes a fetch ambiguous about which question a tick belongs to. The exception is the same one as always: genuinely independent strands probed together — number them and post them in one append.

## The watch — never make them nudge you

The learner should not have to tell you they've answered. Tick a box, type a sentence — you notice, within about five seconds.

**Arm the watch, then end your turn:**

```
Bash(command="~/.claude/skills/teach/scripts/watch-page.sh <page-id> 5",
     run_in_background=true, description="waiting on Q3")
```

A backgrounded command re-invokes you when it exits, and `watch-page.sh` exits **only when the page actually changes**. So you are woken exactly once — when there is something to read. While the learner is still thinking, the script is silent and you are not running at all: no turns, no tokens, no context.

That last part is the whole design. The naive version — wake on a timer, `notion-fetch`, look — pulls the entire lesson page into context on every poll just to discover that nothing happened. On a long page that is thousands of tokens per check, and it makes a 5-second cadence impossible. The script hashes the page **outside** your context and only wakes you on a real change, so polling is free and can be fast.

**Read the exit code before anything else:**

| Exit | Meaning | Do |
|---|---|---|
| 0 `changed` | They touched the page | `notion-fetch` and grade — this is the only branch that costs context |
| 4 `timeout` | 30 min, no change | Say once: *"Still on Q3 whenever you're ready."* Stop watching. |
| 3 `no-token` | Not configured | Fall back to the timer mode below. Mention it once, never again. |
| 1 | API unreachable | Fall back to timer mode; say so once. |

On exit 0, `notion-fetch` the page and branch:

| State of `### Q3` | Do this |
|---|---|
| Sentinel already replaced | Stale wake — you already graded it. Emit nothing, re-arm nothing. |
| A box ticked, or text written | Grade it in place. One-line verdict in chat. Move on. |
| Still untouched | Re-arm another `sleep 20`. **Output no text at all.** |

**Silence on an idle wake is not optional.** A "still waiting…" line every twenty seconds is more annoying than the nudge this replaces. The learner should see nothing between posting the question and the verdict.

**Cap the wait at ~15 idle cycles (≈5 minutes).** Then stop re-arming and say once: *"Still on Q3 whenever you're ready — say `go` if I miss it."* A watch that re-arms forever burns turns while they're at lunch.

**One watch at a time, ever.** Two live watches double the wake rate and race each other to grade the same question. Before arming, be sure the previous one is resolved or stale.

**They may answer in the terminal instead** — a typed message reaches you immediately and interrupts the wait. Handle it normally; when the orphaned watch later fires, the sentinel is gone, so it reads as a stale wake and dies quietly. That's why the stale-wake branch exists.

### Fallback: timer mode, when there's no token

`watch-page.sh` needs a Notion internal-integration token (`~/.config/claude-teach/notion-token`). Without one it exits 3, and you degrade to a timer:

```
Bash(command="sleep 20", run_in_background=true, description="waiting on Q3")
```

Same loop, but each wake costs a full `notion-fetch` whether or not anything changed, so the interval has to stay around 20 seconds and the wait is not free. Tell the learner once that answers will be picked up a bit slowly and that the token removes it; then drop the subject. Never let setup nagging interrupt a lesson.

### What the hash covers

The fingerprint is sha256 over `(block id, type, checked, text)` for every block, following pagination so blocks appended at the end are included — which is exactly where questions live.

It deliberately **excludes** `last_edited_time` and file URLs, because Notion's signed URLs rotate on their own and would otherwise fire a "changed" event every few minutes with nobody having touched anything.

Two consequences worth knowing:

- **Text inside a collapsed toggle is not watched.** Child blocks aren't fetched. In practice answers go at the top level, so this doesn't bite — but if a learner starts writing inside a toggle, you won't be woken.
- **Any edit anywhere on the page wakes you**, not just the answer. Fixing a typo three sections up counts. That's fine and even useful — but it means exit 0 is *"something changed"*, never *"they answered"*. Always re-read the question's state before grading; never assume the wake was the answer.

## Reading the answer

On each wake, `notion-fetch` the lesson page and look at the to-dos under the `### Q3` heading:

| What you see | What it means |
|---|---|
| Exactly one `- [x]` | That's their answer. Grade it. |
| No `- [x]` | Not answered yet. Say so plainly and wait — do not guess, and do not treat it as "I don't know". |
| More than one `- [x]` | Ask them to leave one ticked, unless you posted it as multi-select. |

**Anything they write counts as an answer, not just a tick.** A paragraph under the question, a word scrawled next to an option, a half-formed thought — all of it comes back in the fetch, and all of it is fair to grade. Free text is *more* diagnostic than a tick (`quiz.md` on the "Other" slot): it shows you the reasoning, not just where it landed. Treat it as a gift, never as a protocol violation, and never re-ask for a tick when they've already told you what they think.

Comments are the one input the plain fetch misses — pass `include_discussions: true` to see them, and check there if the page body looks untouched but they clearly responded.

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
