# LAB 08 — Observability baseline

## Objectif

Créer un Log Analytics Workspace temporaire, contrôler la rétention et préparer l'intégration Monitor/Application Insights/OpenTelemetry.

## Déploiement

```bash
cd labs/lab-08-observability/terraform
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply
```

## Vérifications

```bash
az monitor log-analytics workspace show -g rg-mbk-observability-lab -n law-mbk-lab
```

Puis, lorsqu'un workload de lab est disponible :
- envoyer logs/traces ;
- créer au moins trois requêtes KQL ;
- vérifier le correlation ID/traceparent ;
- déclencher une alerte ;
- confirmer que les logs ne contiennent aucun secret/token/donnée bancaire sensible.

## Coût

Le workspace lui-même n'est pas le sujet principal du coût : surveiller surtout ingestion, rétention et fonctionnalités supplémentaires. Ne pas envoyer des volumes inutiles pendant les labs.

## Destruction

```bash
terraform destroy
```
