# MayaBank — Payment SLO & Observability Model

## Objectif

Relier la télémétrie Azure aux attentes métier de la chaîne paiement. Une plateforme n'est pas considérée observable uniquement parce qu'elle produit des logs.

## Trois signaux

- **Metrics** : volume, latence, erreurs, saturation, queue depth.
- **Logs** : événements structurés exploitables, sans données sensibles inutiles.
- **Traces** : propagation W3C de bout en bout via `traceparent` et `X-Correlation-ID`.

## Chaîne de trace

```text
Front Door/WAF
  -> APIM
  -> Payment API
  -> Service Bus
  -> Payment Processor
  -> Database
  -> outcome event
```

Chaque étape conserve au minimum `paymentId`, `correlationId`, `messageId` lorsque pertinent.

## SLI de référence

| SLI | Mesure |
|---|---|
| API availability | réponses valides / requêtes totales hors erreurs client définies |
| API latency | p50/p95/p99 POST/GET |
| Processing latency | PaymentRequested -> terminal state |
| Technical failure rate | échecs techniques / traitements |
| Queue health | profondeur + âge du plus ancien message |
| DLQ rate | messages dead-letter / messages reçus |
| Retry rate | retries / traitements |
| Business rejection rate | paiements rejetés fonctionnellement / paiements traités |

Le rejet fonctionnel n'est pas compté automatiquement comme indisponibilité technique.

## SLO POC

Les valeurs exactes doivent être validées par le métier. Pour le POC, les SLO servent à démontrer la méthode et non à simuler un SLA contractuel.

Exemple :

- disponibilité API mesurée sur fenêtre glissante ;
- latence p95 suivie séparément de la latence de traitement asynchrone ;
- alerte sur âge de queue plutôt que sur simple nombre de messages ;
- DLQ non vide déclenche investigation ;
- erreurs 5xx corrélées aux dépendances.

## Golden signals

- latency ;
- traffic ;
- errors ;
- saturation.

Pour le messaging ajouter : backlog, oldest-message-age, dead-letter count et consumer throughput.

## Logs structurés

Exemple logique :

```json
{
  "timestamp": "...",
  "severity": "INFO",
  "service": "payment-processor",
  "correlationId": "...",
  "paymentId": "...",
  "messageId": "...",
  "event": "PaymentCompleted",
  "durationMs": 123
}
```

Ne pas journaliser tokens, secrets, PAN complets, credentials ou payloads sensibles non nécessaires.

## Alerting

Une alerte doit être actionnable. Elle contient :

- symptôme ;
- scope/service ;
- seuil/fenêtre ;
- lien dashboard/query ;
- runbook ;
- ownership ;
- sévérité.

Éviter l'alerte sur chaque erreur individuelle si elle ne nécessite pas d'action humaine.

## Error budget

Le dépôt introduit le concept d'error budget pour relier fiabilité et vitesse de changement :

```text
SLO atteint -> changements normaux
budget consommé rapidement -> limiter changements risqués, corriger fiabilité
SLO durablement violé -> priorité à la remédiation
```

## Dashboards attendus

1. vue métier paiements : volume, états, latence end-to-end ;
2. vue API : RPS, 4xx/5xx, p95/p99, throttling ;
3. vue messaging : backlog, oldest age, retry, DLQ ;
4. vue AKS : CPU/mémoire, replicas, restarts, scheduling ;
5. vue data : connexions, saturation, erreurs ;
6. vue coûts/télémétrie : ingestion et rétention.

## Tests

- injecter une erreur backend ;
- provoquer retry ;
- envoyer un poison message ;
- tuer un pod ;
- vérifier propagation du correlation ID ;
- retrouver une transaction complète dans traces/logs ;
- vérifier que l'alerte pointe vers un runbook.
