# Risk Register — MayaBank Azure

| ID | Risque | Prob. | Impact | Réponse | Preuve attendue |
|---|---|---|---|---|---|
| R01 | privilèges excessifs | M | H | PIM, groupes, scope minimum | export RBAC/PIM |
| R02 | secret exposé dans Git/CI | M | H | OIDC, Managed Identity, secret scanning | pipeline sans secret |
| R03 | mauvaise résolution DNS Private Link | M | H | DNS centralisé, tests hybrides | résolution depuis Azure/on-prem |
| R04 | coût réseau sécurité trop élevé | M | M | cible vs lab, sizing, activation à la demande | coût observé |
| R05 | saturation AKS | M | H | HPA/KEDA, cluster autoscaler, capacity test | test de charge |
| R06 | upgrade AKS perturbateur | M | H | PDB, maintenance, staging | upgrade lab |
| R07 | API exposée sans policy | M | H | APIM baseline policies | tests 401/429 |
| R08 | double traitement paiement | M | H | idempotence, outbox, stable paymentId | duplicate test |
| R09 | poison message/DLQ non traité | M | H | retry borné, alerting, replay runbook | DLQ exercise |
| R10 | perte de données | L/M | H | backup + restore tests, réplication | restore chronométré |
| R11 | multi-région théorique non opérable | M | H | tabletop + failover test | runbook exécuté |
| R12 | logs contenant données sensibles | M | H | logging policy, redaction, sampling | revue de logs |
| R13 | explosion facture observabilité | M | M | rétention, sampling, budgets | coût ingestion |
| R14 | ressource lab oubliée | H | M | destroy + inventory | zéro orphelin |
| R15 | migration big-bang | M | H | waves, coexistence, rollback | pilote |
| R16 | remplacement Kafka inadapté | M | H | analyse sémantique par flux | ADR par domaine |
| R17 | fuite de documents via RAG | M | H | authz avant retrieval, tests négatifs | unauthorized document test |
| R18 | hallucination IA métier | H | M/H | grounding, citations, eval, human escalation | benchmark |
| R19 | verrouillage Azure excessif | M | M | standards/API/events, ADR | exit analysis |
| R20 | sécurité sacrifiée au coût | M | H | risk acceptance explicite | architecture review |

## Échelle

- Probabilité : L faible, M moyenne, H élevée.
- Impact : L faible, M moyen, H élevé.

## Gouvernance

- Tout risque H/H ou M/H doit avoir un owner et une action.
- Un risque résiduel accepté doit être explicitement documenté.
- Chaque lab doit fermer ou requalifier au moins les risques qu'il teste.
- Le registre doit être revu après changement majeur d'architecture, nouveau service Azure, incident ou modification des NFR.
