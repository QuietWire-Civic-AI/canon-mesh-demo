 Canon Mesh Demo (GTFO)
Minimal, stage-safe toolkit to demo two AI companions creating canonical repos and cross-attesting via PRs.

## What this contains
- `scripts/mesh_init.sh` — create README + `attestation.json`, commit, push.
- `scripts/mesh_cross_join.sh` — open a cross-attestation PR (auto-merge if allowed).
- `scripts/one_liners.md` — copy/paste commands for the 3–5 minute demo.
- `prompts/seed_prompts.md` — tiny prompts for each companion to author README + attestation.
- `.gitignore` — typical Python/Node/OS noise ignored.
- `LICENSE` — MIT.

## Quickstart (single machine with `git` and `gh` installed)
1) Authenticate once:  
   ```bash
   gh auth login
   ```

2) Create two empty repos (or use existing):  
   ```bash
   ORG="<your_org_or_user>"
   gh repo create "$ORG/canon-demo-A" --public --confirm
   gh repo create "$ORG/canon-demo-B" --public --confirm
   ```

3) For each companion output (copy JSON+title from chat), run from any temp dir:  
   ```bash
   chmod +x scripts/*.sh
   ./scripts/mesh_init.sh git@github.com:$ORG/canon-demo-A.git "Lumina" "lumina@quietwire.ai" "Civic Canon A" '{"actor":"Lumina","claim":"Seeded Canon A","ts":"2025-09-18T12:34:56Z"}'
   ./scripts/mesh_init.sh git@github.com:$ORG/canon-demo-B.git "Stanley" "stanley@quietwire.ai" "Civic Canon B" '{"actor":"Stanley","claim":"Seeded Canon B","ts":"2025-09-18T12:35:12Z"}'
   ```

4) Cross-join PRs:  
   ```bash
   ./scripts/mesh_cross_join.sh git@github.com:$ORG/canon-demo-A.git git@github.com:$ORG/canon-demo-B.git "attest: A→B" "Lumina attests B canonical seed."
   ./scripts/mesh_cross_join.sh git@github.com:$ORG/canon-demo-B.git git@github.com:$ORG/canon-demo-A.git "attest: B→A" "Stanley attests A canonical seed."
   ```

Open the two PR pages (auto-merge may already have completed) and show `ATTESTATION_LOG.md` updates.
