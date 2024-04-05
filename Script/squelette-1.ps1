#!/bin/bash

#gestion de functions action

#exemple d'action 
#function Creer-CompteUtilisateur {
#    param (
#        [string]$nomUtilisateur,#<----- on indique qu'on attend un chaine de caracter pour l'utilisateur
#        [string]$motDePasse#<----- on indique qu'on attend un chaine de caracter pour MDP
#    )
    
    # Vérifier si le compte utilisateur existe déjà
    #Get-WmiObject pour verifier si le compte existe dans le win32
#    if (Get-WmiObject Win32_UserAccount | Where-Object { $_.Name -eq $nomUtilisateur }) {
#        Write-Host "Le compte utilisateur $nomUtilisateur existe déjà."
#        return
#    }
    
    # Créer le compte utilisateur avec la cmdlet New-LocalUser
#    $nouvelUtilisateur = New-LocalUser -Name $nomUtilisateur -Password $motDePasse 
    
    # Vérifier si la création du compte a réussi
#    if ($nouvelUtilisateur) {
#        Write-Host "Le compte utilisateur $nomUtilisateur a été créé avec succès."
#    } else {
#        Write-Host "Erreur lors de la création du compte utilisateur."
#    }
#}

# Appeler la fonction pour créer un compte utilisateur avec le nom "wilder" et le mot de passe "1234"
#Creer-CompteUtilisateur -nomUtilisateur "wilder" -motDePasse "1234"


#gestion de functions information

#exemple de function
#function Sauvegarder-Fichier {
#    param (
#        C:\Chemin\vers\monfichier.txt $source,
#        D:\Sauvegarde\MonFichier.txt $destination
#    )
#    
#   Copy-Item -Path $source -Destination $destination -Force
#    return "Fichier sauvegardé avec succès."
#}
#puis pour appeler la function, on dit que le resultat  est le nom de fonction puis ses 2 parametres 

# $resultat = Sauvegarder-Fichier -source "C:\MonFichier.txt" -destination "D:\Sauvegarde\MonFichier.txt"

#Write-Host $resultat  <---- Write-host equivaut a echo en bash

#menu gestion ou information

function Afficher-MenuPrincipal {
    Clear-Host
    Write-Host "=============="
    Write-Host "Menu Principal"
    Write-Host "=============="
    Write-Host "1 - Menu Action"
    Write-Host "2 - Menu Information"
    Write-Host "Q - Quitter"
}

function Afficher-Menu {
    Clear-Host
    Write-Host "==============="
    Write-Host "Menu de Gestion"
    Write-Host "==============="
    Write-Host "a - Gestion Compte"
    Write-Host "b - Gestion Groupe"
    Write-Host "c - Gestion Système"
    Write-Host "d - Gestion Répertoire"
    Write-Host "e - Gestion Sécurité"
    Write-Host "f - Gestion Logiciel"
    Write-Host "g - Gestion Bureau à Distance"
    Write-Host "q - Quitter"
}

# Boucle principale du menu
do {
    Afficher-Menu
    $choix = Read-Host "Entrez votre choix"

    switch ($choix) {
        'a' { 
            Clear-Host
            Write-Host "Vous avez choisi Gestion Compte"
            # Gestion des comptes
            Pause
        }
        'b' { 
            Clear-Host
            Write-Host "Vous avez choisi Gestion Groupe"
            # Ajoutez ici votre code pour la gestion des groupes
            Pause
        }
        'c' { 
            Clear-Host
            Write-Host "Vous avez choisi Gestion Système"
            # Ajoutez ici votre code pour la gestion du système
            Pause
        }
        'd' { 
            Clear-Host
            Write-Host "Vous avez choisi Gestion Répertoire"
            # Ajoutez ici votre code pour la gestion des répertoires
            Pause
        }
        'e' { 
            Clear-Host
            Write-Host "Vous avez choisi Gestion Sécurité"
            # Ajoutez ici votre code pour la gestion de la sécurité
            Pause
        }
        'f' { 
            Clear-Host
            Write-Host "Vous avez choisi Gestion Logiciel"
            # Ajoutez ici votre code pour la gestion des logiciels
            Pause
        }
        'g' { 
            Clear-Host
            Write-Host "Vous avez choisi Gestion Bureau à Distance"
            # Ajoutez ici votre code pour la gestion du Bureau à Distance
            Pause
        }
        'q' {
            Write-Host "See you soon !"
            break
        }
        default {
            Write-Host "Choix invalide, veuillez réessayer."
            Pause
        }
    }
} while ($choix -ne 'q')

function Pause {
    Write-Host ""
    Write-Host "Appuyez sur Entrée pour revenir au menu..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
}



                            #2menu information
                                #a-info user
                                    #script recherche event fichier log_evt.log user
                                    #1 Date de dernière connexion d’un utilisateur
                                    #2 Date de dernière modification du mot de passe
                                    #3 Liste des sessions ouvertes par l'utilisateur
                                    #4 Groupe d’appartenance d’un utilisateur
                                    #5 Historique des commandes exécutées par l'utilisateur
                                    #6 Droits/permissions de l’utilisateur sur un dossier
                                #b-info system client
                                    #script recherche event fichier log_evt.log system
                                    #1 Version de l'OS
                                    #2 Nombre de disque
                                    #3 Partition (nombre, nom, FS, taille) par disque
                                    #4 Espace disque restant par partition/volume
                                    #5 Nom et espace disque d'un dossier (nom de dossier demandé)
                                    #6 Liste des lecteurs monté (disque, CD, etc.)
                                    #7 Nombre d'interface
                                    #8 Adresse IP de chaque interface
                                    #9 Adresse Mac
                                    #10 Liste des ports ouverts
                                    #11 Statut du pare-feu
                                    

                            #3execution a distance




