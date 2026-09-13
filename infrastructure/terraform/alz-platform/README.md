# Platform Landing Zone — Terraform + Azure Verified Modules

Cette implémentation représente la **cible entreprise** de la fondation Azure MayaBank. Elle nécessite des droits suffisants au niveau tenant / Management Groups et ne doit pas être appliquée aveuglément sur un abonnement personnel.

## Références

- module : `Azure/avm-ptn-alz/azurerm` ;
- version utilisée : `0.21.0` ;
- provider ALZ : `~> 0.21` ;
- provider AzAPI : `~> 2.12` ;
- bibliothèque ALZ : `platform/alz` `2026.04.2`.

Les versions sont volontairement épinglées. Toute montée de version doit être précédée de la lecture des release notes et d'un `terraform plan` revu.

## Pré-requis

- Azure CLI authentifiée ou identité CI fédérée ;
- Terraform >= 1.12 et < 2.0 ;
- droits adaptés sur les Management Groups et Azure Policy ;
- architecture et scopes validés ;
- backend Terraform distant créé via `../bootstrap/` pour un usage partagé.

## Backend distant

Les fichiers `backend.tf.example` et `backend.hcl.example` servent de modèle.

Exemple :

```bash
cp backend.tf.example backend.tf
cp backend.hcl.example backend.hcl
terraform init -backend-config=backend.hcl
```

Ne jamais committer un fichier backend contenant une donnée sensible. Le backend MayaBank doit utiliser l'authentification Microsoft Entra ID (`use_azuread_auth = true`).

## Validation sans accès Azure

```bash
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
```

Ces contrôles sont aussi exécutés par GitHub Actions.

## Plan / Apply

Après authentification Azure et validation du scope :

```bash
terraform init -backend-config=backend.hcl
terraform plan -out=tfplan
terraform apply tfplan
```

Un `apply` n'est autorisé que dans un tenant de lab dédié ou après validation formelle de la gouvernance cible.

## Pourquoi AVM

MayaBank ne reconstruit pas le moteur Azure Landing Zones. Azure Verified Modules fournit le composant maintenu pour déployer la hiérarchie, les assets Azure Policy et les rôles nécessaires. Le dépôt conserve ses propres choix : architecture, scopes, exceptions, décisions ADR et exigences métier.

## Sécurité

Ne jamais committer :

- secrets ;
- credentials de service principal ;
- fichiers `.tfstate` ;
- dossiers `.terraform` ;
- plans contenant des données sensibles ;
- contenu téléchargé `.alzlib`.

La cible GitHub Actions utilise OIDC / Workload Identity Federation plutôt qu'un secret de Service Principal longue durée.

## Limites actuelles

Ce root module couvre la fondation ALZ : Management Groups, Policy et rôles. Les composants `connectivity`, `identity`, `management` et `security` sont volontairement séparés et sont traités dans les itérations suivantes afin d'obtenir des states et responsabilités indépendants.
