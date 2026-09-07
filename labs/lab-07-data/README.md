# LAB 07 — Data / Storage baseline

## Objectif

Travailler une baseline data peu coûteuse avec Azure Storage : sécurité, identité, TLS, accès public, lifecycle et tags.

## Déploiement

```bash
cd labs/lab-07-data/terraform
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply
```

## Vérifications

```bash
az storage account show -g rg-mbk-data-lab -n "$(terraform output -raw storage_account_name)"
az storage account blob-service-properties show -g rg-mbk-data-lab -n "$(terraform output -raw storage_account_name)"
```

Contrôler :
- HTTPS only ;
- TLS minimum ;
- accès public de blobs interdit ;
- authentification Entra privilégiée ;
- lifecycle défini ;
- tags présents.

## Extension

Ajouter ultérieurement Private Endpoint + Private DNS lors de l'exercice réseau privé. Ne pas créer une base SQL/PostgreSQL/Cosmos uniquement pour cocher une case : la déployer lorsqu'un comportement spécifique doit être testé.

## Destruction

```bash
terraform destroy
```
