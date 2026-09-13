# LAB 04 — AKS validation checklist

## Avant création

- [ ] région et version Kubernetes validées ;
- [ ] quota VM vérifié ;
- [ ] estimation de coût effectuée ;
- [ ] heure de destruction prévue ;
- [ ] aucun secret Azure statique dans Git.

## Cluster

- [ ] AKS créé ;
- [ ] OIDC issuer activé ;
- [ ] Workload Identity activée ;
- [ ] Entra ID/RBAC vérifié ;
- [ ] system node pool identifié ;
- [ ] accès API server conforme au scénario du lab.

## Workload

- [ ] `hello-bank` ou service de test déployé avec au moins 2 replicas ;
- [ ] requests/limits ;
- [ ] readiness/liveness probes ;
- [ ] PodDisruptionBudget ;
- [ ] HPA ;
- [ ] suppression manuelle d'un pod et récupération observée.

## Identité

- [ ] ServiceAccount fédéré ;
- [ ] accès autorisé à la ressource Azure cible ;
- [ ] test négatif sans fédération ou sans rôle ;
- [ ] aucun credential Azure longue durée dans un Secret Kubernetes.

## Observabilité

- [ ] logs workload ;
- [ ] métriques cluster/workload ;
- [ ] événement de suppression/recréation du pod visible ;
- [ ] correlation ID si le service de test l'implémente.

## Evidence

Créer `evidence/` lors de l'exécution et y conserver au minimum :

```text
aks-version.txt
nodes.txt
pods.txt
hpa.txt
pdb.txt
workload-identity-test.txt
negative-access-test.txt
monitoring-proof.txt
destroy-proof.txt
```

## Fin

- [ ] cluster détruit ;
- [ ] resource group contrôlé ;
- [ ] disques, IP publiques et load balancers résiduels contrôlés ;
- [ ] coût post-lab vérifié.
