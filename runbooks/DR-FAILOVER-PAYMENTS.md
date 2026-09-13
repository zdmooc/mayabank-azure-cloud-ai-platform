# Runbook — Payment Platform Regional Failover

## But

Guide de référence pour une bascule régionale de la plateforme de paiement MayaBank. Ce runbook doit être adapté aux services réellement déployés et testé avant production.

## Déclenchement

Exemples :

- indisponibilité régionale confirmée ;
- perte durable d'une dépendance critique ;
- décision de crise validée par les rôles autorisés.

Une panne locale d'un pod/node ne justifie pas une bascule régionale.

## Rôles

- Incident Commander ;
- Platform/Cloud Operator ;
- Application/Payment Owner ;
- Data Owner ;
- Security/Network selon incident ;
- communication métier.

## Pré-check

1. confirmer le périmètre de panne ;
2. vérifier santé de la région secondaire ;
3. vérifier l'état de réplication des données ;
4. vérifier messaging et risque de double traitement ;
5. geler les changements non liés à l'incident ;
6. noter l'heure de début pour mesurer le RTO ;
7. ouvrir journal d'incident.

## Bascule logique

1. réduire/stopper les écritures primaires si nécessaire au modèle de données ;
2. valider le dernier point cohérent connu ;
3. activer/promouvoir la cible data secondaire selon le moteur ;
4. activer les consumers/processors secondaires ;
5. vérifier accès Key Vault/identités/réseau/DNS ;
6. basculer le routage global vers la région secondaire ;
7. exécuter transactions synthétiques ;
8. vérifier queues, DLQ et duplications ;
9. annoncer rétablissement contrôlé.

## Contrôles paiement

Avant de déclarer le service rétabli :

- création d'un paiement de test ;
- lecture du statut ;
- idempotency test avec même clé ;
- propagation correlation ID ;
- absence de double débit/traitement ;
- processor actif ;
- backlog messaging sous contrôle ;
- logs et métriques disponibles.

## Mesure

Enregistrer :

```text
incident_detected_at=
failover_decision_at=
secondary_ready_at=
traffic_switched_at=
service_validated_at=
observed_rto=
observed_rpo=
```

Comparer les mesures aux objectifs du BIA/SLO, pas à une valeur supposée.

## Failback

Le retour vers la région primaire est un changement distinct :

1. confirmer stabilité primaire ;
2. resynchroniser données et états ;
3. contrôler messages en transit ;
4. planifier fenêtre ;
5. basculer progressivement ;
6. refaire transactions synthétiques ;
7. surveiller ;
8. clôturer uniquement après validation métier/technique.

## Post-mortem

Documenter chronologie, cause, décisions, RTO/RPO observés, défauts d'automatisation, écarts de documentation et actions correctives. Aucun test PRA n'est « réussi » sans preuves mesurées.
