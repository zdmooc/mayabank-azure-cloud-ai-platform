# Terraform — stratégie IaC

## Objectif

Terraform est l'IaC principal de MayaBank. Le but n'est pas de créer une bibliothèque maison gigantesque, mais d'apprendre à assembler des briques vérifiées, versionnées et testables.

## Principes

- préférer les **Azure Verified Modules (AVM)** lorsqu'ils couvrent le besoin ;
- versions de providers et modules explicitement contraintes ;
- aucun secret dans le code ou les variables versionnées ;
- remote state uniquement lorsqu'un lab le nécessite ;
- séparation claire entre plateforme et workloads ;
- fichiers de variables par environnement sans données sensibles ;
- `terraform fmt`, `validate` et `plan` avant `apply` ;
- `destroy` documenté pour chaque lab ;
- éviter les ressources coûteuses permanentes pour les exercices.

## Structure cible

```text
infrastructure/terraform/
├── bootstrap/
├── modules/
├── platform/
│   ├── landing-zone/
│   ├── identity/
│   ├── networking/
│   ├── security/
│   └── observability/
└── workloads/
    ├── payments/
    ├── data/
    └── ai/
```

## Quality gates attendus

```bash
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
```

Des contrôles supplémentaires seront ajoutés ensuite : lint, sécurité IaC, documentation et estimation de coût selon les outils retenus.

## Convention de lab

Chaque dossier déployable devra contenir au minimum :

```text
README.md
versions.tf
providers.tf
variables.tf
main.tf
outputs.tf
terraform.tfvars.example
```

Le `README.md` précisera : prérequis, architecture, commandes `plan/apply`, tests, coût attendu et commandes `destroy`.
