# FinOps / GreenOps — garde-fous du projet

## Objectif

Maintenir les labs compatibles avec un budget d'apprentissage limité et intégrer le coût comme une exigence d'architecture.

## Avant tout déploiement

Documenter :

- région ;
- SKU/tier ;
- durée prévue ;
- coût fixe éventuel ;
- coût lié au trafic ;
- stockage et rétention ;
- logs ;
- sauvegardes ;
- ressources dépendantes ;
- méthode de destruction.

## Règles

1. Ne pas maintenir en permanence un composant coûteux uniquement pour démonstration.
2. Déployer à la demande et détruire après validation.
3. Utiliser tags et budgets dès les premières itérations.
4. Limiter la rétention des logs des environnements de lab.
5. Éviter le surdimensionnement des VM, node pools et bases.
6. Tester l'autoscaling plutôt que provisionner le pic théorique en permanence.
7. Documenter les coûts cachés : egress, NAT, Firewall, logs, Private Link, sauvegardes.
8. Séparer ce qui est requis en production de ce qui suffit pour apprendre.

## Tags minimums

```text
application = mayabank
workload    = <nom-workload>
environment = lab|dev|test|prod
owner       = architecture
cost-center = training
managed-by  = terraform
expiry      = YYYY-MM-DD
```

## Questions FinOps d'architecte

- Quel composant domine le coût ?
- Le coût est-il fixe ou proportionnel au trafic ?
- Quel est le coût de la HA ?
- Quel est le coût du DR ?
- Combien coûtent les logs ?
- Combien coûte le trafic inter-zone/inter-région ?
- Le dimensionnement repose-t-il sur des mesures ?
- Peut-on arrêter ou réduire les environnements hors usage ?
- Quelle métrique métier permet d'exprimer le coût : transaction, API call, client, Go, événement ?

## GreenOps

Le projet cherchera à relier coût et sobriété :

- réduire les ressources inutilisées ;
- maîtriser la rétention ;
- utiliser l'élasticité ;
- éviter les copies de données inutiles ;
- choisir la région et la résilience selon les vraies exigences ;
- mesurer avant d'optimiser.
