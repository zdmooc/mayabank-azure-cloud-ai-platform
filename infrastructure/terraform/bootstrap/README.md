# Terraform bootstrap — remote state

Ce root module crée uniquement les ressources nécessaires au backend Terraform partagé : Resource Group, Storage Account et container Blob.

## Pourquoi un bootstrap séparé

Le backend distant ne peut pas être utilisé avant d'exister. Ce module s'exécute donc une première fois avec un state local, puis les autres roots (`alz-platform`, `connectivity`, etc.) utilisent le backend Azure Storage.

## Prérequis

- Azure CLI authentifiée ou identité CI via OIDC ;
- Terraform >= 1.12 ;
- permissions suffisantes sur la subscription de plateforme.

## Exécution

```bash
terraform init
terraform fmt -check
terraform validate
terraform plan \
  -var="storage_account_name=<nom-globalement-unique>"
terraform apply \
  -var="storage_account_name=<nom-globalement-unique>"
```

Conserver ensuite les valeurs de sortie pour configurer les backends des roots suivants.

## Sécurité

- container privé ;
- TLS 1.2 minimum ;
- accès anonyme interdit ;
- Shared Key désactivée ;
- versioning et rétention activés ;
- authentification backend attendue via Microsoft Entra ID (`use_azuread_auth = true`).

Le bootstrap pédagogique conserve l'accès réseau public au Storage Account afin de rester exécutable depuis un poste local. La cible entreprise doit ensuite restreindre le réseau (Private Endpoint / règles réseau / runner privé selon le modèle d'exploitation retenu).

## Destruction

Ne pas détruire ce module tant que des states Terraform actifs utilisent le Storage Account. Pour un lab isolé uniquement :

```bash
terraform destroy \
  -var="storage_account_name=<nom-globalement-unique>"
```
