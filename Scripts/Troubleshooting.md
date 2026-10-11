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
 

## Incident 2 : Délai d'apparition d'un compte dans le Cloud

* **Symptôme :** Suite à la création d'un utilisateur de test dans l'Active Directory local On-Premise, le compte n'était toujours pas visible sur le portail Microsoft Entra ID après 15 minutes.
* **Cause racine :** Par défaut, le service Microsoft Entra Connect exécute un cycle de synchronisation automatique toutes les 30 minutes.
* **Résolution :** 
  * Lancement manuel du cycle de synchronisation différentielle (Delta) depuis le serveur via PowerShell afin de gagner du temps lors des phases de test :
  ```powershell
  Import-Module ADSync
  Start-ADSyncSyncCycle -PolicyType Delta
