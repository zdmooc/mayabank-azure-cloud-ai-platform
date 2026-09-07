# ADR-002 — Azure Landing Zone Governance Model

- **Status:** Accepted
- **Date:** 2026-09-07
- **Decision owners:** MayaBank Architecture / Cloud Platform

## Context

MayaBank doit pouvoir héberger plusieurs domaines métiers et environnements Azure sans perdre le contrôle sur la sécurité, les coûts, la conformité et l'exploitation.

Une organisation uniquement par Resource Groups ne fournit pas un niveau de gouvernance suffisant à l'échelle entreprise. À l'inverse, une hiérarchie de Management Groups calquée sur l'organigramme deviendrait difficile à maintenir et créerait un couplage inutile avec les changements d'organisation.

## Decision

Adopter une architecture Azure Landing Zone composée de :

1. une **Platform Landing Zone** centrale ;
2. des **Application Landing Zones** par workload ;
3. une hiérarchie de Management Groups fondée principalement sur les besoins de gouvernance et d'exploitation ;
4. une séparation des subscriptions PROD/NON-PROD pour les workloads critiques ;
5. Azure Policy au niveau Management Group pour les garde-fous héritables ;
6. RBAC délégué au niveau subscription/Resource Group pour les équipes workload ;
7. Terraform + Azure Verified Modules pour l'implémentation de la Platform Landing Zone.

## Consequences positives

- gouvernance cohérente à grande échelle ;
- séparation des responsabilités plateforme/workload ;
- isolation plus claire des environnements critiques ;
- Policy as Code et traçabilité Git ;
- meilleure imputation des coûts ;
- facilité d'onboarding de nouveaux workloads.

## Trade-offs

- nécessite une gouvernance tenant robuste ;
- complexité supérieure à une subscription unique ;
- demande une gestion précise des droits Management Group ;
- les policies mal conçues peuvent bloquer les équipes ;
- la structure doit rester suffisamment stable dans le temps.

## Alternatives rejetées

### Une seule subscription pour toute la banque

Rejetée pour la cible entreprise : isolation, gouvernance, coûts et blast radius insuffisamment maîtrisés.

### Une hiérarchie calquée entièrement sur l'organigramme

Rejetée : les structures organisationnelles changent plus vite que les besoins de gouvernance cloud.

### Construire toute l'ALZ à la main

Rejetée comme stratégie principale : maintenance et dette technique inutile alors que Microsoft fournit Azure Verified Modules. Les personnalisations MayaBank restent possibles autour de cette fondation.

## Validation

Cette décision sera réévaluée si :

- le modèle de tenant change ;
- une exigence de souveraineté impose un cloisonnement différent ;
- une contrainte réglementaire impose de nouveaux périmètres ;
- le modèle multi-cloud nécessite une abstraction supplémentaire.
