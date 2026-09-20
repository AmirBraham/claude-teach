#!/usr/bin/env bash
# Install the teach/visualize skills and the researcher agent into ~/.claude.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${CLAUDE_HOME:-$HOME/.claude}"

# Copy $1 -> $2, prompting before clobbering an existing, different file.
install_file() {
  local from="$1" to="$2"
  if [[ -e "$to" ]] && ! cmp -s "$from" "$to"; then
    printf '  exists: %s\n' "${to/#$HOME/\~}"
    read -r -p "          overwrite? [y/N] " reply </dev/tty || reply=n
    [[ "$reply" =~ ^[Yy]$ ]] || { printf '          skipped\n'; return; }
  fi
  mkdir -p "$(dirname "$to")"
  cp "$from" "$to"
  printf '  ok:     %s\n' "${to/#$HOME/\~}"
}

printf 'Installing into %s\n\n' "${DEST/#$HOME/\~}"

while IFS= read -r f; do
  install_file "$SRC/$f" "$DEST/$f"
  if [[ "$f" == *.sh && -e "$DEST/$f" ]]; then chmod +x "$DEST/$f"; fi
done < <(cd "$SRC" && find skills agents -type f \( -name '*.md' -o -name '*.sh' \) | sort)

cat <<'EOF'

Done. Next, for the Notion lesson log:

  claude mcp add --transport http --scope user notion https://mcp.notion.com/mcp

then run /mcp inside Claude Code and authorize. The first /teach will set up the
log destination and remember it.

Optional — answer questions in Notion without touching the terminal. Create an
internal integration at https://www.notion.so/my-integrations, connect it to
your lessons parent page (⋯ → Connections), then:

  mkdir -p ~/.config/claude-teach
  printf '%s' 'ntn_YOUR_TOKEN' > ~/.config/claude-teach/notion-token
  chmod 600 ~/.config/claude-teach/notion-token

Without it, /teach still works — it just polls less often and more expensively.

Start a lesson with:  /teach <topic>
EOF
