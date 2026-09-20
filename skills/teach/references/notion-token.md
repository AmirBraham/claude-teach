# The watch token — one-time setup

`scripts/watch-page.sh` needs a Notion API token so it can poll the page from bash, outside your context. This is the difference between noticing an answer in ~5 seconds for free and polling expensively every 20.

**Token file:** `~/.config/claude-teach/notion-token` (override with `$NOTION_TOKEN_FILE`).

## Check before you need it

At the **start of a session**, before Phase 1a, check whether the file exists:

```
test -r ~/.config/claude-teach/notion-token && echo configured || echo missing
```

Do this once, up front — not at the moment you first need to ask a question. Discovering the token is missing mid-probe means interrupting a lesson to run setup, which is exactly the wrong time.

## If it's missing

Ask **once**, as an open question, and make declining easy:

> Before we start — I can watch the Notion page and pick up your answers the moment you tick a box, but that needs a Notion API token. Takes about two minutes:
>
> 1. Go to https://www.notion.so/my-integrations → **New integration** → internal, pointed at your workspace
> 2. Copy the token (starts `ntn_`)
> 3. Open your lessons parent page → **⋯ → Connections** → add the integration
> 4. Then run, in your own terminal:
>    ```
>    mkdir -p ~/.config/claude-teach
>    printf '%s' 'ntn_YOUR_TOKEN' > ~/.config/claude-teach/notion-token
>    chmod 600 ~/.config/claude-teach/notion-token
>    ```
>
> Skip it and everything still works — I'll just check for your answers on a slower timer.

Then **respect the answer permanently**. If they skip, run in timer mode (`notion-quiz.md`) and do not raise it again this session, or any later one. A setup prompt that reappears every lesson is worse than the friction it removes.

## Never handle the token yourself

**Tell them to run the `printf` in their own terminal. Do not offer to write it for them, and do not ask them to paste the token into the chat.** Anything pasted into the conversation is in the transcript, and a transcript is not a secret store. If they paste it anyway: write it to the file so their setup works, then tell them plainly, once, that it's now in the transcript and should be rotated. Don't lecture, and don't refuse — it's their token and their call.

The same goes for reading it: the script loads the file itself. You never need the token's value in context, so never `cat` it.

## Verifying it works

One request, no secrets in the output:

```
curl -sS -o /dev/null -w '%{http_code}\n' \
  -H "Authorization: Bearer $(cat ~/.config/claude-teach/notion-token)" \
  -H "Notion-Version: 2022-06-28" \
  "https://api.notion.com/v1/blocks/<parent-page-id>/children?page_size=1"
```

- **200** — working.
- **404** — the token is valid but the integration isn't connected to the page. Send them to **⋯ → Connections** on the parent page; child pages inherit, so connecting the parent is enough.
- **401** — bad or revoked token. Re-run setup.

A 404 here is the common failure and it does *not* look like a permissions error, so check for it explicitly before concluding the token is bad.
