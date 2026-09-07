# Labs — standard d'exécution

Chaque lab doit être **reproductible, vérifiable et destructible**.

## Structure obligatoire

```text
lab-xx-topic/
├── README.md
├── architecture.md
├── terraform/
├── tests/
└── expected-results/
```

## README de chaque lab

Le README doit contenir :

1. objectif pédagogique ;
2. compétences d'architecte travaillées ;
3. prérequis ;
4. architecture ;
5. estimation du coût ;
6. commandes de déploiement ;
7. tests de validation ;
8. tests négatifs ;
9. éléments à observer dans Azure ;
10. commandes de destruction ;
11. questions d'entretien associées.

## Règles de sécurité

- aucun secret dans Git ;
- aucune clé ou valeur sensible dans les exemples ;
- préférer Managed Identity/Workload Identity ;
- utiliser des fichiers `.example` pour les variables ;
- nettoyer les ressources après les exercices.

## Règles de coût

Avant `apply` :

- identifier les ressources payantes ;
- vérifier si un SKU inférieur suffit pour le lab ;
- éviter les services qui facturent fortement même sans trafic ;
- définir la durée du test ;
- préparer `terraform destroy`.

## Validation minimale

Un lab n'est pas considéré terminé si seule la création des ressources fonctionne. Il faut aussi vérifier :

- connectivité attendue ;
- refus des flux interdits ;
- identité et autorisations ;
- logs et métriques ;
- comportement après erreur ;
- destruction complète.

## Ordre des labs

1. Landing Zone
2. Identity
3. Network
4. AKS
5. API Management
6. Event Driven
7. Data
8. Observability
9. HA/DR
10. AI
