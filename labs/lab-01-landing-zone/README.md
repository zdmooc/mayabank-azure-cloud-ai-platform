# LAB 01 — Landing Zone Governance

## But

Pratiquer une partie des garde-fous d'une Landing Zone **sans déployer AKS, Firewall, APIM ou autre ressource coûteuse**.

Ce lab travaille au scope d'une subscription existante. Il crée :

- un Resource Group de lab correctement taggé ;
- une Azure Policy personnalisée exigeant le tag `Environment` ;
- une assignation de cette policy à la subscription.

## Prérequis

```bash
az login
az account list -o table
az account set --subscription "<SUBSCRIPTION_ID>"
az account show -o table
terraform version
```

Le compte doit avoir les droits permettant de créer une définition et une assignation Azure Policy au niveau subscription.

## Exécution

```bash
cd labs/lab-01-landing-zone/terraform
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply
```

## Validation

```bash
az group show -n rg-mbk-platform-lab -o table

az policy definition list \
  --query "[?name=='mbk-require-environment-tag'].{name:name,displayName:displayName}" \
  -o table

az policy assignment list \
  --query "[?name=='mbk-require-environment-tag'].{name:name,scope:scope}" \
  -o table
```

### Test négatif

Après propagation de la policy, tester une ressource taggable sans le tag obligatoire dans le RG de lab. L'opération doit être rejetée. Ne pas utiliser une ressource payante uniquement pour ce test : un `terraform plan` ou une ressource gratuite/éphémère appropriée est préférable.

## Ce que le lab démontre

```text
Architecture
   ↓
Guardrail
   ↓
Policy as Code
   ↓
Terraform
   ↓
Validation
   ↓
Destruction
```

## Destruction

```bash
terraform destroy
```

Puis contrôler :

```bash
az group exists -n rg-mbk-platform-lab
```

Résultat attendu : `false`.

## Coût

Le lab n'instancie volontairement aucun compute, cluster, firewall, gateway ou base de données. Toujours vérifier le portail Cost Management malgré cela.

## Limite pédagogique

Ce lab ne crée pas la hiérarchie complète des Management Groups. La vraie cible entreprise est documentée dans `infrastructure/terraform/alz-platform` et nécessite des privilèges tenant adaptés.
