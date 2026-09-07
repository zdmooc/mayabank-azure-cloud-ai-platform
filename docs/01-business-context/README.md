# Contexte métier — MayaBank

## Contexte

MayaBank est une banque fictive européenne qui modernise progressivement son SI historique. Le SI existant mélange applications Java, bases relationnelles, traitements batch, APIs, messaging et plateformes Kubernetes/OpenShift on-premise.

La cible Azure doit permettre une trajectoire hybride puis cloud, sans supposer que tout doit être migré immédiatement.

## Objectifs métier

1. Accélérer la mise à disposition de nouveaux services digitaux.
2. Réduire le délai de déploiement des changements.
3. Améliorer la résilience des services critiques.
4. Renforcer la sécurité et la traçabilité.
5. Industrialiser l'exposition et la consommation d'API.
6. Préparer les usages Data et IA sans compromettre la gouvernance.
7. Maîtriser les coûts et la consommation de ressources.
8. Permettre une coexistence temporaire entre on-premise, OpenShift et Azure.

## Workloads fil rouge

### Payment API
API métier exposant des opérations de paiement fictives.

Caractéristiques :
- trafic synchrone ;
- authentification forte ;
- exigences de latence ;
- traçabilité de bout en bout ;
- dépendances vers messaging et bases de données.

### Payment Event Processor
Service asynchrone consommant et produisant des événements.

Caractéristiques :
- traitement idempotent ;
- reprise après erreur ;
- dead-letter ;
- montée en charge horizontale.

### Customer Profile
Service de consultation d'informations client fictives.

Caractéristiques :
- données sensibles ;
- accès strictement contrôlé ;
- chiffrement et audit obligatoires.

### AI Assistant for Architecture & Operations
Assistant interne fictif exploitant de la documentation autorisée pour aider les équipes d'architecture et d'exploitation.

Caractéristiques :
- RAG ;
- sources documentaires contrôlées ;
- journalisation ;
- filtrage des accès ;
- absence d'exposition directe de secrets ou données bancaires sensibles.

## Acteurs

- clients digitaux ;
- partenaires ;
- applications internes ;
- équipe plateforme Azure ;
- équipes produits ;
- sécurité ;
- réseau ;
- production/exploitation ;
- architecture ;
- FinOps/GreenOps ;
- conformité et risques.

## NFR initiaux

Ces valeurs sont des hypothèses pédagogiques qui seront raffinées par workload.

| NFR | Cible initiale |
|---|---|
| Disponibilité services critiques | >= 99,95 % selon service |
| RPO critique | de 0 à 15 min selon données |
| RTO critique | de 15 min à 4 h selon service |
| Chiffrement en transit | TLS obligatoire |
| Chiffrement au repos | obligatoire |
| Secrets | aucun secret dans Git ou images |
| Accès privilégié | moindre privilège, accès temporaire privilégié lorsque pertinent |
| Exposition réseau | privée par défaut |
| Observabilité | logs + métriques + traces pour services critiques |
| Infrastructure | reproductible par IaC |
| Traçabilité | corrélation des transactions distribuées |
| Coût | budget défini avant chaque lab |
| Destruction | obligatoire pour ressources de formation coûteuses |

## Contraintes

- environnement de formation à budget limité ;
- certaines architectures enterprise seront étudiées sans être maintenues en permanence ;
- Terraform est l'IaC principal ;
- Bicep est conservé pour comparaison et compréhension des patterns Azure natifs ;
- les noms, données et flux restent fictifs ;
- le dépôt ne contient aucun secret réel.

## Questions d'architecte à traiter

Pour chaque évolution :

1. Quel problème métier résout-on ?
2. Quelles sont les exigences fonctionnelles et non fonctionnelles ?
3. Quel est le niveau de criticité ?
4. Quelle donnée est manipulée et comment est-elle classifiée ?
5. Où sont les frontières de confiance ?
6. Quel service est réellement nécessaire ?
7. Quelles alternatives ont été écartées et pourquoi ?
8. Quels sont les SPOF ?
9. Que se passe-t-il lors de la perte d'une zone ? d'une région ?
10. Comment observe-t-on et exploite-t-on la solution ?
11. Quel est son coût ?
12. Comment la supprimer ou revenir en arrière ?
