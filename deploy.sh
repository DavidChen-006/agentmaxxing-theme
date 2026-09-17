#!/usr/bin/env bash
# Commit, push, and tell Discourse to pull from GitHub.
#
#   ./deploy.sh "tighten topic list spacing"
#   ./deploy.sh                 # push already-committed work
#
# The live theme is git-linked, so GitHub is the source of truth and this
# script is the only path from a local edit to the live site.

set -euo pipefail

SITE="https://agentmaxing.org"
THEME_ID=1

cd "$(dirname "$0")"

API_KEY="$(python3 -c "
import re, pathlib, sys
p = pathlib.Path.home() / '.discourse_theme'
if not p.exists():
    sys.exit('No ~/.discourse_theme. Run: discourse_theme watch . (once, to store a key)')
m = re.search(r'agentmaxing\.org:\s*(\S+)', p.read_text())
sys.exit('No key for agentmaxing.org in ~/.discourse_theme') if not m else print(m.group(1))
")"

if [[ -n "$(git status --porcelain)" ]]; then
  git add -A
  git commit -q -m "${1:-Update theme}"
  echo "committed: ${1:-Update theme}"
fi

git push -q origin main
echo "pushed:    $(git rev-parse --short HEAD)"

curl -sf --max-time 60 -X PUT \
  -H "Api-Key: $API_KEY" -H "Content-Type: application/json" \
  -d '{"theme":{"remote_update":true}}' \
  "$SITE/admin/themes/$THEME_ID.json" \
| python3 -c "
import json, sys
rt = (json.load(sys.stdin).get('theme') or {}).get('remote_theme') or {}
local, remote = rt.get('local_version'), rt.get('remote_version')
print(f\"live:      {(local or '?')[:7]}\")
print('IN SYNC' if local == remote else f\"OUT OF SYNC - remote is {(remote or '?')[:7]}\")
"
