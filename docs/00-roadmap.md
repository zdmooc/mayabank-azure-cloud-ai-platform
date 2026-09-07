# Roadmap — Architecte Solution Azure

## Statut global

**Conception des itérations 0 à 13 : terminée.**

Le dépôt distingue deux états :
- `✅ conception` : architecture, décisions, alternatives, risques, lab et critères sont documentés ;
- `🧪 exécution` : le lab doit encore être exécuté sur un abonnement Azure et fournir ses preuves.

## Definition of Done

Une itération de **conception** doit contenir :
- exigences/hypothèses ;
- architecture ;
- décisions/alternatives ;
- ADR ou entrée au catalogue ;
- IaC ou justification explicite lorsque le service coûteux n'est déployé qu'à la demande ;
- validation positive/négative ;
- coût/risque ;
- destroy ;
- questions de soutenance.

Un lab n'est **exécuté** qu'après conservation des sorties de test et confirmation du destroy.

## Parcours

| # | Itération | Conception | Exécution |
|---:|---|---|---|
| 0 | Fondations | ✅ | ✅ |
| 1 | Azure Landing Zone | ✅ | code Terraform prêt |
| 2 | Identity & Security | ✅ | code Terraform prêt |
| 3 | Network Foundation | ✅ | code Terraform prêt |
| 4 | AKS | ✅ | 🧪 à la demande |
| 5 | API Management | ✅ | 🧪 à la demande |
| 6 | Event Driven Architecture | ✅ | 🧪 à la demande |
| 7 | Data | ✅ | code Terraform prêt |
| 8 | Observability | ✅ | code Terraform prêt |
| 9 | HA / DR | ✅ | 🧪 exercices à exécuter |
| 10 | FinOps / GreenOps | ✅ | 🧪 routine à exécuter |
| 11 | Microsoft Foundry / AI | ✅ | 🧪 selon quota/modèle |
| 12 | Migration | ✅ | 🧪 pilote OpenShift -> AKS |
| 13 | Soutenance | ✅ | scénario prêt |

## 0 — Fondations ✅

Contexte MayaBank, NFR, principes, structure documentaire, ADR template, stratégie IaC et stratégie de labs.

## 1 — Azure Landing Zone ✅

Platform/Application Landing Zones, Management Groups, subscriptions, Azure Policy, naming/tagging, AVM Terraform et LAB 01.

## 2 — Identity & Security ✅

Entra ID, groupes, Azure RBAC, PIM/JIT, Managed Identities, Workload Identity, Key Vault, Defender for Cloud et séparation des responsabilités.

Lab : `labs/lab-02-identity`.

## 3 — Network Foundation ✅

Hub-Spoke, Firewall cible, Private DNS, Private Link, Application Gateway/Front Door, ExpressRoute/VPN et plan IP.

Lab : `labs/lab-03-network`.

## 4 — AKS ✅

AKS Standard baseline, cluster privé, node pools, Workload Identity, CNI, ingress, PDB, autoscaling, network policy, ACR, observabilité et multi-région.

Lab : `labs/lab-04-aks`.

## 5 — API Management ✅

APIM Premium v2 cible isolée, OAuth/OIDC, JWT, mTLS, rate limiting, policies, versioning, Private networking et diagnostics.

Lab : `labs/lab-05-apim`.

## 6 — Event Driven Architecture ✅

Service Bus, Event Hubs, Event Grid, Outbox, idempotence, retry, DLQ, schema versioning, replay et corrélation.

Lab : `labs/lab-06-event-driven`.

## 7 — Data ✅

Azure SQL/PostgreSQL/Cosmos/Storage selon besoin, classification, chiffrement, backup/restore, Private Endpoint, lifecycle et cohérence.

Lab : `labs/lab-07-data`.

## 8 — Observability ✅

Azure Monitor, Log Analytics, Application Insights, OpenTelemetry, SLI/SLO, KQL, alertes, corrélation, rétention et coût.

Lab : `labs/lab-08-observability`.

## 9 — HA / DR ✅

Zones, régions, RTO/RPO, backup/restore, failover/failback, runbooks et exercices chronométrés.

Lab : `labs/lab-09-ha-dr`.

## 10 — FinOps / GreenOps ✅

Tags, budgets, rightsizing, scaling, ressources orphelines, rétention et leviers de sobriété mesurables.

Lab : `labs/lab-10-finops-greenops`.

## 11 — Microsoft Foundry / AI ✅

Microsoft Foundry, Azure OpenAI/Models, AI Search, RAG, authz documentaire, sécurité, évaluation, observabilité IA et AI Gateway.

Lab : `labs/lab-11-ai`.

## 12 — Migration ✅

Assessment, 7R, dépendances, coexistence hybride, migration par vagues, cutover, rollback et décommissionnement.

Lab : `labs/lab-12-migration`.

## 13 — Soutenance Architecte ✅

Dossier d'architecture, synthèse HLD, 15 décisions structurantes, risques, questions d'entretien et challenge 30+30 minutes.

Lab : `labs/lab-13-soutenance`.

## Phase suivante — preuves terrain

Exécuter les labs progressivement, renseigner les résultats, mesurer le coût, conserver les erreurs et faire évoluer les ADR. La valeur pédagogique vient désormais de la **preuve par exécution**, pas de l'ajout de nouvelles pages théoriques.
