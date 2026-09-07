# ADR-001 — Terraform comme IaC principal, Bicep comme référence secondaire

- **Statut** : Accepted
- **Date** : 2026-09-07

## Contexte

MayaBank doit apprendre et démontrer une approche Azure industrialisée, reproductible et portable. Les références Microsoft proposent à la fois Terraform et Bicep. Le projet doit rester lisible par un architecte, exploitable dans les labs et proche des pratiques d'entreprise.

## Options étudiées

### Option A — Terraform principal

**Avantages**
- écosystème largement utilisé en environnement multi-cloud ;
- adapté au profil cloud/Kubernetes du projet ;
- Azure Verified Modules disponibles ;
- facilite la comparaison Azure/AWS/GCP ;
- bon support pour GitHub Actions et pipelines IaC.

**Inconvénients**
- état Terraform à gouverner ;
- dépendance au provider AzureRM/AzAPI ;
- certaines nouveautés Azure sont parfois exposées plus tôt via ARM/Bicep/AzAPI.

### Option B — Bicep principal

**Avantages**
- langage Azure natif ;
- intégration directe ARM ;
- pas de fichier d'état Terraform à gérer ;
- excellente proximité avec les exemples Microsoft.

**Inconvénients**
- spécifique Azure ;
- moins cohérent avec le fil rouge multi-cloud du projet.

## Décision

**Terraform est l'IaC principal du dépôt.**

Bicep reste une compétence obligatoire de lecture et sera utilisé dans certains exemples comparatifs, notamment lorsque les références Microsoft officielles l'utilisent ou lorsqu'il permet de comprendre un mécanisme Azure natif.

Les modules réutilisables doivent privilégier **Azure Verified Modules (AVM)** avant la création de modules maison.

## Conséquences

### Positives
- une stratégie IaC cohérente pour tout le dépôt ;
- apprentissage transférable à d'autres clouds ;
- intégration simple dans une chaîne CI/CD ;
- alignement avec les références AVM Terraform.

### Compromis
- nécessité de maîtriser le state, locking et backend ;
- nécessité de savoir lire Bicep malgré le choix Terraform.

## Critères de réévaluation

Réévaluer si une exigence Azure ne peut pas être couverte proprement via AzureRM/AzAPI/AVM, ou si une contrainte d'entreprise impose Bicep comme standard.
