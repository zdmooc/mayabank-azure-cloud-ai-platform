# MayaBank — FinOps & GreenOps Guardrails

## Objectif

Intégrer coût, utilisation et sobriété dans les décisions d'architecture Azure sans sacrifier sécurité, résilience ou performance requise.

## Principes

1. chaque ressource a un owner, un environnement et un centre de coût ;
2. budgets/alertes sont définis avant les workloads coûteux ;
3. sizing basé sur mesures réelles plutôt que marges arbitraires ;
4. les environnements non-prod sont arrêtés/détruits lorsqu'ils ne servent pas ;
5. la rétention logs/data est justifiée ;
6. les services premium sont choisis pour une exigence, pas par défaut ;
7. coût et carbone sont des NFR à arbitrer avec disponibilité/sécurité.

## Tags minimaux

```text
Application
Environment
Owner
CostCenter
Criticality
DataClassification
ManagedBy
```

## Guardrails par domaine

| Domaine | Contrôle |
|---|---|
| AKS | autoscaling, requests/limits, pools adaptés, clusters de lab détruits |
| APIM | tier dimensionné au scénario ; Premium uniquement si besoin |
| Logs | rétention/ingestion contrôlées, pas de logs bavards inutiles |
| Storage | lifecycle hot/cool/archive/delete selon valeur métier |
| Data | tier/compute adaptés, scale/down lorsque service le permet |
| AI | quotas, rate limiting, choix du modèle selon qualité/coût |
| Réseau | Firewall/Bastion coûteux activés dans le lab uniquement lorsque testés |
| DR | coût du standby explicite dans l'ADR |

## Routine FinOps

Hebdomadaire/mensuelle selon environnement :

- coût par subscription/resource group/workload ;
- ressources sans owner ;
- ressources inutilisées ;
- surdimensionnement ;
- disques/IP orphelins ;
- croissance des logs ;
- dépenses AI ;
- écarts budget/forecast ;
- ressources de lab oubliées.

## GreenOps

Le dépôt applique les mêmes leviers de sobriété :

- réduire les ressources inutiles ;
- augmenter le taux d'utilisation utile ;
- éviter la sur-réplication sans exigence ;
- privilégier services managés/scale-to-zero lorsque cela répond au besoin ;
- réduire stockage et rétention inutiles ;
- mesurer avant/après une optimisation.

Une décision GreenOps n'est pas acceptable si elle dégrade un RTO/RPO ou une exigence sécurité sans arbitrage explicite.

## Architecture Decision Record

Toute décision significative de coût documente :

```text
besoin
options
coût relatif
impact fiabilité
impact sécurité
impact performance
impact opérationnel
impact sobriété
choix
conditions de réévaluation
```

## Labs

Avant un lab payant : estimation, budget et commande de destruction. Après le lab : preuve que les ressources facturées ont été supprimées et contrôle Cost Management ultérieur.
