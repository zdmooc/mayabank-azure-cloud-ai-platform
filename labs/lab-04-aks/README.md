# LAB 04 — AKS sécurisé

## Objectif

Déployer ponctuellement un AKS de petite taille pour vérifier les décisions de l'itération 4 sans maintenir du compute payant.

## Pré-check coût

Avant tout déploiement : vérifier le prix des VM nodes dans la région et le quota disponible. Le cluster doit être détruit à la fin de la session.

## Étapes

1. Réutiliser ou créer un VNet de lab.
2. Créer un AKS Standard avec un petit system node pool.
3. Activer OIDC issuer et Workload Identity.
4. Intégrer Microsoft Entra ID.
5. Déployer `hello-bank` avec 2 replicas, requests/limits et PDB.
6. Ajouter HPA.
7. Associer une Managed Identity à un ServiceAccount.
8. Tester l'accès autorisé à une ressource Azure.
9. Supprimer un pod et observer la récupération.
10. Collecter logs/métriques puis détruire.

## Tests négatifs

- ServiceAccount sans fédération -> accès Azure refusé.
- Pod sans les droits requis -> accès Key Vault/Data refusé.
- Image non autorisée selon policy -> rejet attendu lorsque la policy correspondante est activée.

## Preuves

Conserver versions AKS/Kubernetes, node pools, sortie `kubectl get nodes -o wide`, `kubectl get pods`, HPA, PDB, identité fédérée et preuve du destroy.

## Référence d'implémentation

Pour un déploiement Terraform complet, partir de l'Azure Verified Module AKS ou de l'AKS Landing Zone Accelerator, puis figer les versions au moment du lab. Ne pas recopier un module ancien dans ce dépôt.

## Destroy

Détruire le Resource Group/stack Terraform du lab et vérifier les disques/IP/Load Balancers résiduels.
