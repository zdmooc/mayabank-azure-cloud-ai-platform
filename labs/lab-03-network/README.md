# LAB 03 — Hub-Spoke Network

## Objectif

Déployer une topologie réseau pédagogique sans VM ni Azure Firewall : un hub, deux spokes, subnets, NSG, peerings et Private DNS Zone.

## Déploiement

```bash
cd labs/lab-03-network/terraform
terraform init
terraform fmt -check
terraform validate
terraform plan
terraform apply
```

## Vérifications

```bash
az network vnet list -g rg-mbk-network-lab -o table
az network vnet peering list -g rg-mbk-network-lab --vnet-name vnet-mbk-hub-lab -o table
az network nsg list -g rg-mbk-network-lab -o table
az network private-dns zone list -g rg-mbk-network-lab -o table
```

## Tests

- aucun CIDR ne doit se chevaucher ;
- hub et spokes sont appairés ;
- les spokes ne sont pas directement appairés entre eux ;
- le NSG n'ouvre pas d'administration Internet ;
- la Private DNS Zone est liée aux VNets prévus.

Sans VM, on valide ici la **configuration**. Les flux réels seront testés lors des labs AKS/Private Endpoint.

## Coût

Faible : VNets, NSG et peerings n'impliquent pas le coût fixe élevé d'Azure Firewall/Bastion. Vérifier néanmoins la tarification courante des transferts/peerings avant un lab longue durée.

## Destruction

```bash
terraform destroy
```
