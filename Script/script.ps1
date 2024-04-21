function ActionCompte {
    while ($true) {
    # Affiche le menu utilisateur
    Clear-Host
    Write-Output "================"
    Write-Output "Menu Utilisateur"
    Write-Output "================"
    Write-Output "1 - Créer un compte utilisateur local"
    Write-Output "2 - Changer le mot de passe d'un utilisateur"
    Write-Output "3 - Supprimer un compte utilisateur local"
    Write-Output "4 - Désactiver un compte utilisateur local"
    Write-Output "0 - Retour au menu principal"
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
            Write-Host "Création de utilisateur local ""$Nom"" "
            Start-Sleep -seconds 2
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Création de utilisateur local "$Nom" "
        }
        "2" {
            $Nom = Read-Host "Entrez le nom de l'utilisateur"
            $motdepasse = Read-Host "Entrez le nouveau mot de passe" -AsSecureString
            $petitScript = {
                param($Nom, $motdepasse)
                Set-LocalUser -Name $Nom -Password $motdepasse
            }
            Invoke-Command -ComputerName $iPDistant -ScriptBlock $petitScript -ArgumentList $Nom, $motdepasse -Credential $credential
            Write-Host "Changement du mot de passe pour ""$Nom"" "
            Start-Sleep -seconds 2
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Changement du mot de passe pour "$Nom" "
        }
        "3" {
            $Nom = Read-Host "Entrez le nom de l'utilisateur à supprimer"
            $petitScript = {
                param($Nom)
                Remove-LocalUser -Name $Nom
            }
            Invoke-Command -ComputerName $iPDistant -ScriptBlock $petitScript -ArgumentList $Nom -Credential $credential
            Write-Host " Suppression de l'utilisateur local ""$Nom"" "
            Start-Sleep -seconds 2
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Suppression de l'utilisateur local "$Nom" "
        }
        "4" {
            $Nom = Read-Host "Entrez le nom de l'utilisateur à désactiver"
            $petitScript = {
                param($Nom)
                Disable-LocalUser -Name $Nom
            }
            Invoke-Command -ComputerName $iPDistant -ScriptBlock $petitScript -ArgumentList $Nom -Credential $credential
            Write-Host "Désactivation de l'utilisateur local ""$Nom"" "
            Start-Sleep -seconds 2
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Désactivation de l'utilisateur local "$Nom" "
        }
        "0" {
            Clear-Host
            Write-Host "Retour au menu principal"
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Retour au menu principal"
            Start-Sleep -Seconds 2
            Return
        }
        default {
            Write-Host "Action non reconnue. Veuillez essayer à nouveau."
        }
    }
    }
}

function ActionGroupe {
    while ($true) {
    # Affiche le menu groupe
    Clear-Host
    Write-Output "==========="
    Write-Output "Menu Groupe"
    Write-Output "==========="
    Write-Output "1 - Ajouter un utilisateur à un groupe d'administration"
    Write-Output "2 - Ajouter un utilisateur à un groupe local"
    Write-Output "3 - Retirer un utilisateur d'un groupe local"
    Write-Output "0 - Retour au menu principal"
    $action = Read-Host "Entrez le numéro de votre choix"

    switch ($action) {
        "1" {
            $nomUtilisateur = Read-Host "Entrez le nom de l'utilisateur"
            $nomGroupe = "Administrateurs"
            $petitScript = {
            #Fixe les parametres utilisateur et groupe pour s'assurer que c'est bien ces variables qui vont dans -Group -Member
                param($nomUtilisateur, $nomGroupe)
                Add-LocalGroupMember -Group $nomGroupe -Member $nomUtilisateur
            }
            Invoke-Command -ComputerName $iPDistant -ScriptBlock $petitScript -ArgumentList $nomUtilisateur, $nomGroupe -Credential $informationsDIdentification
            Write-Host"Ajout de ""$nomUtilisateur"" au groupe Administrateur "
            Start-Sleep -Seconds 2
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Ajout de "$nomUtilisateur" au groupe Administrateur "
        }
        "2" {
            $nomUtilisateur = Read-Host "Entrez le nom de l'utilisateur"
            $nomGroupe = Read-Host "Entrez le nom du groupe local"
            $petitScript = {
            #Fixe les parametres utilisateur et groupe pour s'assurer que c'est bien ces variable qui vont dans -Group -Member
                param($nomUtilisateur, $nomGroupe)
                Add-LocalGroupMember -Group $nomGroupe -Member $nomUtilisateur
            }
            Invoke-Command -ComputerName $iPDistant -ScriptBlock $petitScript -ArgumentList $nomUtilisateur, $nomGroupe -Credential $informationsDIdentification
            Write-Host "Ajout de ""$nomUtilisateur"" au groupe ""$nomGroupe"" "
            Start-Sleep -Seconds 2
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Ajout de "$nomUtilisateur" au groupe "$nomGroupe" "
        }
        "3" {
            $nomUtilisateur = Read-Host "Entrez le nom de l'utilisateur"
            $nomGroupe = Read-Host "Entrez le nom du groupe local"
            $petitScript = {
            #Fixe les parametres utilisateur et groupe pour s'assurer que c'est bien ces variables qui vont dans -Group -Member
                param($nomUtilisateur, $nomGroupe)
                Remove-LocalGroupMember -Group $nomGroupe -Member $nomUtilisateur 
            }
            Invoke-Command -ComputerName $iPDistant -ScriptBlock $petitScript -ArgumentList $nomUtilisateur, $nomGroupe -Credential $informationsDIdentification
            Write-Host "Suppression de ""$nomUtilisateur"" du groupe ""$nomGroupe"" "
            Start-Sleep -Seconds 2
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Suppression de "$nomUtilisateur" du groupe "$nomGroupe" "
        }
        "0" {
            Clear-Host
            Write-Host "Retour au menu principal"
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Retour au menu principal"
            Start-Sleep -Seconds 2
            Return
        }
        default {
            Write-Host "Action non reconnue. Veuillez essayer à nouveau."
        }
    }
    }
}

function ActionSysteme {
    while ($true) {
    # Affiche le menu système
    Clear-Host
    Write-Output "============"
    Write-Output "Menu Système"
    Write-Output "============"
    Write-Output "1 - Arrêter l'ordinateur distant"
    Write-Output "2 - Redémarrer l'ordinateur distant"
    Write-Output "3 - Effectuer une mise à jour du système sur l'ordinateur distant"
    Write-Output "4 - Se déconnecter de la session utilisateur sur l'ordinateur distant"
    Write-Output "0 - Retour au menu principal"
    $action = Read-Host "Entrez le numéro de votre choix"

    switch ($action) {
        "1" {
            # Arrêt de l'ordinateur distant
            Invoke-Command -ComputerName $iPDistant -ScriptBlock { shutdown /s } -Credential $Credential
            Write-Host "Arrêt de l'ordinateur distant"
            Start-Sleep -Seconds 2
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Arrêt de l'ordinateur "$iPDistant" "
        }
        "2" {
            # Redémarrage de l'ordinateur distant
            Invoke-Command -ComputerName $iPDistant -ScriptBlock { shutdown /r } -Credential $Credential
            Write-Host "Redémarrage de l'ordinateur distant"
            Start-Sleep -Seconds 2
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Redémarrage de l'ordinateur "$iPDistant" "
        }
        "3" {
            # Mise à jour du système de l'ordinateur distant
            Invoke-Command -ComputerName $iPDistant -ScriptBlock {  Import-Module PSWindowsUpdate
            Get-WindowsUpdate -AcceptAll -Install -IgnoreReboot } -Credential $Credential
            Write-Host "Mise à jour du système de l'ordinateur distant"
            Start-Sleep -Seconds 2
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Mise à jour système de l'ordinateur "$iPDistant" "
        }
        "4" {
            # Déconnexion de la session utilisateur de l'ordinateur distant
            Invoke-Command -ComputerName $iPDistant -ScriptBlock { logoff console } -Credential $Credential
            Write-Host "Déconnexion de la session utilisateur de l'ordinateur distant"
            Start-Sleep -Seconds 2
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Déconnexion de session sur l'ordinateur "$iPDistant" "
        }
        "0" { 
            Clear-Host
            Write-Host "Retour au menu principal"
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Retour au menu principal"
            Start-Sleep -Seconds 2
            Return
        }
        default {
            Write-Host "Action non reconnue. Veuillez essayer à nouveau."
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
        Write-Host "Répertoire $createDir créé à l'emplacement $pathDir"
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
    # Affiche le menu repertoire
        Clear-Host
        Write-Output "==============="
        Write-Output "Menu Répertoire"
        Write-Output "==============="
        Write-Output "1 - Création de répertoire"
        Write-Output "2 - Suppression de répertoire"
        Write-Output "3 - Modifier un répertoire"
        Write-Output "0 - Retour au menu principal"
        $action = Read-Host "Entrez le numéro de votre choix"
        
        switch ($action) {
            "1" {
                $pathDir = Read-Host "Veuillez saisir un chemin :"
                $createDir = Read-Host "Veuillez saisir le nom du dossier à créer :"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock ${function:createDossier} -ArgumentList $createDir, $pathDir -Credential $Credential
                Start-Sleep -Seconds 2
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME-  Création du dossier "$createDir" à l'emplacement "$pathDir" "
            }
            "2" {
                $pathSuppDir = Read-Host "Veuillez saisir un chemin :"
                $suppDir = Read-Host "Veuillez saisir le nom du dossier à supprimer :"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock ${function:deleteDossier} -ArgumentList $suppDir, $pathSuppDir -Credential $Credential
                Start-Sleep -Seconds 2
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Suppression du dossier "$suppDir" à l'emplacement "$pathSuppDir" "
            }
            "3" {
                $pathModifyDir = Read-Host "Veuillez saisir un chemin :"
                $modifyDir = Read-Host "Veuillez saisir le nom du dossier à modifier :"
                $newNameDir = Read-Host "Veuillez saisir le nouveau nom :"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock ${function:modifyDossier} -ArgumentList $modifyDir, $pathModifyDir, $newNameDir -Credential $Credential
                Start-Sleep -Seconds 2
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Modification du nom de dossier "$modifyDir" en "$newNameDir" à l'emplacement "$pathModifyDir" "
            }
            "0" {
                Clear-Host
                Write-Host "Retour au menu principal"
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Retour au menu principal"
                Start-Sleep -second 2
                Return
            }
            default {
                Write-Host "Action non reconnue. Veuillez essayer à nouveau."
            }
        }
    }
}


function ActionSecurite {
    # Affiche le menu sécurité
    Clear-Host
    Write-Output "============="
    Write-Output "Menu Sécurité"
    Write-Output "============="
    Write-Output "Sélectionnez l'action à réaliser sur le pare-feu :"
    Write-Output "1 - Activer le pare-feu"
    Write-Output "2 - Désactiver le pare-feu"
    Write-Output "0 - Retour au menu principal"
    $action = Read-Host "Entrez le numéro de votre choix"

    switch ($action) {
        "1" {
            # Activation du pare-feu de l'ordinateur distant
            Invoke-Command -ComputerName $iPDistant -ScriptBlock {Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True} -Credential $Credential
            Write-Host "Le pare-feu a été activé sur l'ordinateur distant."
            Start-Sleep -Seconds 2
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Activation du pare-feu sur l'ordinateur "$iPDistant" "
        }
        "2" {
            # Désactivation du pare-feu de l'ordinateur distant
            Invoke-Command -ComputerName $iPDistant -ScriptBlock {Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False} -Credential $Credential
            Write-Host "Le pare-feu a été désactivé sur l'ordinateur distant."
            Start-Sleep -Seconds 2
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Désactivation du  pare-feu sur l'ordinateur "$iPDistant" "
        }
        "0" {
            Clear-Host
            Write-Host "Retour au menu principal"
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Retour au menu principal "
            Start-Sleep -Seconds 2
            Return
        }
        default {
            Write-Host "Action non reconnue. Veuillez essayer à nouveau."
        }
    } 
}


# Fonction pour installer un package
function Installer {
    $nomDuPackage = Read-Host "Entrez le nom du package à installer"
    Install-Package -Name $nomDuPackage -Verbose
}

# Fonction pour désinstaller un package
function Desinstaller {
    $nomDuPackage = Read-Host "Entrez le nom du package à désinstaller"
    Uninstall-Package -Name $nomDuPackage -Verbose
}
# Fonction pour chercher un package
function Chercher-Package {
    $nomRecherche = Read-Host "Entrez le début ou le nom complet du package à chercher"
    $packages = Find-Package -Name $nomRecherche
    if ($packages) {
        Write-Host "Packages trouvés :"
        $packages | Format-Table -Property Name, Version, Source -AutoSize
    } 
    else {
        Write-Host "Aucun package trouvé."
    }
}

function ActionLogiciel {
    while ($true) {
        # Affiche le menu logiciel
        Clear-Host
        Write-Output "============="
        Write-Output "Menu Logiciel"
        Write-Output "============="
        Write-Output "1 - Installer un package"
        Write-Output "2 - Désinstaller un package"
        Write-Output "3 - Chercher un package"
        Write-Output "0 - Retour au menu principal"
        $action = Read-Host "Entrez le numéro de votre choix"

        switch ($action) {
            "1" {
                # Installation d'un package
                Invoke-Command -ScriptBlock ${function:Installer}
                Write-Host "Installation du package ""$nomDuPackage"" "
                Start-Sleep -Seconds 2
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Installation du package "$nomDuPackage" "
            }
            "2" {
                # Désinstaller un package
                Invoke-Command -ScriptBlock ${function:Desinstaller}
                Write-Host "Désinstallation du package ""$nomDuPackage"" "
                Start-Sleep -Seconds 2
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Désinstallation du package "$nomDuPackage" "
            }
            "3" {
                #Recherche d'un package
                Invoke-Command -ScriptBlock ${function:Chercher-Package}
                Write-Host "Localisation du package ""$nomDuPackage"" à l'emplacement ""$packages"" "
                Start-Sleep -Seconds 5
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Localisation du package "$nomDuPackage" à l'emplacement "$packages" "
            }
            "0" {
                Clear-Host
                Write-Host "Retour au menu principal"
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Retour au menu principal "
                Start-Sleep -second 2
                Return
            }
            default {
                Write-Host "Action non reconnue. Veuillez essayer à nouveau."
            }
        }
    }
}


function ActionBureauADistance {
    Start-Process "mstsc.exe"
    Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Prise en main du bureau à distance "
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
        # Affiche le menu information 
        Clear-Host
        Write-Output "================"
        Write-Output "Menu Information"
        Write-Output "================"
        Write-Output "1 - Liste des sessions ouvertes par l'utilisateur"
        Write-Output "2 - Groupe d’appartenance d’un utilisateur"
        Write-Output "3 - Date de dernière connexion d'un utilisateur"
        Write-Output "4 - Historique des commandes executees par l'utilisateu "
        Write-Output "5 - Droits/Permissions de l’utilisateur sur un dossier"
        Write-Output "6 - Droits/Permissions de l’utilisateur sur un fichier"
        Write-Output "7 - Version de l'OS"
        Write-Output "8 - Nombre de disques"
        Write-Output "9 - Partition (nombre, nom, FS, taille) par disque"
        Write-Output "10 - Espace disque restant par partition/volume"
        Write-Output "11 - Nom et espace disque d'un dossier"
        Write-Output "12 - Liste des lecteurs montés (disque, CD, etc.)"
        Write-Output "13 - Nombre d'interfaces"
        Write-Output "14 - Adresse IP de chaque interface "
        Write-Output "15 - Adresse Mac"
        Write-Output "16 - Liste des ports ouverts"
        Write-Output "17 - Statut du pare-feu"
        Write-Output "0  - Retour menu principal"
        $action = Read-Host "Entrez le numéro de votre choix"

        switch ($action) {
            "1" {
                # Liste des sessions ouvertes par l'utilisateur :
                Clear-Host
                Write-Host "Liste des sessions ouvertes par l'utilisateur"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-localUser -name $using:compteDistant| Select-Object Enabled  } -Credential $Credential | Tee-Object -append -FilePath C:\Users\Administrator\Documents\info_$compteDistant`_$(Get-Date -Format yyyyMMdd).txt
                Start-Sleep -Seconds 5
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Liste des sessions ouvertes par l'utilisateur "$compteDistant" "
            }
            "2" {
                # Groupe d’appartenance d’un utilisateur :
                Clear-Host
                Write-Host "Groupe d’appartenance d’un utilisateur"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-LocalGroupMember -Member $using:compteDistant | Select-Object -ExpandProperty Name} -Credential $Credential | Tee-Object -append -FilePath C:\Users\Administrator\Documents\info_$compteDistant`_$(Get-Date -Format yyyyMMdd).txt
                Start-Sleep -Seconds 5
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Groupe d'appartenance de l'utilisateur "$compteDistant" "
                
            }
            "3" {
                # Date de dernière connexion d'un utilisateur :
                Clear-Host
                Write-Host "Date de dernière connexion d'un utilisateur"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-LocalUser -Name $using:compteDistant | Select-Object LastLogon } -Credential $Credential | Tee-Object -append -FilePath C:\Users\Administrator\Documents\info_$compteDistant`_$(Get-Date -Format yyyyMMdd).txt
                Start-Sleep -Seconds 5
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Date de dernière connexion de l'utilisateur "$compteDistant" "
            }
            "4" {
                # Historique des commandes excutées par l'utilisateur :
                Clear-Host
                Write-Host "Historique des commandes excutées par l'utilisateur"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-Content -Path $env:APPDATA\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt } -Credential $Credential | Tee-Object -append -FilePath C:\Users\Administrator\Documents\info_$compteDistant`_$(Get-Date -Format yyyyMMdd).txt
                Start-Sleep -Seconds 5
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Historique des commandes effectuées par l'utilisateur "$compteDistant" "
            }
            "5" {
                # Droits/Permissions de l’utilisateur sur un dossier :
                $Chemin = Read-Host "Entrez le chemin complet du dossier"
                Clear-Host
                Write-Host "Droits/Permissions de l’utilisateur sur un dossier"
                Invoke-Command -ComputerName $iPDistant -Credential $Credential -ScriptBlock {
                    Param($path)
                    Get-Acl $path | Select-Object -ExpandProperty Access
                } -ArgumentList $Chemin | Tee-Object -append -FilePath C:\Users\Administrator\Documents\info_$compteDistant`_$(Get-Date -Format yyyyMMdd).txt
                Start-Sleep -seconds 5
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Droits/Permissions de l’utilisateur "$compteDistant" sur un dossier "$Chemin" "
            }
            "6" {
                # Droits/Permissions de l’utilisateur sur un fichier :
                $Chemin = Read-Host "Entrez le chemin complet du fichier"
                Clear-Host
                Write-Host "Droits/Permissions de l’utilisateur sur un fichier"
                Invoke-Command -ComputerName $iPDistant -Credential $Credential -ScriptBlock {
                    Param($path)
                    Get-Acl $path | Select-Object -ExpandProperty Access
                } -ArgumentList $Chemin | Tee-Object -append -FilePath C:\Users\Administrator\Documents\info_$compteDistant`_$(Get-Date -Format yyyyMMdd).txt
                Start-Sleep -seconds 5
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Droits/Permissions de l’utilisateur "$compteDistant" sur le fichier "$Chemin" " 
            }
            "7" {
                # Version de l'OS :
                Clear-Host
                Write-Host "Version de l'OS"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-CimInstance Win32_OperatingSystem | Select-Object Caption, Version} -Credential $Credential | Tee-Object -append -FilePath C:\Users\Administrator\Documents\info_$iPDistant`_$(Get-Date -Format yyyyMMdd).txt
                Start-Sleep -Seconds 5
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Version de l'OS de l'ordinateur "$iPDistant" "
            }
            "8" {
                # Nombre de disques :
                Clear-Host
                Write-Host "Nombre de disques"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-Disk | Measure-Object | Select-Object -ExpandProperty Count } -Credential $Credential | Tee-Object -append -FilePath C:\Users\Administrator\Documents\info_$iPDistant`_$(Get-Date -Format yyyyMMdd).txt
                Start-Sleep -Seconds 5
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Nombre de disque sur l'ordinateur "$iPDistant" "
            }
            "9" {
                # Partition (nombre, nom, FS, taille) par disque : 
                Clear-Host
                Write-Host "Partition (nombre, nom, FS, taille) par disque"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-Disk | Get-Partition | Select-Object DiskNumber, PartitionNumber, DriveLetter, FileSystemLabel, Size } -Credential $Credential | Tee-Object -append -FilePath C:\Users\Administrator\Documents\info_$iPDistant`_$(Get-Date -Format yyyyMMdd).txt
                Start-Sleep -Seconds 5
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Partition des disques sur l'ordinateur "$iPDistant" "
            }
            "10" {
                # Espace disque restant par partition/volume :
                Clear-Host
                Write-Host "Espace disque restant par partition/volume"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-Volume | Select-Object DriveLetter, FileSystemLabel, @{Name='FreeSpace'; Expression={[math]::Round($_.SizeRemaining / 1GB, 2)}}} -Credential $Credential | Tee-Object -append -FilePath C:\Users\Administrator\Documents\info_$iPDistant`_$(Get-Date -Format yyyyMMdd).txt
                Start-Sleep -Seconds 5
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Espace disque restant sur l'ordinateur "$iPDistant" "
            }
            "11" {
                # Nom et espace disque d'un dossier (nom de dossier demandé) :
                $Chemin = Read-Host "Entrez le chemin complet du dossier"
                Clear-Host
                Write-Host "Nom et espace disque d'un dossier"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-ChildItem $using:Chemin -Recurse | Measure-Object -Property Length -Sum | Select-Object @{Name='TotalSize'; Expression={[math]::Round($_.Sum / 1GB, 2)}} } -Credential $Credential | Tee-Object -append -FilePath C:\Users\Administrator\Documents\info_$iPDistant`_$(Get-Date -Format yyyyMMdd).txt
                Start-Sleep -Seconds 5
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Espace sur le dossier "$Chemin" "
            }
            "12" {
                # Liste des lecteurs montés (disque, CD, etc.) :
                Clear-Host
                Write-Host "Liste des lecteurs montés"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-PSDrive | Where-Object {$_.Provider -match "FileSystem"}} -Credential $Credential | Tee-Object -append -FilePath C:\Users\Administrator\Documents\info_$iPDistant`_$(Get-Date -Format yyyyMMdd).txt
                Start-Sleep -Seconds 5
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Liste des lecteurs montés sur l'ordinateur "$iPDistant" "
            }
            "13" {
                #  Nombre d'interfaces :
                Clear-Host 
                Write-Host "Nombre d'interfaces"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-NetAdapter | Measure-Object | Select-Object Count} -Credential $Credential | Tee-Object -append -FilePath C:\Users\Administrator\Documents\info_$iPDistant`_$(Get-Date -Format yyyyMMdd).txt
                Start-Sleep -Seconds 5
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Nombre d'interface sur l'ordinateur "$iPDistant" "
            }
            "14" {
                # Adresse IP de chaque interface :
                Clear-Host
                Write-Host "Adresse IP de chaque interface"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-NetIPAddress | Select-Object InterfaceAlias, IPAddress} -Credential $Credential | Tee-Object -append -FilePath C:\Users\Administrator\Documents\info_$iPDistant`_$(Get-Date -Format yyyyMMdd).txt
                Start-Sleep -Seconds 5
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Adresse ip des interface sur l'ordinateur "$iPDistant" "
            }
            "15" {
                #  Adresse Mac :
                Clear-Host
                Write-Host "Adresse Mac"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-NetAdapter | Select-Object Name, MacAddress} -Credential $Credential | Tee-Object -append -FilePath C:\Users\Administrator\Documents\info_$iPDistant`_$(Get-Date -Format yyyyMMdd).txt
                Start-Sleep -Seconds 5
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Adresse Mac des interfaces sur l'ordinateur "$iPDistant" "
            }
            "16" {
                # Liste des ports ouverts :
                Clear-Host
                Write-Host "Liste des ports ouverts"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-NetTCPConnection | Where-Object {$_.State -eq "Listen"}} -Credential $Credential | Tee-Object -append -FilePath C:\Users\Administrator\Documents\info_$iPDistant`_$(Get-Date -Format yyyyMMdd).txt
                Start-Sleep -Seconds 5
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Liste des ports ouverts sur l'ordinateur "$iPDistant" "
            }
            "17" {
                # Statut du pare-feu :
                Clear-Host
                Write-Host "Statut du pare-feu"
                Invoke-Command -ComputerName $iPDistant -ScriptBlock { Get-NetFirewallProfile | Select-Object Name, Enabled} -Credential $Credential | Tee-Object -append -FilePath C:\Users\Administrator\Documents\info_$iPDistant`_$(Get-Date -Format yyyyMMdd).txt
                Start-Sleep -Seconds 5
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Status du pare-feu "
            }
            "0" {
                Clear-Host
                Write-Host "Retour au menu principal"
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Retour au menu principal "
                Start-Sleep -second -2
                Return
            }
            default {
                Write-Host "Action non reconnue. Veuillez essayer à nouveau."
            }
        }
    }
}



function menu_principale {
    while ($true) {
        # Affiche le menu principal
        Clear-Host
        Write-Output "=============="
        Write-Output "Menu Principal"
        Write-Output "=============="
        Write-Output "1 - Menu Action"
        Write-Output "2 - Menu Information"
        Write-Output "0 - Quitter"

        $choixMenuPrincipal = Read-Host "Entrez votre choix"

        switch ($choixMenuPrincipal) {
            '1' {
                menu_action
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Menu Action "
            }
            '2' {
                Information-Systeme
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Menu Information "
            }
            '0' {
                Clear-Host
                Write-Host "Au revoir !!!!!"
                Start-Sleep -second 5
                Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- *******EndScript******* "
                Clear-Host
                Exit
            
            }
            default {
                Write-Host "Choix invalide. Veuillez réessayer."
            }
        }
    }
}

function menu_action {
    Clear-Host
    Write-Output "==============="
    Write-Output "Menu de Action"
    Write-Output "==============="
    Write-Output "1 - Action Utilisateur"
    Write-Output "2 - Action Groupe"
    Write-Output "3 - Action Systeme"
    Write-Output "4 - Action Repertoire"
    Write-Output "5 - Action Securite"
    Write-Output "6 - Action Logiciel"
    Write-Output "7 - Action Bureau à Distance"
    Write-Output "0 - Retour menu principal"
    $choixMenuAction = Read-Host "Entrez votre choix"
    switch ($choixMenuAction) {
        '1' { 
            ActionCompte 
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Menu Utilisateur "
        } 
        '2' { 
            ActionGroupe 
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Menu Groupe "
        } 
        '3' {
            ActionSysteme 
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Menu Système "
        } 
        '4' { 
            ActionRepertoire 
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Menu Repertoire "
        } 
        '5' {
            ActionSecurite 
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Menu Sécurité "
        } 
        '6' { 
            ActionLogiciel 
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Menu Logiciel "
        } 
        '7' {
            ActionBureauADistance
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Menu Bureau à Distance "
        }
        '0' {
            Return 
            Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- Retour au menu principal "
        } 
        default {
            Write-Host "Choix invalide. Veuillez réessayer."
        }
    }
}


# Demande les informations Credential (c'est le nom du compte d'en face)
Add-Content -Path C:\Windows\System32\LogFiles\log_evt.log.txt -Value "$(get-date -Format yyyy/MM/dd-HH:mm:ss)-$env:USERNAME- *******StartScript******* "
$compteDistant = Read-Host "Entre le nom du compte distant"
$iPDistant = Read-Host "Ip ordinateur distant"
$Credential = Get-Credential -Credential $compteDistant
$Admin = Read-Host "Veuillez vous identifiez administrateur"
menu_principale