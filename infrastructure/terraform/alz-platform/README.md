# Platform Landing Zone — Terraform + Azure Verified Modules

Cette implémentation représente la **cible entreprise**. Elle nécessite des droits suffisants au niveau du tenant / Management Groups et n'est pas destinée à être lancée aveuglément sur un abonnement personnel.

## Référence

Module : `Azure/avm-ptn-alz/azurerm`

La version utilisée par cette itération est volontairement épinglée dans `main.tf`. Avant une mise à jour, lire les release notes et exécuter `terraform plan`.

## Pré-requis

- Azure CLI authentifié ;
- Terraform compatible avec les contraintes du module ;
- droits de création/administration des Management Groups et Azure Policy ;
- architecture et scopes validés ;
- backend Terraform distant défini avant usage d'équipe.

## Exécution

```bash
az login
az account show
terraform init
terraform fmt -check
terraform validate
terraform plan
```

Ne lancer `terraform apply` que dans un tenant de lab dédié ou après validation de la gouvernance cible.

## Pourquoi AVM

Le projet évite de reconstruire à la main tout le moteur ALZ. Azure Verified Modules fournit un composant maintenu pour déployer la hiérarchie, les assets Azure Policy et les rôles nécessaires. MayaBank conserve ses choix d'architecture et personnalisations dans son propre code.

## Sécurité

Ne jamais committer :

- secrets ;
- credentials de service principal ;
- fichiers `.tfstate` ;
- dossiers `.terraform` ;
- contenu téléchargé `.alzlib`.
