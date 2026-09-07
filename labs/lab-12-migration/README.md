# LAB 12 — Migration OpenShift vers AKS

## Objectif

Migrer un microservice de démonstration sans big-bang et comparer objectivement les dépendances OpenShift/Azure.

## Source

Le service doit pouvoir fonctionner localement/OpenShift avec :
- image OCI ;
- configuration externalisée ;
- health/readiness endpoints ;
- logs structurés ;
- aucune dépendance implicite à un filesystem local.

## Cible AKS

- Namespace dédié ;
- ServiceAccount + Workload Identity si accès Azure ;
- Deployment ;
- Service/Ingress selon lab ;
- requests/limits ;
- PDB ;
- autoscaling si pertinent ;
- télémétrie.

## Étapes

1. baseline fonctionnelle sur OpenShift/local ;
2. inventory des dépendances ;
3. classification 7R ;
4. déploiement AKS ;
5. tests fonctionnels identiques ;
6. tests performance simples ;
7. observabilité ;
8. simulation cutover ;
9. rollback vers source ;
10. nouveau cutover ;
11. destroy Azure.

## Tableau de comparaison

Comparer : Route/Ingress, RBAC, secrets/identités, stockage, registry, GitOps, policies, logging, autoscaling, upgrade et runbook.

## Critère de réussite

Le service doit fournir le même contrat fonctionnel et les NFR décidés ; la migration n'est pas réussie simplement parce que le pod est `Running`.
