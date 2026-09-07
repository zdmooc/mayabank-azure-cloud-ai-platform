# LAB Catalog — MayaBank Azure

Ce fichier distingue clairement **conception terminée** et **exécution Azure à réaliser**. Aucun lab n'est considéré comme exécuté tant que les commandes et preuves n'ont pas été produites depuis un abonnement Azure authentifié.

| Lab | Domaine | Mode | Coût relatif | État |
|---|---|---|---|---|
| 01 | Landing Zone / Policy | Azure | très faible | code prêt |
| 02 | Identity / Key Vault | Azure | très faible | spécification prête |
| 03 | Hub-Spoke / NSG / DNS | Azure | faible | spécification prête |
| 04 | AKS | Azure à la demande | moyen | spécification prête |
| 05 | API Management | Azure à la demande | variable/élevé selon SKU | spécification prête |
| 06 | Service Bus / Event Hubs | Azure à la demande | faible à moyen | spécification prête |
| 07 | Data / Storage | Azure | très faible | spécification prête |
| 08 | Observability | Azure | faible | spécification prête |
| 09 | HA/DR | mixte | variable | scénario prêt |
| 10 | FinOps/GreenOps | Azure | très faible | scénario prêt |
| 11 | Microsoft Foundry / RAG | Azure selon quota | variable | scénario prêt |
| 12 | Migration OpenShift -> AKS | local + Azure | moyen | scénario prêt |
| 13 | Soutenance | local | nul | trame prête |

## LAB 02 — Identity

**Créer** : Resource Group, User Assigned Managed Identity, Key Vault, rôle minimal.

**Tester** :
- identité autorisée -> accès attendu ;
- identité non autorisée -> accès refusé ;
- aucune clé/secrète dans Git ;
- audit des role assignments.

**Détruire** : toutes les ressources du RG de lab. Attention au comportement soft-delete de Key Vault.

## LAB 03 — Network

**Créer** : hub VNet, deux spokes, subnets, NSG, peering et Private DNS Zone de démonstration.

**Ne pas créer en permanence** : Azure Firewall, Bastion, ExpressRoute.

**Tester** : peerings, effective routes, NSG, absence de CIDR overlap, résolution DNS de test.

## LAB 04 — AKS

**Créer uniquement pendant la session** : AKS avec petit node pool, Entra integration, OIDC/Workload Identity.

**Déployer** : application `hello-bank`, requests/limits, 2 replicas, PDB, HPA.

**Tester** : suppression pod, scaling, identité, logs, refus d'un accès interdit.

**Destroy immédiat** après les tests.

## LAB 05 — APIM

**Objectif** : importer une OpenAPI de paiement fictive et appliquer policies.

**Tests** : token valide/invalide, rate limit, correlation ID, backend indisponible, logs sans données sensibles.

**Cible Premium v2** : documentée, mais ne pas laisser cette SKU active pour un simple lab.

## LAB 06 — Event Driven

**Scénario** : `PaymentRequested` -> consommateur -> échec -> retry -> DLQ -> replay.

**Critère majeur** : le même `paymentId` ne doit jamais provoquer deux effets métier.

**Comparer** : Service Bus vs Event Hubs sur ordering, replay, throughput, rétention et modèle consommateur.

## LAB 07 — Data

**Base économique** : Storage Account/Blob.

**Tester** : RBAC, lifecycle, accès anonyme désactivé, rétention/versioning selon scénario, suppression.

**Extension ponctuelle** : Azure SQL/PostgreSQL/Cosmos seulement quand leur comportement doit réellement être expérimenté.

## LAB 08 — Observability

**Créer** : Log Analytics Workspace et télémétrie d'un workload existant.

**Produire** : trois requêtes KQL minimum, une alerte, un dashboard ou workbook simple et une preuve de corrélation.

**Contrôle coût** : volume et rétention.

## LAB 09 — HA/DR

**Exercices** : pod failure, backend failure, restore d'une donnée, runbook de perte régionale.

**Mesurer** : RTO/RPO observés au lieu de seulement recopier les objectifs.

## LAB 10 — FinOps/GreenOps

Avant et après chaque lab :
1. inventorier les ressources ;
2. contrôler tags ;
3. relever coût ;
4. détecter idle/orphelins ;
5. destroy ;
6. vérifier qu'il ne reste aucune ressource payante du lab.

## LAB 11 — Microsoft Foundry / RAG

**Corpus** : documents MayaBank fictifs uniquement.

**Tester** : question avec réponse présente, question absente, document non autorisé, prompt injection, citation, latence et coût.

Si quota/modèle indisponible : utiliser un mock sans prétendre que le lab Azure a été exécuté.

## LAB 12 — Migration

Déployer le même microservice d'abord local/OpenShift puis AKS.

Comparer : configuration, identité, ingress, secrets, observabilité, stockage et rollback.

## LAB 13 — Soutenance

Présenter en 30 minutes : contexte, NFR, HLD, sécurité, réseau, AKS/APIM/events/data, observabilité, DR, coût, IA et migration.

Le jury doit challenger au moins cinq ADR et deux scénarios de panne.

## Preuves à conserver après exécution

Dans chaque lab :
- `expected-results/README.md` ;
- sorties expurgées ;
- captures non sensibles si utiles ;
- coût observé ;
- résultat tests positifs/négatifs ;
- date d'exécution ;
- versions Azure/Terraform ;
- confirmation du destroy.
