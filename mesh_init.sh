#!/usr/bin/env bash
# mesh_init.sh  — initialize a repo with a README and attestation.json, then push
# Usage:
#   ./mesh_init.sh <repo_url> "<commit_author_name>" "<commit_author_email>" "<readme_title_line>" "<attestation_json>"
set -euo pipefail

if ! command -v git >/dev/null 2>&1; then
  echo "git not found in PATH"; exit 1
fi

REPO_URL="$1"; AUTHOR_NAME="$2"; AUTHOR_EMAIL="$3"; TITLE="$4"; ATTEST="$5"

WD="$(mktemp -d)"
cd "$WD"

git init
git config user.name "$AUTHOR_NAME"
git config user.email "$AUTHOR_EMAIL"

echo "# $TITLE" > README.md
printf '%s\n' "$ATTEST" > attestation.json

git add README.md attestation.json
git commit -m "init: canonical seed by $AUTHOR_NAME"
git branch -M main
git remote add origin "$REPO_URL"
git push -u origin main

echo "✅ Initialized and pushed to $REPO_URL"
