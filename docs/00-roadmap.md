# Roadmap — Architecte Solution Azure

## But

Construire progressivement une plateforme bancaire fictive Azure suffisamment réaliste pour travailler les décisions attendues d'un Architecte Solution : exigences, gouvernance, sécurité, réseau, applicatif, intégration, data, exploitation, continuité, coût et IA.

## Definition of Done commune

Une itération est terminée uniquement si elle contient :

- exigences et hypothèses ;
- diagramme d'architecture ;
- alternatives étudiées ;
- ADR pour les choix structurants ;
- code IaC ou justification si le service n'est pas déployé ;
- commandes de validation ;
- tests positifs et négatifs ;
- estimation/coût observé ;
- procédure de destruction ;
- questions de soutenance.

## Itération 0 — Fondations ✅

- contexte MayaBank ;
- principes d'architecture ;
- NFR initiaux ;
- structure documentaire ;
- template ADR ;
- stratégie Terraform/Bicep ;
- stratégie de labs et coûts.

## Itération 1 — Azure Landing Zone ✅

### Réalisé
- Platform Landing Zone vs Application Landing Zones ;
- hiérarchie Management Groups ;
- modèle de subscriptions entreprise ;
- variante single-subscription pour le lab ;
- Azure Policy baseline ;
- naming/tagging standard ;
- ADR de gouvernance ;
- cible Terraform + Azure Verified Modules ;
- LAB 01 Policy as Code avec validation et destruction.

### Lab
`labs/lab-01-landing-zone`

## Itération 2 — Identity & Security

- Entra ID ;
- RBAC ;
- PIM ;
- Managed Identities ;
- workload identity ;
- Key Vault ;
- Defender for Cloud ;
- séparation des responsabilités.

## Itération 3 — Network Foundation

- Hub-Spoke ;
- Azure Firewall ;
- Private DNS ;
- Private Link / Private Endpoints ;
- NAT Gateway ;
- Application Gateway / Front Door ;
- ExpressRoute et VPN ;
- flux inter-zones et inter-régions.

## Itération 4 — AKS

- cluster privé ;
- node pools ;
- zones de disponibilité ;
- CNI ;
- ingress ;
- Key Vault CSI ;
- autoscaling ;
- quotas/limits ;
- network policies ;
- ACR ;
- GitOps.

## Itération 5 — API Management

- API gateway ;
- produits/subscriptions ;
- OAuth2/OIDC ;
- rate limiting ;
- JWT validation ;
- transformation ;
- private networking ;
- diagnostics ;
- versioning.

## Itération 6 — Event Driven Architecture

- Service Bus pour messaging métier fiable ;
- Event Hubs pour streaming à fort débit ;
- Event Grid pour distribution d'événements ;
- idempotence ;
- retry ;
- dead-letter ;
- outbox ;
- traçabilité.

## Itération 7 — Data

- Azure SQL / PostgreSQL ;
- Cosmos DB ;
- Storage Account ;
- Data Lake ;
- chiffrement ;
- sauvegarde ;
- private endpoints ;
- classification des données.

## Itération 8 — Observability

- Azure Monitor ;
- Log Analytics ;
- Application Insights ;
- OpenTelemetry ;
- SLI/SLO ;
- dashboards ;
- alertes ;
- corrélation distribuée.

## Itération 9 — HA / DR

- Availability Zones ;
- architecture multi-région ;
- RTO/RPO par service ;
- sauvegarde/restauration ;
- runbooks ;
- exercices de reprise ;
- chaos/resilience tests.

## Itération 10 — FinOps / GreenOps

- tagging économique ;
- budgets/alerts ;
- rightsizing ;
- autoscaling ;
- réservations/savings plans selon contexte ;
- arrêt automatique des environnements de lab ;
- mesure coût par workload ;
- arbitrage performance/coût/empreinte.

## Itération 11 — AI Platform

- Azure AI Foundry ;
- Azure OpenAI ;
- Azure AI Search ;
- RAG ;
- identité managée ;
- réseau privé ;
- sécurité des données ;
- évaluation et observabilité IA ;
- gouvernance et Responsible AI.

## Itération 12 — Migration

Cas fil rouge : migration progressive d'un SI bancaire on-prem/OpenShift vers Azure.

- assessment ;
- dépendances ;
- 6R/7R ;
- coexistence hybride ;
- migration data ;
- cutover ;
- rollback ;
- décommissionnement.

## Itération 13 — Soutenance architecte

Livrer un dossier complet : contexte, exigences, HLD, sécurité, réseau, résilience, exploitation, coûts, risques, ADR et trajectoire.
