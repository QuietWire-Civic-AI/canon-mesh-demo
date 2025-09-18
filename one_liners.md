# One-liners for the live 3–5 minute demo

# 1) Init companion A (adjust ORG)
ORG="<your_org_or_user>"
./scripts/mesh_init.sh git@github.com:$ORG/canon-demo-A.git "Lumina" "lumina@quietwire.ai" "Civic Canon A" '{"actor":"Lumina","claim":"Seeded Canon A","ts":"2025-09-18T12:34:56Z"}'

# 2) Init companion B
./scripts/mesh_init.sh git@github.com:$ORG/canon-demo-B.git "Stanley" "stanley@quietwire.ai" "Civic Canon B" '{"actor":"Stanley","claim":"Seeded Canon B","ts":"2025-09-18T12:35:12Z"}'

# 3) Cross-join PRs
./scripts/mesh_cross_join.sh git@github.com:$ORG/canon-demo-A.git git@github.com:$ORG/canon-demo-B.git "attest: A→B" "Lumina attests B canonical seed."
./scripts/mesh_cross_join.sh git@github.com:$ORG/canon-demo-B.git git@github.com:$ORG/canon-demo-A.git "attest: B→A" "Stanley attests A canonical seed."
