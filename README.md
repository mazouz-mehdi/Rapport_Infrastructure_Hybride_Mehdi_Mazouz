# ☁️ Déploiement d'une Infrastructure Hybride Sécurisée (Windows Server & Microsoft 365)

Bienvenue sur le dépôt de mon projet d'administration système et réseau ! 

Ce projet personnel est le fruit de ma volonté de concevoir une architecture d'entreprise complète, en partant de serveurs virtualisés vierges jusqu'à l'hybridation avec le Cloud Microsoft. Il démontre ma capacité à déployer, sécuriser et administrer une infrastructure réseau hautement disponible de A à Z.

## Objectifs du projet

* **Socle Local (On-Premise) :** Installation et configuration de serveurs cœurs de réseau avec les rôles Active Directory (AD DS), DNS et DHCP.
* **Sécurité & Gestion de Parc :** Intégration de postes clients (Windows 10) et sécurisation de l'environnement utilisateur via le déploiement de Stratégies de Groupe (GPO).
* **Haute Disponibilité :** Déploiement d'une topologie multi-contrôleurs de domaine avec réplication bilatérale pour éliminer tout point de défaillance unique (SPOF).
* **Hybridation Cloud :** Interconnexion de l'annuaire local avec le Cloud public via Microsoft Entra Connect (synchronisation des identités).
* **Expérience Utilisateur (SSO) :** Configuration du Single Sign-On (avec Password Hash Sync) pour garantir un accès transparent et sécurisé aux ressources Microsoft 365 avec les identifiants locaux.

## Technologies & Outils

* **Systèmes d'exploitation :** Windows Server 2022, Windows 10
* **Services d'infrastructure :** Active Directory (AD DS), DNS, DHCP, GPO
* **Cloud & Hybridation :** Microsoft 365, Microsoft Entra ID, Azure, Microsoft Entra Connect
* **Tooling :** PowerShell, VMware Workstation (Hyperviseur)

## Fichiers du projet

Vous trouverez dans ce dépôt :

1. Mon **rapport de projet complet au format PDF** (`Rapport_Infrastructure_Hybride_Mehdi_Mazouz.pdf`), qui inclut le détail de l'architecture, toutes les étapes de configuration, et les preuves visuelles de la synchronisation et de la connexion des utilisateurs.

---
Projet réalisé par Mehdi - https://www.linkedin.com/in/mehdi-mazouz-936536205
