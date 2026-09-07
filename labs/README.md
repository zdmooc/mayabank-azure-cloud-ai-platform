# Labs — standard d'exécution

Chaque lab doit être **reproductible, vérifiable et destructible**. La conception d'un lab et son exécution sont deux statuts différents.

Le détail est centralisé dans [`LAB-CATALOG.md`](LAB-CATALOG.md).

## Structure recommandée

```text
lab-xx-topic/
├── README.md
├── terraform/          # lorsque pertinent
├── tests/              # ajouté au moment de l'exécution
└── expected-results/   # preuves expurgées
```

## Règles de sécurité

- aucun secret dans Git ;
- préférer Managed Identity/Workload Identity ;
- variables sensibles hors dépôt ;
- ne jamais publier tokens, IDs confidentiels ou captures sensibles ;
- tests négatifs obligatoires pour les contrôles de sécurité.

## Règles de coût

Avant `apply` :
1. identifier les ressources facturables ;
2. vérifier le SKU ;
3. préparer le destroy ;
4. limiter la durée ;
5. éviter Firewall/Bastion/APIM Premium v2/AKS multi-région permanents pour les exercices.

Après `destroy` : vérifier disques, IP, Load Balancers, node resource groups, databases, logs et autres ressources orphelines.

## Validation minimale

Un lab n'est pas réussi simplement parce que `terraform apply` fonctionne. Il faut tester :
- fonction attendue ;
- refus attendu ;
- identité/RBAC ;
- connectivité ;
- logs/métriques ;
- panne/recovery lorsque pertinent ;
- coût observé ;
- destruction complète.

## Ordre

1. `lab-01-landing-zone`
2. `lab-02-identity`
3. `lab-03-network`
4. `lab-04-aks`
5. `lab-05-apim`
6. `lab-06-event-driven`
7. `lab-07-data`
8. `lab-08-observability`
9. `lab-09-ha-dr`
10. `lab-10-finops-greenops`
11. `lab-11-ai`
12. `lab-12-migration`
13. `lab-13-soutenance`

## Terraform déjà prêt

- LAB 01 : Policy / Landing Zone simplifiée ;
- LAB 02 : Managed Identity + Key Vault + RBAC ;
- LAB 03 : Hub-Spoke + NSG + Private DNS ;
- LAB 07 : Storage security baseline ;
- LAB 08 : Log Analytics Workspace.

Les autres labs sont volontairement **à la demande** quand ils impliquent du compute, des SKUs premium, des quotas IA ou des architectures multi-région. Leurs README définissent la procédure, les tests et le destroy.
