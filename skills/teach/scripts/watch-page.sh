#!/usr/bin/env bash
# watch-page.sh — block until a Notion page's content changes, then exit.
#
# Polls the Notion REST API, hashes a normalised projection of the page's
# blocks, and exits the moment that hash moves. Nothing is printed while the
# page is unchanged, so a caller that backgrounds this pays NO context cost
# for waiting — it is woken exactly once, when there is something to read.
#
#   usage: watch-page.sh <page-id> [interval-seconds] [max-wait-seconds]
#
#   exit 0  page changed      (prints "changed")
#   exit 1  could not reach the API even once
#   exit 3  no token configured (prints the path it looked in)
#   exit 4  timed out, page never changed (prints "timeout")
#
# Token: ~/.config/claude-teach/notion-token, or $NOTION_TOKEN_FILE.
# The integration must be connected to the page (Notion: ⋯ → Connections).
#
# Interval: 5s is a good default and sits well inside Notion's ~3 req/s limit.
# Don't go below ~3s — a long page needs one request per 100 blocks, so the
# request rate is a multiple of the poll rate, and 429s will start eating polls.

set -uo pipefail

PAGE="${1:?usage: watch-page.sh <page-id> [interval] [max-wait]}"
INTERVAL="${2:-5}"
MAX_WAIT="${3:-1800}"

TOKEN_FILE="${NOTION_TOKEN_FILE:-$HOME/.config/claude-teach/notion-token}"
if [[ ! -r "$TOKEN_FILE" ]]; then
  echo "no-token: $TOKEN_FILE" >&2
  exit 3
fi
TOKEN="$(tr -d '[:space:]' < "$TOKEN_FILE")"

API="https://api.notion.com/v1"
NOTION_VERSION="2022-06-28"

# sha256 over (block id, type, checked, text) for every block on the page,
# following pagination so blocks appended at the end are covered — which is
# where questions live.
#
# Deliberately EXCLUDES last_edited_time and file URLs: Notion's signed file
# URLs rotate on their own schedule and would fire false "changed" events.
fingerprint() {
  local cursor="" url resp proj="" more
  while :; do
    url="$API/blocks/$PAGE/children?page_size=100"
    [[ -n "$cursor" ]] && url+="&start_cursor=$cursor"
    resp="$(curl -sS --max-time 20 \
      -H "Authorization: Bearer $TOKEN" \
      -H "Notion-Version: $NOTION_VERSION" \
      "$url")" || return 1
    jq -e '.results' >/dev/null 2>&1 <<<"$resp" || return 1
    proj+="$(jq -r '.results[] | . as $b
      | [ $b.id,
          $b.type,
          (($b[$b.type].checked // false) | tostring),
          (($b[$b.type].rich_text // []) | map(.plain_text) | join(" "))
        ] | @tsv' <<<"$resp")"
    proj+=$'\n'
    more="$(jq -r '.has_more' <<<"$resp")"
    [[ "$more" == "true" ]] || break
    cursor="$(jq -r '.next_cursor' <<<"$resp")"
  done
  printf '%s' "$proj" | shasum -a 256 | cut -d' ' -f1
}

baseline="$(fingerprint)" || { echo "fetch-failed" >&2; exit 1; }
[[ -n "$baseline" ]] || { echo "fetch-failed" >&2; exit 1; }

elapsed=0
while (( elapsed < MAX_WAIT )); do
  sleep "$INTERVAL"
  elapsed=$(( elapsed + INTERVAL ))
  # A transient failure must not kill the watch — just try again next tick.
  current="$(fingerprint)" || continue
  [[ -n "$current" ]] || continue
  if [[ "$current" != "$baseline" ]]; then
    echo "changed"
    exit 0
  fi
done

echo "timeout"
exit 4
