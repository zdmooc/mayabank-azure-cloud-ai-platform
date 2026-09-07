# Azure Policy Baseline — MayaBank

## Objectif

Appliquer des garde-fous héritables sans bloquer inutilement les équipes produits.

## Baseline proposée

| Domaine | Contrôle | Effet cible |
|---|---|---|
| Localisation | limiter les régions autorisées selon le workload | Deny / audit selon phase |
| Tags | exiger les tags obligatoires | Deny ou Modify |
| Réseau | auditer/interdire les IP publiques non approuvées | Audit puis Deny |
| PaaS | exiger Private Endpoint quand pertinent | DeployIfNotExists / Deny selon service |
| TLS | refuser les versions TLS faibles | Deny |
| Storage | interdire l'accès blob public | Deny |
| Storage | exiger secure transfer | Deny |
| Key Vault | soft delete/purge protection selon criticité | Audit/Deny |
| Diagnostic | envoyer les diagnostics vers la plateforme de logs | DeployIfNotExists |
| Defender | activer les plans définis par la politique sécurité | DeployIfNotExists |
| VM | contrôler images/SKU autorisés | Audit/Deny |
| AKS | cluster privé pour production | Deny/Audit |
| AKS | Azure Policy add-on / contrôles Kubernetes | Audit/Deny ciblé |
| Identité | privilégier Managed Identity | Audit |
| Coût | contrôler familles/SKU coûteuses en lab | Deny |

## Stratégie d'effet

Une policy ne passe pas directement de "rien" à `Deny` en production.

```text
Design -> Audit -> Remediation -> Measure -> Deny
```

Exceptions : les risques évidents peuvent être bloqués immédiatement, par exemple l'exposition publique d'un Storage Account contenant des données confidentielles.

## Exemptions

Toute exemption doit contenir :

- justification métier/technique ;
- propriétaire ;
- scope ;
- risque accepté ;
- date d'expiration ;
- mesure compensatoire ;
- ticket ou ADR associé.

## Régions

La région autorisée est une décision d'architecture par workload et non une constante universelle. Pour MayaBank, `France Central` est la préférence de conception lorsqu'elle satisfait la disponibilité des services et les exigences de résilience. Toute région secondaire doit être validée en fonction de la disponibilité du service, du PRA, de la résidence des données, de la latence et du coût.

## Principe banque/assurance

La conformité ne doit pas être réduite à une liste de policies. Les contrôles Azure Policy complètent les contrôles IAM, réseau, chiffrement, journalisation, sécurité applicative, gestion des vulnérabilités, sauvegarde/PRA et processus d'exploitation.
