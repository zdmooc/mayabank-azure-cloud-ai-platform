# Références principales

Ce dépôt s'appuie prioritairement sur des références officielles Microsoft/Azure maintenues.

## Azure Landing Zone

- `Azure/Azure-Landing-Zones`
- `Azure/terraform-azurerm-avm-ptn-alz`
- `Azure/alz-bicep-accelerator`

## Architecture générale

- `MicrosoftDocs/architecture-center`

## Réseau

- `Azure-Samples/azure-hub-spoke`

## AKS

- `Azure/AKS-Landing-Zone-Accelerator`
- `Azure/aks-baseline-automation`

## API Management

- `Azure/apim-landing-zone-accelerator`
- `Azure-Samples/Apim-Samples`

## AI

- `Azure/AI-Landing-Zones`

## Règle d'utilisation

Les dépôts de référence ne doivent pas être copiés mécaniquement. Pour chaque pattern repris, documenter :

1. le problème résolu ;
2. les hypothèses ;
3. la partie pertinente pour MayaBank ;
4. ce qui est volontairement simplifié pour le lab ;
5. les coûts et limites ;
6. l'ADR correspondant si le choix est structurant.

## Vigilance sur les anciennes références

Éviter de démarrer un nouveau socle sur d'anciens accélérateurs remplacés par Azure Verified Modules lorsque Microsoft a publié une trajectoire de remplacement. Les références seront revérifiées au moment de chaque itération.
