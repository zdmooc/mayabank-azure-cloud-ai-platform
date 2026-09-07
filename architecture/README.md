# Architecture — gouvernance des livrables

## Niveaux de représentation

Le dépôt utilisera plusieurs vues complémentaires :

### 1. Contexte
Acteurs, systèmes externes, frontières de responsabilité et flux principaux.

### 2. Architecture logique
Capabilities, domaines fonctionnels, services applicatifs, API, événements et données.

### 3. Architecture Azure
Subscriptions, VNets, services PaaS, clusters, private endpoints, contrôles de sécurité et observabilité.

### 4. Déploiement
Régions, zones, node pools, instances, réplication, dépendances et chemins réseau.

### 5. Séquences
Scénarios critiques : authentification, paiement, publication d'événement, reprise sur erreur, failover.

## Règles pour les diagrammes

Chaque diagramme doit préciser :

- objectif et audience ;
- périmètre ;
- hypothèses ;
- flux principaux ;
- frontières de confiance lorsque pertinentes ;
- région/zone lorsqu'elles ont un impact ;
- lien vers les ADR structurants.

Éviter les diagrammes « catalogue » contenant tous les services Azure sans expliquer leurs responsabilités.

## ADR

Les Architecture Decision Records vivent dans `architecture/adr/`.

Un ADR est requis lorsque la décision :

- impacte plusieurs équipes ;
- crée une dépendance durable ;
- modifie sécurité ou réseau ;
- influence fortement coût ou résilience ;
- oppose plusieurs options crédibles ;
- serait difficile à annuler.

## Dossier d'architecture final

La synthèse finale devra permettre de répondre rapidement à :

- Pourquoi cette architecture ?
- Quels besoins couvre-t-elle ?
- Quelles alternatives ont été rejetées ?
- Où sont les données et les secrets ?
- Quels flux sont publics/privés ?
- Quels sont les SPOF ?
- Que se passe-t-il si une zone ou une région tombe ?
- Comment est-elle exploitée ?
- Combien coûte-t-elle ?
- Comment migre-t-on depuis l'existant ?
