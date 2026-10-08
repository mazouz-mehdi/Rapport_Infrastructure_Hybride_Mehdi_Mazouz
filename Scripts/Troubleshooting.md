#Journal de Résolution d'Incidents (Troubleshooting)

Dans le cadre du déploiement de cette infrastructure, plusieurs défis techniques ont été rencontrés et résolus. Ce document détaille la démarche de diagnostic et de remédiation appliquée.

## Incident 1 : Échec de connexion SSO sur le portail Microsoft 365

* **Symptôme :** Lors du test final de connexion de l'utilisateur "Jean Test" sur `portal.office.com`, Microsoft a renvoyé l'erreur : *"Ce nom d'utilisateur est peut-être incorrect"*.
* **Diagnostic :** 
  1. Vérification du statut de l'utilisateur sur le portail d'administration Microsoft Entra ID.
  2. Le compte apparaissait bien comme "Synchronisé depuis l'annuaire local".
  3. Comparaison de l'identifiant saisi avec l'attribut `UserPrincipalName` (UPN) enregistré dans le Cloud.
* **Cause racine :** Le nom d'ouverture de session (identifiant court) défini dans l'Active Directory local ne correspondait pas exactement à la syntaxe testée sur le portail web.
* **Résolution :**
  1. Relève de l'UPN strict généré lors de la synchronisation (ex: `jtest@MehdiMazouz.onmicrosoft.com`).
  2. Modification de l'onglet "Compte" de l'utilisateur dans l'Active Directory local pour standardiser l'identifiant.
  3. Nouvelle tentative de connexion avec le nom d'utilisateur exact, aboutissant au succès de l'authentification grâce au *Password Hash Sync*.

## Incident 2 : Non-application d'une Stratégie de Groupe (GPO) sur le client

* **Symptôme :** Après la configuration de la GPO permettant le mappage automatique du lecteur réseau partagé (Lecteur S:), le lecteur n'apparaissait pas dans l'explorateur de fichiers de la machine Windows 10.
* **Diagnostic :** 
  1. Vérification de la connectivité réseau entre le client et le serveur SRV-AD01 (Ping OK).
  2. Vérification des droits NTFS et de partage du dossier réseau.
  3. Lancement d'une invite de commande sur le poste client et exécution de `gpresult /r` pour vérifier quelles stratégies étaient appliquées. La nouvelle GPO n'y figurait pas.
* **Cause racine :** L'ordinateur client et l'utilisateur n'avaient pas encore actualisé leurs stratégies auprès du contrôleur de domaine, et/ou les objets n'étaient pas placés dans la bonne Unité d'Organisation (OU).
* **Résolution :**
  1. Déplacement de l'objet ordinateur (`CLIENT-W10`) et de l'utilisateur (`Jean Test`) dans l'OU ciblée par la GPO (`OU=Service-IT`).
  2. Exécution de la commande `gpupdate /force` sur le poste client pour forcer la mise à jour immédiate des stratégies.
  3. Fermeture et réouverture de la session utilisateur : le lecteur réseau a été correctement mappé.

## Incident 3 : Délai d'apparition d'un compte dans le Cloud

* **Symptôme :** Suite à la création d'un utilisateur de test dans l'Active Directory local On-Premise, le compte n'était toujours pas visible sur le portail Microsoft Entra ID après 15 minutes.
* **Cause racine :** Par défaut, le service Microsoft Entra Connect exécute un cycle de synchronisation automatique toutes les 30 minutes.
* **Résolution :** 
  * Lancement manuel du cycle de synchronisation différentielle (Delta) depuis le serveur via PowerShell afin de gagner du temps lors des phases de test :
  ```powershell
  Import-Module ADSync
  Start-ADSyncSyncCycle -PolicyType Delta
