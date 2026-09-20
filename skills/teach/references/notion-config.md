# Notion config

Stored settings for the lesson log. Update this file whenever the destination changes.

| Setting | Value |
|---|---|
| Parent page name | _not configured_ |
| Parent page ID | _not configured_ |
| Configured on | _pending_ |

## If this says "not configured"

The log destination has never been set up. On the next session:

1. Check `claude mcp list` — the `notion` server must not say *needs authentication*. If it does, ask the learner to run `/mcp` and authorize.
2. Run `notion-search` for a page named "Learning".
3. If one exists, ask the learner to confirm it's the right destination. If none exists, ask where lessons should live, then create the page.
4. Write the name and ID into the table above.

Do this once, at the start of the session, before Phase 1. Don't ask again afterwards.

Once configured, create each lesson as a child of the stored page with
`notion-create-pages`, passing `parent: { type: "page_id", page_id: "<stored id>" }`.
Do **not** pass `creation_mode: "draft"` — it is server-enforced to ignore `parent`,
which would scatter lessons across the workspace root instead of nesting them.

Per the contract in `notion.md`, a missing parent is never fatal: mention it once,
keep teaching, and reconfigure afterwards rather than dropping into setup mid-lesson.
