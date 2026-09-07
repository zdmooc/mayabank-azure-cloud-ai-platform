# ADR Catalog — MayaBank Azure

Ce catalogue synthétise les décisions structurantes. Chaque décision pourra être éclatée en ADR détaillé lorsqu'un lab ou un contexte réel exige davantage de justification.

| ADR | Décision | Statut | Alternative principale |
|---|---|---|---|
| ADR-001 | Terraform + Azure Verified Modules comme IaC principal | Accepted | Bicep-only |
| ADR-002 | Application Landing Zones séparées de la Platform Landing Zone | Accepted | subscription unique entreprise |
| ADR-003 | Entra groups + Azure RBAC + PIM pour les humains | Accepted | attributions directes permanentes |
| ADR-004 | Managed Identity / Workload Identity pour workloads et CI/CD | Accepted | client secrets statiques |
| ADR-005 | Hub-Spoke + Private Link comme baseline réseau | Accepted | réseau plat |
| ADR-006 | AKS Standard comme baseline Kubernetes régulée | Accepted | AKS Automatic / self-managed Kubernetes |
| ADR-007 | APIM Premium v2 comme cible API isolée | Accepted | gateway uniquement dans AKS |
| ADR-008 | Service Bus pour messaging métier, Event Hubs pour streaming | Accepted | un broker unique pour tous les flux |
| ADR-009 | Polyglot persistence contrôlée par exigences | Accepted | base unique pour tous les domaines |
| ADR-010 | OpenTelemetry + Azure Monitor comme baseline observabilité | Accepted | logs applicatifs isolés |
| ADR-011 | RTO/RPO par capacité métier avant design DR | Accepted | multi-région systématique |
| ADR-012 | FinOps/GreenOps by design et destruction des labs | Accepted | optimisation après mise en production |
| ADR-013 | Microsoft Foundry + RAG sécurisé pour l'assistant IA | Accepted | accès direct modèle sans gouvernance |
| ADR-014 | Migration par vagues et 7R, pas de big-bang | Accepted | migration technique globale |

## Règles

- Une décision `Accepted` n'est pas éternelle : toute évolution majeure de service, exigence ou coût peut provoquer un nouvel ADR.
- Les alternatives rejetées restent documentées pour éviter de répéter les mêmes débats.
- Une décision de production doit être reliée aux NFR, risques, coût et responsabilités opérationnelles.
- Les versions/SKU exactes sont vérifiées au moment du déploiement, car Azure évolue fréquemment.

## Principaux trade-offs

### Sécurité vs coût
Les Private Endpoints, firewalls, SKUs Premium et la redondance augmentent les coûts. Les retirer uniquement pour économiser est interdit si cela fait passer le risque au-dessus du niveau accepté.

### Résilience vs complexité
Multi-zone et multi-région augmentent la disponibilité mais aussi la complexité DNS, data, runbooks, observabilité et coût. Ils sont appliqués aux workloads qui le justifient.

### Managed services vs portabilité
Les services Azure réduisent l'effort opérationnel mais augmentent l'adhérence à Azure. Les contrats API/events et les standards ouverts sont privilégiés lorsque la portabilité a une valeur réelle.

### Standardisation vs besoins métier
La plateforme fournit des golden paths, mais un workload peut s'en écarter via ADR lorsque ses NFR le justifient.
