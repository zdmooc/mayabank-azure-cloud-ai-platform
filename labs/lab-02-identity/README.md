# LAB 02 — Identity / Managed Identity / Key Vault

## Objectif

Créer une identité managée et un coffre Key Vault piloté par RBAC sans secret statique dans Git.

## Prérequis

```bash
az login
az account show
terraform version
```

Le compte doit pouvoir créer Resource Groups, Managed Identities, Key Vaults et role assignments.

## Déploiement

```bash
cd labs/lab-02-identity/terraform
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply
```

## Validations

```bash
az identity show -g rg-mbk-identity-lab -n id-mbk-lab
az keyvault show -g rg-mbk-identity-lab -n "$(terraform output -raw key_vault_name)"
az role assignment list --assignee "$(terraform output -raw managed_identity_principal_id)" -o table
```

Vérifier qu'aucun secret, mot de passe ou client secret n'est présent dans le dépôt.

## Test négatif

Une identité ou un utilisateur sans rôle Key Vault ne doit pas pouvoir lire les secrets. Le lab ne crée pas de VM juste pour effectuer ce test ; réutiliser un workload autorisé lors d'un lab ultérieur.

## Coût

Très faible : Managed Identity et Resource Group ne génèrent pas de compute. Key Vault facture principalement les opérations selon le tarif applicable.

## Destruction

```bash
terraform destroy
```

Key Vault conserve des mécanismes de soft-delete ; ne jamais désactiver des protections de production uniquement pour simplifier un lab.
