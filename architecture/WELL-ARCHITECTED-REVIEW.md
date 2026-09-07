# Azure Well-Architected Review — MayaBank

Cette revue évalue la cible MayaBank selon les cinq piliers Azure Well-Architected Framework. Elle doit être rejouée après les labs et avant toute transposition vers un contexte réel.

## 1. Reliability

### Forces
- RTO/RPO par criticité métier ;
- Availability Zones lorsque justifiées ;
- stratégie multi-région ciblée ;
- messaging avec retry/DLQ/idempotence ;
- backup + restore tests ;
- runbooks de failover/failback.

### Points à prouver
- RTO/RPO observés ;
- comportement en perte DNS/réseau ;
- dépendances globales ;
- capacité data lors d'un failover.

## 2. Security

### Forces
- Entra ID, groupes, PIM, Azure RBAC ;
- Managed Identity / Workload Identity ;
- Key Vault ;
- Private Link et segmentation réseau ;
- APIM comme point de contrôle API ;
- sécurité RAG/documentaire.

### Points à prouver
- Conditional Access/PIM dans le tenant réel ;
- deny policies ;
- secrets réellement absents des pipelines ;
- threat model mis à jour après chaque changement majeur.

## 3. Cost Optimization

### Forces
- tags et budgets ;
- séparation cible entreprise / labs ;
- destroy systématique ;
- AKS autoscaling ;
- lifecycle data ;
- rétention logs contrôlée.

### Points à prouver
- coût réel par workload ;
- shared-cost allocation ;
- efficacité node pools ;
- coût multi-région ;
- coût par requête IA.

## 4. Operational Excellence

### Forces
- IaC ;
- ADR ;
- OpenTelemetry ;
- SLI/SLO ;
- runbooks ;
- tests de panne ;
- migration par vagues.

### Points à prouver
- CI/CD et quality gates ;
- processus d'upgrade AKS/APIM ;
- ownership des alertes ;
- délai de restauration mesuré ;
- gestion des exceptions Policy.

## 5. Performance Efficiency

### Forces
- scaling horizontal ;
- choix du service data par workload ;
- Event Hubs pour streaming ;
- Service Bus pour commandes/messages métier ;
- cache/edge uniquement lorsque justifié.

### Points à prouver
- tests de charge ;
- capacité APIM ;
- saturation messaging ;
- P95/P99 API ;
- capacité base et partitions ;
- latence RAG.

## Trade-offs explicites

| Décision | Gain | Coût/risque |
|---|---|---|
| Private networking | réduction surface d'exposition | DNS/routage plus complexes |
| Multi-région | meilleure résilience | coût + complexité data/opérations |
| APIM Premium v2 | isolation et capacités entreprise | coût supérieur |
| AKS Standard | contrôle fin | effort plateforme supérieur |
| Managed services | réduction run | dépendance cloud accrue |
| logs détaillés | diagnostic | coût + risque de données sensibles |

## Conclusion actuelle

La conception couvre les cinq piliers. La maturité ne pourra être considérée comme élevée qu'après exécution des labs, mesures de charge/coût, restore tests et revue des risques résiduels.
