# LAB 13 — Soutenance Architecte Solution Azure

## Objectif

Défendre l'architecture MayaBank en 30 minutes puis subir un challenge technique de 30 minutes.

## Partie 1 — présentation

Suivre `docs/16-soutenance/README.md` et produire une présentation structurée : besoin -> NFR -> architecture -> décisions -> risques -> coût -> migration.

## Partie 2 — challenge

Le jury choisit au hasard :
- 3 ADR ;
- 2 pannes ;
- 1 contrainte de coût ;
- 1 incident sécurité ;
- 1 changement métier.

Le candidat doit modifier ou défendre l'architecture sans répondre uniquement par des noms de services Azure.

## Scénarios de challenge

1. APIM Premium v2 est jugé trop cher.
2. ExpressRoute est indisponible pendant 4 heures.
3. Une région Azure est perdue.
4. Une équipe demande Owner permanent.
5. La DLQ paiement augmente rapidement.
6. Le nombre de pods AKS double sans hausse de trafic.
7. Un document confidentiel ressort dans une réponse RAG.
8. La facture Log Analytics triple.
9. Le métier réduit le RTO d'un service de 4 h à 15 min.
10. Une application Oracle ne peut pas être refactorée avant 18 mois.

## Barème

- compréhension métier/NFR : 20 % ;
- architecture et cohérence : 20 % ;
- sécurité/résilience : 20 % ;
- capacité d'arbitrage : 15 % ;
- exploitation/observabilité : 10 % ;
- coût/GreenOps : 10 % ;
- clarté : 5 %.

## Critère de réussite

Être capable d'expliquer **pourquoi** un choix est fait, quelle alternative existe, quel risque il traite et quel impact il a sur les autres piliers.
