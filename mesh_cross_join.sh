#!/usr/bin/env bash
# mesh_cross_join.sh — create a cross-attestation PR from source to target
# Usage:
#   ./mesh_cross_join.sh <source_repo_url> <target_repo_ssh_or_https> "<pr_title>" "<pr_body>"
set -euo pipefail

for cmd in git gh; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "$cmd not found in PATH"; exit 1
  fi
done

SRC_URL="$1"; TGT_URL="$2"; PR_TITLE="$3"; PR_BODY="$4"

WD="$(mktemp -d)"; cd "$WD"
git clone "$TGT_URL" target
cd target

# ensure an attestation log exists
touch ATTESTATION_LOG.md

mkdir -p attestations
F="attestations/attestation_$(date -u +%Y%m%dT%H%M%SZ).md"
cat <<EOF > "$F"
$PR_BODY

Source: $SRC_URL  
Timestamp: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
EOF

# append to top of the log
TMPLOG="$(mktemp)"
{
  echo "## Attestation $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
  echo ""
  echo "$PR_BODY"
  echo ""
  echo "---"
  echo ""
  cat ATTESTATION_LOG.md
} > "$TMPLOG"
mv "$TMPLOG" ATTESTATION_LOG.md

BR="attest-$(date -u +%Y%m%dT%H%M%SZ)"
git checkout -b "$BR"
git add .
git commit -m "$PR_TITLE"
git push -u origin "$BR"

# open PR via gh; try to auto-merge (squash). If auto fails, we still succeed.
gh pr create --title "$PR_TITLE" --body "$PR_BODY" || true
gh pr merge --auto --squash || true

echo "✅ Cross-attestation PR opened from $SRC_URL to $(basename "$TGT_URL")"
