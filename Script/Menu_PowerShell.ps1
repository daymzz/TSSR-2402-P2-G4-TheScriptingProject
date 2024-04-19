
function ActionCompte {
    while ($true) {
    # Affiche un menu des actions à réaliser
    Clear-Host
    Write-Output "Sélectionnez l'action à réaliser :"
    Write-Output "1 - Créer un compte utilisateur local"
    Write-Output "2 - Changer le mot de passe d'un utilisateur"
    Write-Output "3 - Supprimer un compte utilisateur local"
    Write-Output "4 - Désactiver un compte utilisateur local"
    Write-Output "5 - Retour menu"
    $action = Read-Host "Entrez le numéro de votre choix"

    # Détermine l'action à effectuer en fonction du choix de l'utilisateur
    switch ($action) {
        "1" {
            $Nom = Read-Host "Entrez le nom du nouvel utilisateur"
            $motdepasse = Read-Host "Entrez le mot de passe du nouvel utilisateur" -AsSecureString
            $petitScript = {
                param($Nom, $motdepasse)
                New-LocalUser -Name $Nom -Password $motdepasse
            }
            Invoke-Command -ComputerName $iPDistant -ScriptBlock $petitScript -ArgumentList $Nom, $motdepasse -Credential $credential
        }
        "2" {
            $Nom = Read-Host "Entrez le nom de l'utilisateur"
            $motdepasse = Read-Host "Entrez le nouveau mot de passe" -AsSecureString
            $petitScript = {
                param($Nom, $motdepasse)
                Set-LocalUser -Name $Nom -Password $motdepasse
            }
            Invoke-Command -ComputerName $iPDistant -ScriptBlock $petitScript -ArgumentList $Nom, $motdepasse -Credential $credential
        }
        "3" {
            $Nom = Read-Host "Entrez le nom de l'utilisateur à supprimer"
            $petitScript = {
                param($Nom)
                Remove-LocalUser -Name $Nom
            }
            Invoke-Command -ComputerName $iPDistant -ScriptBlock $petitScript -ArgumentList $Nom -Credential $credential
        }
        "4" {
            $Nom = Read-Host "Entrez le nom de l'utilisateur à désactiver"
            $petitScript = {
                param($Nom)
                Disable-LocalUser -Name $Nom
            }
            Invoke-Command -ComputerName $iPDistant -ScriptBlock $petitScript -ArgumentList $Nom -Credential $credential
        }
        "5" {
            Write-Output "Retour menu"
            sleep 2
            Return
        }
        default {
            Write-Output "Action non reconnue. Veuillez essayer à nouveau."
        }
    }
    }
}

function ActionGroupe {
    while ($true) {
    # Affiche un menu
    Clear-Host
    Write-Output "Sélectionnez l'action à réaliser :"
    Write-Output "1 - Ajouter un utilisateur à un groupe d'administration"
    Write-Output "2 - Ajouter un utilisateur à un groupe local"
    Write-Output "3 - Retirer un utilisateur d'un groupe local"
    Write-Output "4 - Quitter"
    $action = Read-Host "Entrez le numéro de votre choix"

    switch ($action) {
        "1" {
            $nomUtilisateur = Read-Host "Entrez le nom de l'utilisateur"
            $nomGroupe = "Administrateurs"
            $petitScript = {
            #Fixe les paramatre utilisateur et groupe pour s'arrurer que c'est bien ces variable qui vont dans -Group -Member
                param($nomUtilisateur, $nomGroupe)
                Add-LocalGroupMember -Group $nomGroupe -Member $nomUtilisateur
            }
            Invoke-Command -ComputerName $iPDistant -ScriptBlock $petitScript -ArgumentList $nomUtilisateur, $nomGroupe -Credential $informationsDIdentification
        }
        "2" {
            $nomUtilisateur = Read-Host "Entrez le nom de l'utilisateur"
            $nomGroupe = Read-Host "Entrez le nom du groupe local"
            $petitScript = {
            #Fixe les paramatre utilisateur et groupe pour s'arrurer que c'est bien ces variable qui vont dans -Group -Member
                param($nomUtilisateur, $nomGroupe)
                Add-LocalGroupMember -Group $nomGroupe -Member $nomUtilisateur
            }
            Invoke-Command -ComputerName $iPDistant -ScriptBlock $petitScript -ArgumentList $nomUtilisateur, $nomGroupe -Credential $informationsDIdentification
        }
        "3" {
            $nomUtilisateur = Read-Host "Entrez le nom de l'utilisateur"
            $nomGroupe = Read-Host "Entrez le nom du groupe local"
            $petitScript = {
            #Fixe les paramatre utilisateur et groupe pour s'arrurer que c'est bien ces variable qui vont dans -Group -Member
                param($nomUtilisateur, $nomGroupe)
                Remove-LocalGroupMember -Group $nomGroupe -Member $nomUtilisateur
            }
            Invoke-Command -ComputerName $iPDistant -ScriptBlock $petitScript -ArgumentList $nomUtilisateur, $nomGroupe -Credential $informationsDIdentification
        }
        "4" {
            Write-Output "Retour"
            return
            sleep 2
        }
        default {
            Write-Output "Action non reconnue. Veuillez essayer à nouveau."
        }
    }
    }
   
}

function ActionSysteme {
    while ($true) {
    # Affiche un menu des actions à réaliser
    Clear-Host
    Write-Output "Sélectionnez l'action à réaliser :"
    Write-Output "1 - Arrêter l'ordinateur distant"
    Write-Output "2 - Redémarrer l'ordinateur distant"
    Write-Output "3 - Effectuer une mise à jour du système sur l'ordinateur distant"
    Write-Output "4 - Se déconnecter de la session utilisateur sur l'ordinateur distant"
    Write-Output "5 - Quitter le script"
    $action = Read-Host "Entrez le numéro de votre choix"

    switch ($action) {
        "1" {
            # Arrêt de l'ordinateur distant
            Invoke-Command -ComputerName $iPDistant -ScriptBlock { shutdown /s } -Credential $Credential
        }
        "2" {
            # Redémarrage de l'ordinateur distant
            Invoke-Command -ComputerName $iPDistant -ScriptBlock { shutdown /r } -Credential $Credential
        }
        "3" {
            # Mise à jour du système de l'ordinateur distant
            Invoke-Command -ComputerName $iPDistant -ScriptBlock {  Import-Module PSWindowsUpdate
    Get-WindowsUpdate -AcceptAll -Install -IgnoreReboot } -Credential $Credential
            }
        "4" {
            # Déconnexion de la session utilisateur de l'ordinateur distant
            Invoke-Command -ComputerName $iPDistant -ScriptBlock { logoff console } -Credential $Credential
            }
        "5" {
            Write-Output "Fin du script."
            return
            sleep 2
        }
        default {
            Write-Output "Action non reconnue. Veuillez essayer à nouveau."
        }
    }
    }

}

function createDossier {
    param(
        [string]$createDir,
        [string]$pathDir
    )
    try {
        New-Item -Path "$pathDir\$createDir" -ItemType Directory -ErrorAction SilentlyContinue
        Write-Host "Répertoire $createDir créé à $pathDir"
    } catch {
        Write-Host "Erreur, vérifier que le chemin soit bien saisi."
    }
}

function modifyDossier {
    param(
        [string]$modifyDir,
        [string]$pathModifyDir,
        [string]$newNameDir
    )
    try {
        Rename-Item -Path "$pathModifyDir\$modifyDir" -NewName $newNameDir
        Write-Host "Répertoire $modifyDir a été modifié en $newNameDir à $pathModifyDir"
    } catch {
        Write-Host "Erreur, vérifier que le chemin soit bien saisi."
    }
}

function deleteDossier {
    param(
        [string]$suppDir,
        [string]$pathSuppDir
    )
    try {
        Remove-Item -Path "$pathSuppDir\$suppDir" -Recurse -Force
        Write-Host "Répertoire $suppDir est supprimé de $pathSuppDir"
    } catch {
        Write-Host "Erreur, vérifier que le chemin soit bien saisi."
    }
}

function ActionRepertoire {
    while ($true) {
        Clear-Host
        Write-Output "1 - Création de répertoire"
        Write-Output "2 - Suppression de répertoire"
        Write-Output "3 - Modifier un répertoire"
        Write-Output "4 - Retour"
        $action = Read-Host "Entrez le numéro de votre choix"
        
        switch ($action) {
            "1" {
                $pathDir = Read-Host "Veuillez saisir un chemin :"
                $createDir = Read-Host "Veuillez saisir le nom du dossier à créer :"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock ${function:createDossier} -ArgumentList $createDir, $pathDir -Credential $Credential
            }
            "2" {
                $pathSuppDir = Read-Host "Veuillez saisir un chemin :"
                $suppDir = Read-Host "Veuillez saisir le nom du dossier à supprimer :"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock ${function:deleteDossier} -ArgumentList $suppDir, $pathSuppDir -Credential $Credential
            }
            "3" {
                $pathModifyDir = Read-Host "Veuillez saisir un chemin :"
                $modifyDir = Read-Host "Veuillez saisir le nom du dossier à modifier :"
                $newNameDir = Read-Host "Veuillez saisir le nouveau nom :"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock ${function:modifyDossier} -ArgumentList $modifyDir, $pathModifyDir, $newNameDir -Credential $Credential
            }
            "4" {
                Write-Output "Fin du script."
                return
            }
            default {
                Write-Output "Action non reconnue. Veuillez essayer à nouveau."
            }
        }
    }
}


function ActionSecurite {
    Clear-Host
    Write-Output "Sélectionnez l'action à réaliser sur le pare-feu :"
    Write-Output "1 - Activer le pare-feu"
    Write-Output "2 - Désactiver le pare-feu"
    Write-Output "3 - Quitter le script"
    $action = Read-Host "Entrez le numéro de votre choix"

    switch ($action) {
        "1" {
            # Activation du pare-feu de l'ordinateur distant
            Invoke-Command -ComputerName $iPDistant -ScriptBlock { Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True } -Credential $Credential
            Write-Output "Le pare-feu a été activé sur l'ordinateur distant."
        }
        "2" {
            # Désactivation du pare-feu de l'ordinateur distant
            Invoke-Command -ComputerName $iPDistant -ScriptBlock { Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False } -Credential $Credential
            Write-Output "Le pare-feu a été désactivé sur l'ordinateur distant."
        }
        "3" {
            Write-Output "Retour menu"
            return
            sleep 2
        }
        default {
            Write-Output "Action non reconnue. Veuillez essayer à nouveau."
        }
    } 
}



# Définition des fonctions principales d'installation et de désinstallation
function Installer {
    param (
        [string]$nameInstallApp
    )
    try {
        Start-Process -FilePath $nameInstallApp -Wait
        Write-Host "Installation réussie du logiciel: $nameInstallApp"
    } catch {
        Write-Host "Erreur! Veuillez vérifier que le fichier et le chemin existent ou qu'ils soient écrits de la bonne manière."
    }
}

function Desinstaller {
    param (
        [string]$nameUninstallApp
    )
    try {
        Start-Process -FilePath $nameUninstallApp -Wait
        Write-Host "Désinstallation réussie du logiciel: $nameUninstallApp"
    } catch {
        Write-Host "Erreur! Veuillez vérifier que le fichier et le chemin existent ou qu'ils soient écrits de la bonne manière."
    }
}

function ActionLogiciel {
    while ($true) {
        Clear-Host
        Write-Output "1 - Installer"
        Write-Output "2 - Désinstaller"
        Write-Output "3 - Retour au menu principal"
        $action = Read-Host "Entrez le numéro de votre choix"

        switch ($action) {
            "1" {
                $nameInstallApp = Read-Host "Entrez le chemin complet suivi du nom du fichier d'installation"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock ${function:Installer} -ArgumentList $nameInstallApp -Credential $Credential
            }
            "2" {
                $nameUninstallApp = Read-Host "Entrez le chemin complet suivi du nom du fichier de désinstallation"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock ${function:Desinstaller} -ArgumentList $nameUninstallApp -Credential $Credential
            }
            "3" {
                Write-Output "Fin du script."
                return
            }
            default {
                Write-Output "Action non reconnue. Veuillez essayer à nouveau."
            }
        }
    }
}


function ActionBureauADistance {
    
}


function Information-Systeme {
        #Demande l'adresse IP distant


    function infoDossier { 
        param (
            [string]$cheminDossier
        )

        try {
            $infDossier = Get-Item $cheminDossier
            $infDossierTaille = (Get-ChildItem -Path $infDossier.FullName -Recurse | Measure-Object -Property Length -Sum).Sum /1Gb
            Write-Host "Dossier : $($infDossier.Name)"
            Write-Host "Taille du dossier : $infDossierTaille Gbs"

        }
        catch {
            Write-Host "Erreur"
        }
        $cheminDossier = Read-Host "Entrez le chemin du dossier :"
        infoDossier  $cheminDossier
    }

    while ($true) {
        # Affiche un menu 
        Clear-Host
        Write-Output ""
        Write-Output "1 - Liste des sessions ouvertes par l'utilisateur"
        Write-Output "2 - Groupe d’appartenance d’un utilisateur "
        Write-Output "3 - Date de derniere connexion d'un utilisateur"
        Write-Output "4 - Historique des commandes executees par l'utilisateur "
        Write-Output "5 - Droits/permissions de l’utilisateur sur un dossier "
        Write-Output "6 - Droits/permissions de l’utilisateur sur un fichier  "
        Write-Output "7 - Version de l'OS "
        Write-Output "8 - Nombre de disques"
        Write-Output "9 - Partition (nombre, nom, FS, taille) par disque "
        Write-Output "10 - Espace disque restant par partition/volume "
        Write-Output "11 - Nom et espace disque d'un dossier"
        Write-Output "12 - Liste des lecteurs montes (disque, CD, etc.)"
        Write-Output "13 - Nombre d'interfaces"
        Write-Output "14 - Adresse IP de chaque interface "
        Write-Output "15 - Adresse Mac "
        Write-Output "16 - Liste des ports ouverts"
        Write-Output "17 - Statut du pare-feu  "
        Write-Output "0  - Retour menu "
        $action = Read-Host "Entrez le numéro de votre choix"

        switch ($action) {
            "1" {
            #   Liste des sessions ouvertes par l'utilisateur :
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-localUser -name wilder | Select-Object Enabled  } -Credential $Credential
                Sleep 5
            }
            "2" {
                # Groupe d’appartenance d’un utilisateur :
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-localUser -name wilder | Select-Object ObjectClass } -Credential $Credential
                Sleep 5
            }
            "3" {
            # date de derniere conneSleep 5ion d'un utilisateur
                Invoke-Command -ComputerName $iPDistant -ScriptBlock {Get-localUser -name wilder | Select-Object LastLogon } -Credential $Credential
                Sleep 5
            }
            "4" {
                #    Historique des commandes eSleep 5écutées par l'utilisateur :
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-History} -Credential $Credential
                Sleep 5
            }
            "5" {
                #   Droits/permissions de l’utilisateur sur un dossier : a revoir
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-Acl -Path "Chemin\Vers\Dossier" | Format-List } -Credential $Credential
                Sleep 5
            }
            "6" {
                #   Droits/permissions de l’utilisateur sur un fichier :
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-Acl -Path "Chemin\Vers\Fichier" | Format-List
            } -Credential $Credential
            Sleep 5
            }
            "7" {
                #   Version de l'OS : ok
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-Computer OsName, OsVersion} -Credential $Credential
                Sleep 5
            }
            "8" {
                #   Nombre de disques : ok
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-Disk | Measure-Object | Select-Object Count} -Credential $Credential
                Sleep 5
            }
            "9" {
                #   Partition (nombre, nom, FS, taille) par disque : ok a voir si y a mieuSleep 5
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-Partition | Select-Object DiskNumber, Name, FileSystem, Size } -Credential $Credential
                Sleep 5
            }
            "10" {
                #   Espace disque restant par partition/volume : ok
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-Volume | Select-Object DriveLetter, FileSystemLabel, SizeRemaining } -Credential $Credential
                Sleep 5
            }
            "11" {
            #   Nom et espace disque d'un dossier (nom de dossier demandé) :
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { infoDossier } -Credential $Credential
                Sleep 5
            }
            "12" {
                #   Liste des lecteurs montés (disque, CD, etc.) :ok
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-PSDrive | Where-Object {$_.Provider -match "FileSystem"}} -Credential $Credential
                Sleep 5
            }
            "13" {
            #  Nombre d'interfaces : ok
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-NetAdapter | Measure-Object | Select-Object Count} -Credential $Credential
                Sleep 5
            }
            "14" {
            #   Adresse IP de chaque interface : ok
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-NetIPAddress | Select-Object InterfaceAlias, IPAddress} -Credential $Credential
                Sleep 5
            }
            "15" {
            #   Adresse Mac : ok
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-NetAdapter | Select-Object Name, MacAddress} -Credential $Credential
                Sleep 5
            }
            "16" {
                #   Liste des ports ouverts : ok
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-NetTCPConnection | Where-Object {$_.State -eq "Listen"}} -Credential $Credential
                Sleep 5
            }
            "17" {
            #    Statut du pare-feu : ok
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-NetFirewallProfile | Select-Object Name, Enabled} -Credential $Credential
                Sleep 5
            }
            "0" {
                Write-Output "Fin du script."
                return
            }
            default {
                Write-Output "Action non reconnue. Veuillez essayer à nouveau."
            }
        }
    }
}



function menu_principale {
    while ($true) {
        Clear-Host
        Write-Host "=============="
        Write-Host "Menu Principal"
        Write-Host "=============="
        Write-Host "1 - Menu Action"
        Write-Host "2 - Menu Information"
        Write-Host "3 - Quitter"

        $choixMenuPrincipal = Read-Host "Entrez votre choix"

        switch ($choixMenuPrincipal) {
            '1' {
                menu_action
            }
            '2' {
                Information-Systeme
            }
            '3' {
                exit
            }
            default {
                Write-Host "Choix invalide. Veuillez réessayer."
            }
        }
    }
}

function menu_action {
    Clear-Host
    Write-Host "==============="
    Write-Host "Menu de Action"
    Write-Host "==============="
    Write-Host "1 - Action Utilisateur"
    Write-Host "2 - Action Groupe"
    Write-Host "3 - Action Systeme"
    Write-Host "4 - Action Repertoire"
    Write-Host "5 - Action Securite"
    Write-Host "6 - Action Logiciel"
    Write-Host "7 - Action Bureau à Distance"
    Write-Host "8 - Quitter"
    $choixMenuAction = Read-Host "Entrez votre choix"
    switch ($choixMenuAction) {
        '1' { ActionCompte }
        '2' { ActionGroupe }
        '3' { ActionSysteme }
        '4' { ActionRepertoire }
        '5' { ActionSecurite }
        '6' { ActionLogiciel }
        '7' { ActionBureauADistance }
        '8' { return }
        default {
            Write-Host "Choix invalide. Veuillez réessayer."
        }
    }
}


# Demande les informations Credential (c'est le nom du compte d'en face"
$compteDistant = Read-Host "Entre le nom du compte distant"
$iPDistant = Read-Host "Ip ordinateur distant"
$Credential = Get-Credential -Credential $compteDistant
$Admin = Read-Host "Veuillez vous identifiez administrateur"
menu_principale
