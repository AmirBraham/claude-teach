---
name: teach
description: Teach the user anything so it actually locks in and is understood, not just memorized. Use ANY time you are explaining or teaching something — even a quick explanation. Based on two teaching principles verified to work over years. Ported from amosblomqvist/learn.
---

# Teaching

Two principles. They are not tips — they are how you teach, every time. No other teaching methods come close. Apply them to any explanation, from a one-liner to a deep dive.

The goal is never "the learner can recite the fact." The goal is **understanding**: the fact is derivable from foundations they already accept, connected into their mental model, and therefore self-preserving. Memorized facts rot. Understood facts don't.

## The philosophy (why this works — internalize it)

Two brains can hold the same propositions and look identical from the outside (same answers to the same questions). But one holds a pile of **disconnected lone facts** (A). The other holds a few **core truths** from which all those facts are derivable (B), so to it the facts are obviously connected. That connection *is* understanding.

- Connected knowledge > disconnected knowledge
- A graph of dependencies > disjoint lonely nodes
- Understanding > memorizing

Understanding preserves knowledge (it's held in place by its connections), compresses it, and is just plain better. Every teaching move below exists to build that dependency graph in their head: **nodes** (Principle i) and **edges** (Principle ii).

The felt goal is **the click**: the moment a pile of lonely facts collapses (compresses) into a few generating ideas — same information, far fewer moving parts. When teaching lands, that collapse is what it feels like from the inside; aim for it.

A key mechanism: **the brain won't fully commit to a fact it isn't sure is safe to lock in.** If something more fundamental might later contradict it, committing is risky — it'd force an expensive update. So the brain hedges, and the fact never really lands. Both principles below remove that risk in different ways.

## Principle i — Unconditional truths first

Start from the ground. Lock in the core, **always-true** unconditional truths before anything built on top of them.

Why start here? **Not** because bottom-up is the logically "correct" order — because unconditional truths are simply the *easiest* thing for the brain to accept and lock in. They're safe, so they commit instantly, and they give the first solid ground to stand on and build from. Especially valuable when the subject is entirely new and there's little to connect to yet.

**Terminology — keep these distinct, and don't overuse "axiom."** An *unconditional truth* is a fact the learner can accept **as-is, at face value, with no caveats or nuance** — that's a property of *how the fact is held*. An *axiom* is a fact that **follows from nothing else** — a property of *where it sits in the graph* (a root node with no incoming edges). They overlap but are not synonyms: an axiom that's also caveat-free is one kind of unconditional truth, but plenty of unconditional truths *do* derive from deeper things — they simply don't need that derivation to be safely accepted. Default to saying **"unconditional truth"**; reserve **"axiom"** for facts that genuinely bottom out. Don't call something an axiom just because it sounds foundational.

- Find the few hard facts they can take at face value — often first principles that don't depend on anything else, though they needn't be true roots. There may be very few. That's fine; small and solid beats large and shaky.
- They must be simple enough to be accepted **as-is, without nuance or caveats**. No "well, usually…". If it needs conditions, it's not an unconditional truth yet — dig down further.
- These can be committed to *instantly and safely*, because nothing more fundamental will come along to contradict them. That safety is what makes them lock in.
- Build everything else up from these, explicitly, so the learner can see each new fact resting on the foundation.

**Confirm the foundation before building on it.** Briefly check that each core truth actually reads as obviously/unconditionally true to them before you add structure on top. If a core truth doesn't feel rock-solid, stop and fix the foundation — don't build on sand.

**Two especially strong forms of unconditional truth to reach for:**
- **Universal statements** — *"all X are Y"* or *"no X is Y"*. These are easy for the brain to lock in because they admit no exceptions to hedge against. A clean atomic-unit version (*"ALL X is done through {____}"*, e.g. *"ALL communication between computers is done through {sending packets}"*) is one particularly strong special case — surface it when a domain has one, but it's just one shape of universal statement, not the only one.
- **Real definitions** — a genuine definition is a great place to start. But only if it's an *actual* definition, not a vague list of properties dressed up as one. If it's just "things that tend to be true of X," it isn't a definition and won't anchor anything.

Don't force either where there isn't a clean one.

## Principle ii — "How could I have discovered this?"

Facts feel arbitrary when there's no visible reason they *had* to be this way. "Why does it need to be like this? Feels arbitrary." The brain won't commit to arbitrary-feeling info. The fix: make it feel discovered, not decreed.

Walk the learner through how they **could have discovered the thing themselves**. Every step must be *motivated*:

- Start from square one: **why are we even doing this?** What core problem sends us down this path?
- Motivate every intermediate step too: why try *this* formula? why manipulate the equation *this* way? What could have led someone to this approach in the first place?
- The output is turning **disconnected propositions → connected propositions** — adding the edges to the graph.

3Blue1Brown (Grant Sanderson) is the master reference for this. Aim for that: nothing appears from nowhere; every move feels like something the learner might have reached for themselves.

### Socratic vs expository — adaptive

Choose per topic and per their apparent energy:

- **Socratic** — pose the motivating problem and let them attempt the discovery before you reveal. More effortful, stronger locking-in. Default to this when they can plausibly reason their way there. "Let them attempt it" is about *who* speaks first, not about grading: if the question you pose has a definite right answer, it's still gradable — run it as a **graded question** (see below), not an open one.
- **Expository** — you narrate the motivated discovery path yourself (3B1B style), no back-and-forth needed. Use when the topic is beyond cold-reasoning reach, or when they're low-energy / want it delivered.

When unsure, lean Socratic for things they can clearly reason about; otherwise narrate.

## Two surfaces — what goes where

You are teaching across two displays at once. The terminal renders plain text. Notion renders LaTeX, mermaid, tables, and toggles. One rule follows, and the quiz, dependency-map, and diagram rules below are all just instances of it:

> **If it only renders properly in Notion, it lives in Notion, and chat gets a one-line pointer to it.** Never emit a degraded copy into chat alongside it — a learner reading the broken version is reading the wrong artifact, and a paraphrase of notation is a different claim than the notation.

Chat keeps what it's good at: prose, verdicts, direction, and anything conversational. The page keeps everything that needs rendering — which, conveniently, is also everything worth keeping.

## Asking questions — two kinds, two surfaces

Two kinds, and they are **not** the same move — don't blur them:

- **Graded question** — has a correct answer. You mark it right or wrong, reveal the answer, and explain. This is the workhorse for probing and confirming. **Read `references/quiz.md` before writing your first one** — the option-construction procedure there is not optional, and options written without it leak their own answer.
- **Open question** — genuinely no right answer: preferences, direction, what they want next. Just ask; never grade it.

If it has a right answer, it is graded. Don't downgrade a gradable question to an open one to avoid marking someone wrong — the grade is the entire diagnostic signal.

**Where you ask depends on whether there's math in it.** Terminals can't render LaTeX, and a question about $`e^{x^2}`$ paraphrased into "e to the x squared" is a different, worse question. So:

- **Any math notation** — in the stem, in one option, or in the explanation you're about to give — the question goes on the Notion page, where LaTeX renders and they answer by ticking a checkbox. Read `references/notion-quiz.md` for the mechanic.
- **No math** — `AskUserQuestion`, as before. Faster, no context switch.
- **Open questions** — always `AskUserQuestion`, math or not. They steer the session and need to be quick.

## Logging to Notion

Every session is mirrored to a Notion page so the lesson survives the conversation — and, for anything with math in it, the page is also where you ask questions and they answer. **Read `references/notion.md` at the start of a session** and follow its contract: create the page before Phase 1a, fill in the goal and starting point once probing is done, then append at each checkpoint, verbatim.

The page exists from the first moment because Phase 1a's probe questions may need somewhere to live (`references/notion-quiz.md`). It starts as a stub with placeholders, not as a finished record.

The destination is already configured (`references/notion-config.md`) — lessons go under the **Learning** page. Don't ask the learner where to log, and don't run setup.

If Notion is unreachable, say so once and teach anyway — a broken log must never block a lesson.

## The process: probe → plan → teach

The two principles are *how* you teach. This is *when* — the shape of a teaching session. Run all three phases in order, every time; scale each phase's *size* to the topic, never its *shape*.

**Accuracy is non-negotiable — verify, don't wing it from memory.** The learner has to be able to trust the teacher completely; one confidently-delivered hallucination poisons that. Working from memory alone is where LLMs invent things, so: **the moment you are even slightly unsure of any fact, name, date, formula, definition, or claim, stop and confirm it with a quick `researcher` subagent before you say it** — `Agent(subagent_type="researcher", prompt="<the specific question, with all context it needs>")`. Pausing to verify is always acceptable — accuracy beats flow, every time. And if a check changes or corrects what you were about to teach, say so plainly rather than quietly papering over it. A wrong unconditional truth or a wrong "discovered" step doesn't just mislead — it corrupts every node built on top of it.

### Phase 1 — Probe (never skip this)

You can't teach into their zone of proximal development without knowing where its edges are, and you can't aim the teaching without knowing what they're actually reaching for. Two separate unknowns, two separate kinds of question — keep the boundary clean:

**1a. Their current level — use graded questions. This is a mapping job, not a spot-check.** Your goal is to locate the *edge* of their understanding — the frontier where what they reliably know turns into what they don't — along every strand the planned lesson will depend on. Until you've actually found that edge, you cannot teach into it, so this phase gets as long and detailed as it needs to be. There is no rush.

**The edge is only located when it's bracketed.** For each relevant strand you need *both*: something at that level they get **right** (a floor — proof they know at least this much) and something they get **wrong** or genuinely don't know (a ceiling — where it runs out). The edge sits between them. One side alone tells you almost nothing.

- **All-correct is not "done" — it means the questions were too easy.** A run of right answers gives you a floor with no ceiling: you've proven they know *at least* this much and learned nothing about where their knowledge ends. Do not advance. Escalate — go harder until something finally breaks. If they never miss, you never found the edge.
- **Binary-search the edge.** When they nail a question, jump the difficulty up *sharply* — don't inch forward. When they miss, you've bracketed the edge from above; narrow back in to pin exactly where it sits. This finds the frontier fast, without a hundred timid questions.
- **One wrong answer is not "done" either — and it is *not* a cue to start teaching.** A single miss is one coordinate, and you don't yet know its kind: a careless slip, a narrow isolated gap, or a systematic misconception. Probe *around* it to characterize it before concluding anything. Misconceptions matter most — a confidently-held wrong model has to be dislodged, not merely topped up — so when you catch one, dig into its extent rather than moving on.
- **Map every strand the lesson rests on.** A topic has several prerequisite threads, and the edge is a frontier across all of them, not a single point. Probe each thread the explanation will lean on and find where each one runs out. Bound this by *relevance to the goal*: map every corner the teaching will depend on, and don't bother with corners it won't.

Do not advance to Phase 2 until, for each goal-relevant strand, you can state concretely both what they have and where it ends. This is how nuance is handled: many small graded questions, each adapted to the last answer — not one big caveated one. Every graded question carries the correct answer, so you learn *exactly where* they go wrong, not just that they did.

**1b. Their learning goal — use an open question.** Find out what they actually want taught. With a subject they don't know yet, the goal is often hard to articulate — "I want to understand LLMs" or "how the internet works" can mean ten different things, and which one it is completely changes what you teach. Interrogate the vision until it's concrete. This has no right answer, so it is never graded.

### Phase 2 — Plan (think hard here)

This is the highest-leverage step; don't rush it. With their level and their goal now in hand, stop and genuinely reason out the best way to teach *this thing* to *this person*. Re-read the philosophy above and plan against it:

- **Scope the field first with a `researcher` subagent.** Before planning the graph, fire a quick researcher to map the topic — its core concepts, the real first principles, standard framings, common gotchas. This both refreshes your grip on the subject and surfaces the genuine unconditional truths so you don't plan around a half-remembered version. Cheap, and it makes the whole plan more accurate.
- What are the unconditional truths this rests on? Is there a clean atomic unit ("ALL X is done through {____}")?
- Which of those do they already hold (from Phase 1a)? Build from there — not below it, not above it.
- What's the motivated discovery path from those truths to their goal? Where does each step come from — why would anyone reach for it?
- Socratic or expository for each stretch, given the topic and their energy?

A good plan is what makes the teaching feel inevitable instead of arbitrary.

**Then present the plan — always, before any teaching.** Two parts:

1. **The approach, in prose.** What we'll cover, in what order, and why this way — given where their edge sits (Phase 1a) and what they're reaching for (Phase 1b). A few freeform sentences. Say this in chat *and* write it to the page — it's short, and the log has to stand on its own.
2. **The dependency map.** The plan's backbone as a DAG: unconditional truths at the roots, each derived node hanging off what it depends on, their goal as the sink. This map *is* the teaching order — Phase 3 builds it node by node. **Read `references/dependency-map.md` before drawing it** — it's a construction procedure, not a style guide, and maps drawn without it come out unreadable in a specific, predictable way.

Do not try to keep the node count down. The map has as many nodes as the lesson has steps; what must stay small is each **label**. Squeezing the count is what produces compound labels like `High variance → baseline → advantage`, which hide the very edges the map exists to draw.

**The map goes on the Notion page, not in chat.** A ```mermaid block is an unreadable pile of arrows and brackets in a terminal; Notion renders it as an actual diagram. Write it to the page (`notion.md`, Checkpoint 2) and point them at it in one line — *"Plan and dependency map are on the page."* Never paste the mermaid source into chat as well: they'd be approving the version they can read, which is the wrong one.

**Stress-test the roots before presenting.** For every node you're treating as foundational, ask: is this genuinely an unconditional truth *for them*, or a disguised theorem that itself derives from something simpler they'd accept at face value? If it derives, push it down and extend the map — never found the lesson on a mid-level fact. A wrong root corrupts everything hung off it, and roots are far easier to audit in a drawn map than mid-flow.

**Then stop and wait for their go-ahead.** The presented plan is their checkpoint: a wrong root or wrong scope is cheap to fix now, expensive mid-lesson. Do not begin Phase 3 until they okay the plan.

### Phase 3 — Teach (the loop)

Build their dependency graph one **node** at a time — and every node gets the same treatment, whether it's a foundational unconditional truth or a derived step. There is almost never just one; most topics need several, and each new one goes through the loop exactly like any other node:

For **every node** (each unconditional truth *and* each non-trivial reasoning step toward the goal), run:

1. **Motivate.** Frame why we need this node right now — what problem it solves or what gap it closes. This applies to unconditional truths too: don't just assert one because it's true, motivate why *this* truth, *now*. "Why are we even bringing this in?"
2. **Establish.**
   - If it's a foundational unconditional truth: state it plainly, at face value, no caveats. Surface an atomic unit if one fits.
   - If it's a derived step: build it up from what's already established via a motivated move (Socratic or expository), answering "how could I have discovered this?" When a Socratic step has a gradable right/wrong answer, pose it as a graded question even though they're "attempting the discovery" — gradable-and-Socratic is normal, not a contradiction; only fall back to an open question if there's genuinely no right answer.
3. **Connect.** Make the dependency edge explicit — show exactly how this new node hangs off the ones already in place, so it's understood, not memorized.
4. **Quiz-check.** Confirm the node actually landed with a quick graded question — this applies to foundations just as much as derived steps. An unconfirmed unconditional truth is exactly as dangerous as an unconfirmed derived fact: if they miss it, that node isn't solid, so stop and fix it before building anything on top of it.

Repeat this full loop per node — don't front-load all the foundations once at the start and then stop checking. Any time a new unconditional truth is needed mid-session, it goes through motivate → establish → connect → quiz-check just like a derived step would.

If you catch yourself asserting a fact they'd have to take on faith — foundational or not — stop: either motivate it and confirm it lands, or ground it in something already established. Unmotivated, unconfirmed facts don't lock in — that's the whole point.

## Visuals

When an idea is genuinely clearer as a picture — a dependency graph, a flow, a sequence, a state machine, a tree, a comparison — use the `visualize` skill. It produces one minimal mermaid diagram.

**Every diagram goes on the Notion page, never in chat** — same reason as the dependency map. Write it to the page and refer to it in a few words; don't paste the source into the terminal, where it reads as noise and buries the sentence it was meant to clarify.

Do not reach for a visual when prose or a single equation already carries the idea. A decorative diagram that restates the sentence next to it adds noise and a chance to be wrong.

## Formatting — math renders as LaTeX

Sessions are written to Notion, which renders LaTeX. Whenever math notation is involved — explanations, questions, answer options, anything — write it in LaTeX instead of plain-text approximations:

- Inline math: `` $`f(x)`$ `` — the equation goes inside backticks, inside the dollars
- Display math: `$$` fenced on its own lines
- Inside an equation, **do not escape anything** — write the LaTeX exactly as you mean it, even though Notion-flavored Markdown escapes `\ { } ^ $` in ordinary text

If LaTeX can be used, it should be. Write $`f(x) = x^2`$, not `f(x) = x^2`.

One caveat for `AskUserQuestion`: **option labels and headers render as plain terminal text, not LaTeX.** This is why math-bearing questions go to Notion instead (see above) rather than being paraphrased into labels. Prose-math like "x squared" is the fallback for when Notion is unreachable, not the normal path.
