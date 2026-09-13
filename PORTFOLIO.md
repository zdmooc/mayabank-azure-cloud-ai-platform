# Portfolio — Architecte Solution Azure MayaBank

## Pitch 60 secondes

MayaBank est un cas d'architecture bancaire Azure de bout en bout. Le dépôt part des exigences métier et NFR, construit une Azure Landing Zone gouvernée, puis décline identité, réseau privé, AKS, API Management, intégration event-driven, data, observabilité, HA/DR, FinOps/GreenOps, IA et migration OpenShift. L'IaC est basé sur Terraform et Azure Verified Modules, avec des labs économiques et des composants coûteux exécutés uniquement à la demande.

## Ce que le dépôt démontre

| Compétence d'architecte | Preuve dans le dépôt |
|---|---|
| cadrage métier/NFR | `docs/01-business-context/` |
| principes / WAF | `docs/02-architecture-principles/`, `architecture/WELL-ARCHITECTED-REVIEW.md` |
| Landing Zone | `docs/03-azure-landing-zone/`, `infrastructure/terraform/alz-platform/` |
| IaC / state | `infrastructure/terraform/bootstrap/` |
| identité / Zero Trust | `docs/04-identity-entra/` |
| réseau hybride / privé | `docs/05-networking/` |
| Kubernetes / AKS | `docs/07-aks/`, `labs/lab-04-aks/` |
| API Management | `docs/08-api-management/`, OpenAPI + policy APIM |
| event-driven | `docs/09-event-driven/` |
| data | `docs/10-data/`, `labs/lab-07-data/` |
| observabilité/SLO | `docs/11-observability/` |
| HA/DR | `docs/12-ha-dr/`, `runbooks/` |
| FinOps/GreenOps | `cost/`, `docs/13-finops-greenops/` |
| AI architecture | `docs/14-ai-platform/` |
| migration OpenShift | `docs/15-migration/` |
| décisions/risques | `architecture/adr/`, `architecture/RISK-REGISTER.md` |

## Démonstration 30 minutes

### 0–5 min — Contexte et NFR

Expliquer :

- banque fictive et criticité paiement ;
- sécurité/private-by-default ;
- disponibilité/RTO/RPO ;
- coût et gouvernance ;
- pourquoi une Landing Zone avant les workloads.

### 5–10 min — Platform Landing Zone

Montrer :

- Management Groups / subscriptions ;
- Azure Policy ;
- séparation Platform/Application Landing Zones ;
- bootstrap et remote state ;
- AVM ;
- GitHub Actions validation.

### 10–15 min — Identité et réseau

Défendre :

- Entra ID, PIM/RBAC ;
- Managed/Workload Identity ;
- Hub-Spoke ;
- ExpressRoute/VPN ;
- Firewall ;
- Private Endpoint + Private DNS.

### 15–20 min — Plateforme paiement

Parcourir :

```text
Front Door/WAF
 -> APIM
 -> AKS Payment API
 -> Service Bus
 -> Payment Processor
 -> Data
```

Puis montrer : OpenAPI, correlation ID, idempotency key, retry, DLQ, outbox et traces.

### 20–25 min — Résilience et exploitation

Présenter :

- SLO/SLI ;
- métriques/logs/traces ;
- RTO/RPO comme exigences métier ;
- multi-zone/multi-région ;
- runbook failover ;
- tests de reprise.

### 25–30 min — Arbitrages

Choisir trois ADR et expliquer :

- pourquoi ce choix ;
- alternative rejetée ;
- impact coût/sécurité/résilience ;
- condition de réévaluation.

Terminer par AI Landing Zone et matrice OpenShift -> ARO/AKS/PaaS pour montrer la capacité à étendre la plateforme sans casser la gouvernance.

## Questions difficiles à savoir défendre

1. Pourquoi AKS plutôt qu'ARO ?
2. Pourquoi Hub-Spoke plutôt que Virtual WAN dans ce scénario ?
3. Comment un pod lit-il Key Vault sans secret ?
4. Pourquoi un timeout de `POST /payments` ne permet-il pas de rejouer aveuglément ?
5. Quelle différence entre HA zonale et PRA régional ?
6. Quand APIM Premium est-il justifié malgré son coût ?
7. Comment empêcher une équipe application de contourner les policies de plateforme ?
8. Comment éviter un state Terraform monolithique ?
9. Comment mesurer un RPO réel pendant un exercice ?
10. Comment contrôler le coût d'une plateforme IA ?

## Statut de preuve

### Validé automatiquement dans GitHub Actions

- Terraform bootstrap ;
- ALZ AVM root ;
- Identity lab ;
- Network lab ;
- Data/Storage lab ;
- Observability/Log Analytics lab.

Les quality gates exécutent `terraform fmt`, `terraform init -backend=false` et `terraform validate`.

### À exécuter dans Azure pour preuve runtime

- `terraform plan/apply` authentifié de la Landing Zone dans un tenant approprié ;
- lab AKS ;
- APIM déployé ;
- messaging et tests retry/DLQ ;
- exercice HA/DR ;
- Foundry/RAG selon quotas.

Le dépôt ne marque jamais ces éléments « exécutés » sans sorties, captures ou résultats de tests conservés dans `evidence/`.

## Règle de portfolio

Le but n'est plus d'ajouter des services Azure. Chaque nouvelle modification doit désormais répondre à l'un des critères suivants :

- corriger une erreur ;
- fournir une preuve d'exécution ;
- améliorer un ADR ;
- ajouter un test ;
- mettre à jour une référence devenue obsolète ;
- répondre à une exigence réelle d'une mission/entretien.
