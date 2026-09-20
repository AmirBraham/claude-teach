# Graded questions

A graded question has a correct answer that **you** decide before asking. You ask it with `AskUserQuestion`, then grade it in your very next message. It is the instrument that locates the learner's edge (Phase 1a) and confirms a node landed (Phase 3, step 4).

This is not the same tool-use as asking a preference. The difference is entirely in your head and in what you do with the answer — so hold the distinction deliberately.

## The harness constraints — design around them

`AskUserQuestion` was built for decisions, not quizzes. Four consequences you must actively compensate for:

1. **Max 4 options per question.** One slot goes to "I don't know" (below), leaving **three** real options. Three tight, diagnostic options beat four padded ones — this is a mild constraint, not a real loss.
2. **No auto "I don't know."** Add it yourself as an explicit final option, every single time. Phrase it plainly: `"I don't know"`, with description `"Genuine gap — I'd be guessing otherwise."` Without it, an unsure learner guesses, and a lucky guess reads to you as knowledge. That single corruption can send you teaching at the wrong level for the rest of the session.
3. **No shuffle.** Nothing randomizes position for you. Vary the correct answer's slot deliberately across a session and keep a rough count — if the last three answers were all option B, that is a pattern the learner will notice and start playing.
4. **Grading is one message later.** The learner picks, then your next message delivers ✓/✗, the correct answer, and the explanation. Never skip it and never bury it — open the message with the verdict, before any teaching. A graded question whose grade never arrives teaches nothing.

The auto-added "Other" slot lets them type free text. Read it when it appears: it usually carries what they were actually thinking, which is more diagnostic than the option they landed on.

## Writing the options — a construction procedure

The rule "keep options even" isn't enough on its own, because it's a *post-hoc audit* — you write a good answer plus some throwaway wrongs, then don't re-scrutinise them. The tell is baked in before any check runs. So don't audit afterwards; **build the options so evenness is automatic**:

1. **Every option is a bare claim — no justification anywhere.** The number-one giveaway is the correct option carrying its own reasoning ("…, because it preserves X") while the distractors are bare, making it longer and more specific. Put *zero* "why" in any option; all reasoning goes into the grading message, which only appears after they answer.
2. **Write the correct claim first, then mutate it into each distractor.** Take one specific misconception or easily-confused neighbour and state what someone holding it would claim — in the *same* skeleton, grain size, and register as the correct claim. Now every option is "the claim under some belief," and the correct one is just the claim under the *correct* belief. Parallelism falls out by construction instead of being policed.
3. **Each distractor must be a real error they might actually make** — a common misconception, or an adjacent easily-confused concept — so that *which* wrong answer they pick reveals *which* nuance is off. You learn far more from a targeted wrong choice than from binary right/wrong, and the choice tells you exactly which gap to teach into next.
4. **Every distractor must still be unambiguously wrong on the intended reading** — tempting, but a real error, not a defensible alternative. Don't drift into trick questions.
5. **No asymmetric emphasis.** Don't bold or italicize the key concept in one option and not the others — highlighting the term you're testing only in the correct answer flags it instantly. Either emphasize nothing, or emphasize the parallel term in every option.
6. **Anti-guessing hygiene.** Don't let the correct answer stand out by form: longest, most precise, most hedged, or the only one in the right format. Keep options similar in length, specificity, and phrasing so it can't be picked from shape alone.

**The cold-read test:** reading the finished set as if you didn't know the material, can you still tell which is right? If yes, you skipped step 1 or 2 — regenerate the set, don't patch it.

## Asking

- **One question per call while probing.** `AskUserQuestion` accepts up to four, but batching them costs you adaptivity — the whole point of Phase 1a is that each question is chosen in light of the last answer. Batch only when the questions are genuinely independent (e.g. mapping several unrelated prerequisite strands at once).
- **Use `multiSelect: true` only when more than one option is correct**, and grade it as an exact-set match: correct only if they select every correct option and no incorrect ones.
- **Keep `header` under 12 characters** — it's a chip, not a summary.
- **Put shared context in the question text**, not repeated across options.
- **No LaTeX in labels or headers.** They render as plain terminal text. Write "x squared" in the label; save `$x^2$` for the grading message and the Notion log.

## Grading

Your next message must, in this order:

1. **Verdict first.** ✓ or ✗, unmissable, before anything else.
2. **The correct answer**, stated plainly — even when they got it right, so the right answer is reinforced rather than merely confirmed.
3. **Why it's correct.** Not a restatement of the answer — the *reason*, tied back to whatever node it rests on. This is the field that does the teaching.
4. **If they were wrong: what their specific choice reveals.** They picked a particular misconception; name it and address that one, not wrongness in general.
5. **If they chose "I don't know": treat it as a genuine gap, not a wrong answer.** They told you the truth instead of guessing, which is the most useful answer they can give you. Teach into it directly; never imply they should have guessed.

Then continue — or stop and fix the node, if this was a Phase 3 quiz-check and it missed.
