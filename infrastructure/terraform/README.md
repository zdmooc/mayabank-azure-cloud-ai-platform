# Terraform — stratégie IaC

## Objectif

Terraform est l'IaC principal de MayaBank. Le dépôt privilégie l'assemblage de briques Microsoft maintenues et d'**Azure Verified Modules (AVM)** plutôt qu'une bibliothèque maison difficile à maintenir.

## Principes

- préférer les **Azure Verified Modules (AVM)** lorsqu'ils couvrent le besoin ;
- versions de providers et modules explicitement contraintes ;
- aucun secret dans le code ou les variables versionnées ;
- remote state Azure Storage pour les roots partagés ;
- authentification CI/CD par OIDC / Workload Identity Federation ;
- séparation claire entre plateforme et workloads ;
- un state par domaine afin de réduire le blast radius ;
- fichiers de variables par environnement sans données sensibles ;
- `terraform fmt`, `validate` et `plan` avant `apply` ;
- `destroy` documenté pour chaque lab ;
- éviter les ressources coûteuses permanentes pour les exercices.

## Structure

```text
infrastructure/terraform/
├── bootstrap/              # création initiale du remote state
├── alz-platform/           # Management Groups, Policy, rôles via AVM ALZ
├── platform/               # roots spécialisés ajoutés par itération
│   ├── connectivity/
│   ├── identity/
│   ├── management/
│   └── security/
└── workloads/
    ├── payments/
    ├── data/
    └── ai/
```

Les dossiers `platform/*` et `workloads/*` sont alimentés progressivement : la Landing Zone et le bootstrap sont volontairement séparés des workloads.

## Remote state

`bootstrap/` crée le Resource Group, le Storage Account et le container Blob. Chaque root aval utilise ensuite une clé distincte, par exemple :

```text
platform/alz-platform.tfstate
platform/connectivity.tfstate
platform/identity.tfstate
workloads/payments-prod.tfstate
workloads/payments-nonprod.tfstate
```

## Quality gates

Le workflow `.github/workflows/terraform-validate.yml` applique actuellement :

```bash
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
```

Les étapes suivantes ajouteront progressivement lint, sécurité IaC, détection de secrets et contrôles de coût.

## Convention de root module / lab

Chaque dossier déployable doit contenir au minimum selon son besoin :

```text
README.md
versions.tf
providers.tf
variables.tf
main.tf
outputs.tf
terraform.tfvars.example
```

Pour un root utilisant un backend distant, ajouter aussi :

```text
backend.tf.example
backend.hcl.example
```

Le `README.md` précise prérequis, architecture, commandes `plan/apply`, tests, coût attendu et commandes `destroy`.
