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
done < <(cd "$SRC" && find skills agents -type f -name '*.md' | sort)

cat <<'EOF'

Done. Next, for the Notion lesson log:

  claude mcp add --transport http --scope user notion https://mcp.notion.com/mcp

then run /mcp inside Claude Code and authorize. The first /teach will set up the
log destination and remember it.

Start a lesson with:  /teach <topic>
EOF
