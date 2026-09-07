# LAB 09 — HA / DR

## Objectif

Mesurer une reprise au lieu de seulement dessiner un PRA.

## Exercices progressifs

### Niveau 1 — panne locale
- supprimer un pod ;
- vérifier recréation ;
- mesurer indisponibilité perçue.

### Niveau 2 — dépendance
- rendre un backend indisponible ;
- observer timeout/retry/circuit breaker ;
- vérifier les alertes.

### Niveau 3 — restauration
- sauvegarder une donnée de test ;
- supprimer/modifier ;
- restaurer ;
- mesurer RPO/RTO observés.

### Niveau 4 — perte régionale
Effectuer d'abord un tabletop : DNS, Front Door, APIM, AKS, messaging, data, Key Vault, certificats, observabilité et responsabilités humaines.

Un véritable déploiement multi-région n'est créé que pour une session planifiée puis détruit.

## Preuves

- chronologie incident ;
- temps de détection ;
- temps de décision ;
- temps de restauration/failover ;
- écart entre RTO/RPO cible et observé ;
- anomalies du runbook ;
- actions correctives.
