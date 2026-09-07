# LAB 06 — Event Driven / Messaging

## Objectif

Prouver la différence entre messaging métier fiable et streaming, puis tester retry, DLQ et idempotence.

## Scénario Service Bus

`PaymentRequested(paymentId)` -> worker -> échec contrôlé -> retry -> DLQ -> replay.

## Critère critique

Le même `paymentId` ne doit produire qu'un seul effet métier. Le consommateur doit stocker ou vérifier une clé d'idempotence avant de produire l'effet irréversible.

## Étapes

1. Créer un namespace/service de lab.
2. Créer queue ou topic/subscription.
3. Producteur avec `paymentId` stable.
4. Consommateur en PeekLock/ack explicite selon SDK.
5. Provoquer plusieurs échecs.
6. Observer delivery count et DLQ.
7. Corriger la cause puis rejouer.
8. Comparer ensuite un petit flux Event Hubs pour comprendre partitions/consumer groups/replay.

## Tests négatifs

- duplicate message ;
- poison message ;
- consommateur indisponible ;
- quota/throttling simulé si possible ;
- ordre d'arrivée différent de l'ordre métier.

## Sécurité

Managed Identity/RBAC quand le SDK et le service le permettent ; pas de connection string versionnée.

## Destroy

Supprimer les namespaces du lab et vérifier l'absence de ressources facturables résiduelles.
