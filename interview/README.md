# Préparation entretien — Architecte Solution Azure

Ce dossier transformera chaque itération technique en capacité de soutenance d'architecture.

## Méthode de réponse attendue

Pour une question d'architecture, éviter de réciter une liste de services. Répondre dans l'ordre :

1. **Contexte métier** — qui utilise le système et pourquoi ?
2. **Contraintes** — sécurité, réglementation, existant, budget, délais.
3. **NFR** — disponibilité, RTO/RPO, performance, volumétrie, confidentialité.
4. **Options** — au moins deux solutions crédibles lorsque la décision est structurante.
5. **Décision** — architecture retenue et justification.
6. **Sécurité** — identité, réseau, secrets, données, audit.
7. **Résilience** — SPOF, zone/région, sauvegarde, mode dégradé.
8. **Exploitabilité** — monitoring, logs, alertes, runbooks.
9. **Coût** — principaux cost drivers et optimisations.
10. **Migration** — trajectoire et rollback si existant.

## Questions fil rouge

### Landing Zone
- Pourquoi utiliser plusieurs subscriptions ?
- Comment séparer plateforme et workloads ?
- Comment appliquer une gouvernance commune sans bloquer les équipes ?
- Quelle différence entre Management Group, Subscription et Resource Group ?

### Identity
- Quand choisir RBAC, Managed Identity et Workload Identity ?
- Comment éviter les credentials longue durée ?
- Comment gérer les privilèges d'administration ?

### Network
- Hub-Spoke ou Virtual WAN ?
- Quand utiliser Front Door, Application Gateway et Load Balancer ?
- Private Endpoint vs Service Endpoint ?
- Comment connecter un datacenter bancaire à Azure ?

### AKS
- Pourquoi AKS plutôt qu'App Service ou Container Apps ?
- Comment concevoir un AKS privé ?
- Comment isoler les workloads ?
- Comment gérer ingress, secrets, autoscaling et observabilité ?
- Quelles différences importantes avec OpenShift ?

### API Management
- Pourquoi APIM devant des microservices ?
- Où valider JWT et appliquer rate limiting ?
- Comment exposer une API partenaire sans exposer les backends ?

### Messaging / Event Driven
- Service Bus vs Event Hubs vs Event Grid ?
- Comment garantir idempotence et reprise ?
- Comment gérer poison messages et DLQ ?

### Data
- Azure SQL/PostgreSQL vs Cosmos DB ?
- Comment sécuriser l'accès à la donnée ?
- Comment gérer sauvegarde, réplication et RPO ?

### HA/DR
- Une architecture multi-zone suffit-elle pour le PRA ?
- Comment déterminer RTO/RPO ?
- Actif/actif ou actif/passif ?
- Comment tester le PRA ?

### FinOps
- Quel est le coût de la résilience ?
- Comment éviter les clusters AKS surdimensionnés ?
- Comment maîtriser les coûts de logs et d'egress ?

### AI
- Comment connecter Azure AI à des données internes sans fuite ?
- Comment sécuriser un RAG ?
- Comment tracer, évaluer et gouverner les réponses ?

## Cas de soutenance final

> MayaBank dispose d'applications Java et de workloads Kubernetes/OpenShift on-premise. Elle veut exposer de nouvelles APIs de paiement, intégrer des événements temps réel, moderniser progressivement ses applications et introduire des usages IA. Concevez l'architecture Azure cible, la Landing Zone, l'identité, le réseau, la sécurité, la plateforme applicative, l'intégration, la data, l'observabilité, le PRA, l'IaC, le modèle de coût et la trajectoire de migration.

La réponse finale devra être défendable en 30 minutes devant architecture, sécurité, réseau, production et métier.
