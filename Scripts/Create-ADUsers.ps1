<#
.SYNOPSIS
    Script de création d'utilisateurs Active Directory en masse.
.DESCRIPTION
    Ce script lit un fichier CSV contenant les informations des nouveaux collaborateurs
    et automatise la création de leurs comptes dans l'Unité d'Organisation (OU) spécifiée.
    Il assigne également le suffixe UPN routable pour préparer la synchronisation Microsoft 365.
#>

Import-Module ActiveDirectory

# Définition des variables
$CSVPath = "C:\IT\Nouveaux_Utilisateurs.csv"
$TargetOU = "OU=Service-IT,DC=lab,DC=local"
$UPNSuffix = "@MehdiMazouz.onmicrosoft.com"
$DefaultPassword = ConvertTo-SecureString "P@ssw0rd2026!" -AsPlainText -Force

# Lecture du fichier CSV (Colonnes attendues : Prenom, Nom, Fonction)
$Users = Import-Csv -Path $CSVPath -Delimiter ";"

foreach ($User in $Users) {
    # Génération de l'identifiant (ex: j.test)
    $SamAccount = ($User.Prenom.Substring(0,1) + "." + $User.Nom).ToLower()
    $UserPrincipalName = $SamAccount + $UPNSuffix
    $DisplayName = $User.Prenom + " " + $User.Nom

    try {
        New-ADUser -SamAccountName $SamAccount `
                   -UserPrincipalName $UserPrincipalName `
                   -Name $DisplayName `
                   -GivenName $User.Prenom `
                   -Surname $User.Nom `
                   -Title $User.Fonction `
                   -Path $TargetOU `
                   -AccountPassword $DefaultPassword `
                   -Enabled $true `
                   -PasswordNeverExpires $true

        Write-Host "[SUCCÈS] Utilisateur $DisplayName créé avec l'UPN $UserPrincipalName" -ForegroundColor Green
    }
    catch {
        Write-Host "[ERREUR] Impossible de créer l'utilisateur $DisplayName :$_" -ForegroundColor Red
    }
}
