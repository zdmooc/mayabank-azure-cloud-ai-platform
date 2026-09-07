# LAB 10 — FinOps / GreenOps

## Objectif

Prouver que les labs et architectures sont pilotés par coût, ownership et consommation utile.

## Routine

Avant un lab :
```bash
az account show
az resource list --query "[].{name:name,type:type,rg:resourceGroup}" -o table
```

Pendant :
- vérifier tags ;
- noter ressources payantes ;
- relever durée d'utilisation ;
- observer scaling et capacité réellement consommée.

Après `destroy` :
```bash
az resource list --query "[?contains(tags.Environment, 'lab')].{name:name,type:type,rg:resourceGroup}" -o table
```

Adapter la requête si certaines ressources n'ont pas le tag ou si la policy n'est pas active.

## Checklist orphelins

- Public IP ;
- Managed Disks ;
- Load Balancers ;
- snapshots ;
- Log Analytics ingestion/rétention ;
- APIM ;
- AKS node resource group ;
- databases ;
- Private Endpoints ;
- NAT Gateway / Firewall / Bastion.

## GreenOps

Pour chaque optimisation, indiquer le mécanisme physique/technique : moins de VM-hours, moins de stockage, moins de transfert, meilleure densité ou moins de rétention. Ne pas convertir arbitrairement des euros économisés en CO2.

## Preuve

Conserver coût estimé, coût observé, ressources supprimées, éventuels résidus et action corrective.
