<#
.SYNOPSIS
    Forcer la synchronisation Microsoft Entra Connect (Delta).
.DESCRIPTION
    Permet de pousser instantanément les modifications de l'Active Directory local
    (nouveaux utilisateurs, changements de mots de passe) vers le tenant Microsoft Entra ID.
#>

Write-Host "Lancement de la synchronisation Delta vers Microsoft Entra ID..." -ForegroundColor Cyan

try {
    Import-Module ADSync
    Start-ADSyncSyncCycle -PolicyType Delta
    Write-Host "[SUCCÈS] Synchronisation déclenchée. Vérifiez le portail Office 365 d'ici quelques minutes." -ForegroundColor Green
}
catch {
    Write-Host "[ERREUR] Le module ADSync est introuvable ou la commande a échoué. Exécutez ce script sur le serveur Entra Connect." -ForegroundColor Red
}
