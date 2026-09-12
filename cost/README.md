# FinOps / GreenOps — garde-fous du projet

## Objectif

Maintenir les labs compatibles avec un budget d'apprentissage limité et intégrer le coût comme une exigence d'architecture.

## Avant tout déploiement

Documenter :

- région ;
- SKU/tier ;
- durée prévue ;
- coût fixe éventuel ;
- coût lié au trafic ;
- stockage et rétention ;
- logs ;
- sauvegardes ;
- ressources dépendantes ;
- méthode de destruction.

## Règles

1. Ne pas maintenir en permanence un composant coûteux uniquement pour démonstration.
2. Déployer à la demande et détruire après validation.
3. Utiliser tags et budgets dès les premières itérations.
4. Limiter la rétention des logs des environnements de lab.
5. Éviter le surdimensionnement des VM, node pools et bases.
6. Tester l'autoscaling plutôt que provisionner le pic théorique en permanence.
7. Documenter les coûts cachés : egress, NAT, Firewall, logs, Private Link, sauvegardes.
8. Séparer ce qui est requis en production de ce qui suffit pour apprendre.
9. Ne jamais lancer une ressource coûteuse sans chiffrage horodaté, durée maximale et procédure de destroy vérifiée.
10. Un coût estimé ne devient jamais un coût mesuré : le coût réel doit venir d'Azure Cost Management après exécution.

## Tags minimums

```text
application = mayabank
workload    = <nom-workload>
environment = lab|dev|test|prod
owner       = architecture
cost-center = training
managed-by  = terraform
expiry      = YYYY-MM-DDThh:mm:ssZ
```

## Méthode obligatoire de sizing et chiffrage

Chaque lab payant doit posséder un dossier de décision qui contient au minimum :

1. charge fonctionnelle et hypothèses de trafic ;
2. version du service/cluster ;
3. nombre de nœuds/instances ;
4. vCPU, RAM, stockage et GPU éventuel ;
5. quotas régionaux et quotas de famille VM ;
6. prix unitaire actuel par SKU/région ;
7. coût licence/service managé éventuel ;
8. coûts stockage, réseau, logs, sauvegardes et endpoints privés ;
9. coût estimé par heure et pour la durée maximale du lab ;
10. budget/plafond, marge de sécurité et heure de destruction ;
11. coût réel récupéré après exécution ;
12. écart estimation/réel et action de rightsizing.

Le prix doit être rafraîchi juste avant le déploiement depuis le calculateur Azure ou une source de prix Azure automatisable. Ne pas conserver un ancien prix comme vérité permanente.

## Scénario ARO partagé avec TradeOps

Le dépôt `zdmooc/TradeOps-GenAI-Integration` réutilise ces principes pour son lab ARO/RHOAI. Baseline de travail au 2026-09-12 :

- région : `francecentral` ;
- ARO : `4.20.15` ;
- RHOAI : `3.4` ;
- 3 masters `Standard_D8s_v5` ;
- 3 workers `Standard_D8s_v5` ;
- total steady-state : 48 vCPU / 192 GiB ;
- cible de quota prudente : au moins 64 vCPU régionaux et 64 vCPU DSv5, sous réserve de validation `az aro validate` ;
- budget personnel d'apprentissage : EUR 50/mois maximum ;
- première fenêtre de lab : <= 8 h.

### Snapshot de coût indicatif — 2026-09-12

Le snapshot suivant sert uniquement à planifier. Il doit être recalculé avant le vrai déploiement :

- D8s_v5 France Central Linux PAYG : environ USD 0.448/h par VM ;
- surcharge OpenShift ARO worker D8s_v5 : USD 0.342/h par worker ;
- 3 masters compute : ~USD 1.344/h ;
- 3 workers compute : ~USD 1.344/h ;
- 3 licences worker ARO : ~USD 1.026/h ;
- subtotal ARO nœuds : **~USD 3.714/h** avant stockage/réseau/logs/monitoring.

Ordres de grandeur :

| Durée | Subtotal ARO indicatif |
|---:|---:|
| 4 h | ~USD 14.86 |
| 6 h | ~USD 22.28 |
| 8 h | ~USD 29.71 |
| 12 h | ~USD 44.57 |
| 24 h | ~USD 89.14 |

La fenêtre de 8 h est retenue comme plafond de départ parce qu'elle laisse une marge pour les coûts additionnels et le budget mensuel. Le GO final dépend du prix Azure réellement recalculé le jour du lab.

## Backlog d'industrialisation FinOps

- [ ] Authentification GitHub Actions -> Azure par OIDC, sans client secret permanent.
- [ ] Terraform remote state sur Azure Storage avec stratégie de bootstrap séparée.
- [ ] Pipeline `PLAN` produisant sizing, quotas et estimation de coût horodatée.
- [ ] Approval obligatoire avant tout `terraform apply` ou création de service coûteux.
- [ ] Budgets Azure et alertes de seuil pour le lab.
- [ ] Tags obligatoires incluant `expiry`/TTL.
- [ ] Pipeline CREATE avec limite de durée explicite.
- [ ] Pipeline DESTROY idempotent.
- [ ] Auto-destroy planifié sur expiration TTL pour les labs éphémères.
- [ ] Capture Cost Management avant/après destroy.
- [ ] Vérification qu'aucune ressource facturable ne reste après destroy.
- [ ] Rapport estimation vs coût réel et rightsizing.
- [ ] GreenOps : collecter les données fournisseur disponibles ou documenter explicitement la méthode d'estimation et ses incertitudes.

## Questions FinOps d'architecte

- Quel composant domine le coût ?
- Le coût est-il fixe ou proportionnel au trafic ?
- Quel est le coût de la HA ?
- Quel est le coût du DR ?
- Combien coûtent les logs ?
- Combien coûte le trafic inter-zone/inter-région ?
- Le dimensionnement repose-t-il sur des mesures ?
- Peut-on arrêter ou réduire les environnements hors usage ?
- Quelle métrique métier permet d'exprimer le coût : transaction, API call, client, Go, événement ?
- Quel est l'écart entre estimation pré-déploiement et coût réellement facturé ?
- Le destroy est-il vérifié ou simplement demandé ?

## GreenOps

Le projet cherchera à relier coût et sobriété :

- réduire les ressources inutilisées ;
- maîtriser la rétention ;
- utiliser l'élasticité ;
- éviter les copies de données inutiles ;
- choisir la région et la résilience selon les vraies exigences ;
- mesurer avant d'optimiser ;
- détruire les environnements de lab dès que la preuve attendue est acquise.
