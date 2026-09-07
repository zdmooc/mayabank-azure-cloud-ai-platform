# LAB 05 — API Management

## Objectif

Tester gouvernance et sécurité API sans maintenir une instance Premium v2 coûteuse.

## Scénario

Importer une API fictive `/payments` depuis OpenAPI puis appliquer :
- validation JWT ;
- correlation ID ;
- rate limiting ;
- suppression de headers sensibles ;
- diagnostics contrôlés.

## Étapes

1. Choisir une SKU de lab compatible avec les policies testées.
2. Importer `payments-openapi.yaml`.
3. Configurer un backend fictif.
4. Ajouter policies inbound/outbound.
5. Exécuter tests positifs et négatifs.
6. Mesurer latence et logs.
7. Détruire l'instance.

## Tests

- token valide -> requête acceptée ;
- token invalide/absent -> 401/403 attendu ;
- dépassement de quota -> réponse de throttling ;
- correlation ID présent de bout en bout ;
- aucune donnée sensible dans les traces.

## Cible entreprise

La cible MayaBank reste APIM Premium v2 lorsque l'isolation réseau complète de la gateway est requise. Le lab économique ne doit pas être interprété comme la SKU de production.

## IaC

Utiliser l'Azure Verified Module APIM ou les exemples du Landing Zone Accelerator au moment de l'exécution, avec version figée. Les policies et OpenAPI sont les artefacts réellement versionnés par ce dépôt.

## Destroy

Supprimer APIM et vérifier qu'aucun diagnostic/log coûteux ou ressource réseau spécifique au lab ne subsiste.
