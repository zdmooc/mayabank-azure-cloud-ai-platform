# Principes d'architecture

## P01 — Business first

Un service Azure n'est jamais choisi parce qu'il est disponible ou populaire. Le choix découle des exigences métier, des NFR, des risques et du coût total.

## P02 — Secure by design

- moindre privilège ;
- séparation des responsabilités ;
- identité managée plutôt que secrets statiques ;
- chiffrement en transit et au repos ;
- journalisation des accès ;
- intégration de la sécurité au cycle de livraison.

## P03 — Private by default

Les ressources PaaS et plateformes seront privées dès que le contexte le justifie. Toute exposition Internet devra être explicitement documentée avec ses contrôles compensatoires.

## P04 — Zero Trust

Ne jamais considérer un réseau comme intrinsèquement fiable. Authentifier, autoriser et vérifier les identités, appareils et workloads selon le contexte.

## P05 — Everything as Code

- infrastructure ;
- politiques ;
- configurations ;
- pipelines ;
- dashboards et alertes lorsque possible.

Terraform est le langage IaC principal du projet. Bicep est utilisé pour apprendre les implémentations Azure natives et comparer les approches.

## P06 — Reuse verified building blocks

Privilégier les Azure Verified Modules et les patterns officiels plutôt que créer systématiquement des modules propriétaires.

## P07 — Resilience by design

- définir RTO et RPO avant le design HA/DR ;
- identifier les SPOF ;
- préférer l'automatisation de la reprise ;
- tester réellement les scénarios de panne.

## P08 — Observability by design

Un service non observable n'est pas prêt pour la production. Logs, métriques, traces, alertes et corrélation doivent être conçus avec le workload.

## P09 — Automate repeatable operations

Tout acte répétitif et sensible aux erreurs doit être automatisé : provisioning, policy, déploiement, validation, rotation ou destruction lorsque possible.

## P10 — Cost is an architecture requirement

Le coût fait partie des NFR. Toute décision structurante doit considérer :

- coût fixe ;
- coût variable ;
- coût réseau ;
- logs ;
- sauvegardes ;
- HA/DR ;
- coût humain d'exploitation.

## P11 — GreenOps

La surallocation n'est pas une stratégie de résilience. Utiliser sizing, autoscaling, arrêt des environnements non nécessaires, rétention adaptée et services managés lorsque le compromis global est favorable.

## P12 — Data governance

- classification ;
- localisation ;
- rétention ;
- accès ;
- chiffrement ;
- sauvegarde ;
- suppression ;
- traçabilité.

## P13 — Platform / workload separation

Les responsabilités de plateforme et de produit doivent être distinguées. Les équipes workloads consomment des capacités gouvernées plutôt que de reconstruire chacune une plateforme complète.

## P14 — Prefer managed services with explicit trade-offs

Un service managé n'est pas automatiquement meilleur. Le choix doit comparer au minimum : exploitation, coût, portabilité, compétences, sécurité, SLA, verrouillage technologique et contraintes réglementaires.

## P15 — Architecture decisions are versioned

Toute décision structurante doit être capturée par un ADR : contexte, options, décision, conséquences et critères de réévaluation.
