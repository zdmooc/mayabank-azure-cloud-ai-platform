# Naming & Tagging Standard

## Objectif

Rendre les ressources Azure identifiables, gouvernables, auditables et imputables financièrement.

## Convention de nommage

Format général :

```text
<type>-<org>-<workload>-<env>-<region>-<nn>
```

Exemples :

```text
rg-mbk-payments-prod-frc-01
vnet-mbk-hub-prod-frc-01
kv-mbk-pay-prod-frc-01
aks-mbk-payments-prod-frc-01
apim-mbk-digital-prod-frc-01
```

Abréviations recommandées :

| Élément | Valeur |
|---|---|
| Organisation | `mbk` |
| Production | `prod` |
| Préproduction | `preprod` |
| Test | `test` |
| Développement | `dev` |
| Lab | `lab` |
| France Central | `frc` |
| West Europe | `weu` |
| North Europe | `neu` |

Les contraintes de longueur et de caractères propres à chaque service Azure priment toujours sur cette convention.

## Tags obligatoires

| Tag | Exemple | But |
|---|---|---|
| `Application` | `payments-hub` | rattachement applicatif |
| `Environment` | `prod` | environnement |
| `Owner` | `team-payments` | responsabilité |
| `CostCenter` | `CC-PAIEMENTS` | imputation FinOps |
| `Criticality` | `critical` | criticité métier |
| `DataClassification` | `confidential` | classification de données |
| `ManagedBy` | `terraform` | mode de gestion |
| `BusinessUnit` | `payments` | domaine métier |
| `Lifecycle` | `persistent` | permanent/ephemeral |

## Tags complémentaires

- `RTO`
- `RPO`
- `ServiceTier`
- `BackupPolicy`
- `PatchGroup`
- `ArchitectureOwner`
- `ExpiryDate` pour les labs et environnements temporaires

## Règles

- aucun secret, identifiant personnel ou donnée sensible dans un tag ;
- les tags servant à la facturation doivent avoir un vocabulaire contrôlé ;
- les tags obligatoires doivent être vérifiés par Azure Policy ;
- `ExpiryDate` est obligatoire pour les ressources de lab éphémères ;
- les noms ne remplacent pas les tags : ils ont des objectifs différents.
