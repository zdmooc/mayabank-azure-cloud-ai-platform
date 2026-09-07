# LAB 11 — Microsoft Foundry / RAG

## Objectif

Construire un petit assistant RAG MayaBank avec documents fictifs, citations, contrôle d'accès et mesure qualité/coût.

## Corpus

Utiliser uniquement des documents fictifs du dépôt : ADR, standards MayaBank et runbooks non sensibles.

## Étapes

1. Vérifier disponibilité/quota du modèle dans l'abonnement.
2. Créer les ressources minimales Foundry/AI Search nécessaires au scénario.
3. Utiliser Entra/Managed Identity plutôt que clés quand possible.
4. Indexer un petit corpus.
5. Implémenter retrieval + génération avec citations.
6. Exécuter le jeu de tests.
7. Mesurer latence et coût.
8. Détruire les ressources facturables.

## Jeu de tests minimum

- 10 questions dont la réponse est explicitement dans les documents ;
- 5 questions sans réponse ;
- 2 tentatives de prompt injection ;
- 2 scénarios de document non autorisé ;
- 1 question ambiguë nécessitant une clarification ou plusieurs sources.

## Critères

- citations correctes ;
- aucune invention lorsque la source manque ;
- document interdit jamais exposé ;
- secrets/prompts sensibles absents des logs ;
- coût par requête noté ;
- latence P50/P95 observée sur le petit jeu de tests.

## Mode sans quota

Si le tenant n'autorise aucun modèle, utiliser un mock pour développer le pipeline et marquer explicitement le résultat `NOT EXECUTED ON AZURE`. Ne jamais présenter un mock comme une preuve Foundry.
