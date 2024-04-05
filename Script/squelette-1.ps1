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

function MenuAction {
    Clear-Host
    Write-Host "==============="
    Write-Host "Menu de Gestion"
    Write-Host "==============="
    Write-Host "A - Gestion Compte"
    Write-Host "B - Gestion Groupe"
    Write-Host "C - Gestion Système"
    Write-Host "D - Gestion Répertoire"
    Write-Host "E - Gestion Sécurité"
    Write-Host "F - Gestion Logiciel"
    Write-Host "G - Gestion Bureau à Distance"
    Write-Host "Q - Quitter"
}

# Boucle principale du menu de gestion
do {
    MenuAction  # Correction du nom de la fonction
    $choix = Read-Host "Entrez votre choix"

    switch ($choix) {
        # Menu pour la gestion des comptes
        'A' { 
            Clear-Host
            Write-Host "Vous avez choisi Gestion Compte"
           
            Pause
        }
        # Menu pour la gestion des groupes
        'B' { 
            Clear-Host
            Write-Host "Vous avez choisi Gestion Groupe"
            
            Pause
        }
        # Menu pour la gestion du système
        'C' { 
            Clear-Host
            Write-Host "Vous avez choisi Gestion Système"
            # Ajoutez ici votre code pour la gestion du système
            Pause
        }
        # Menu pour la gestion des répertoires
        'D' { 
            Clear-Host
            Write-Host "Vous avez choisi Gestion Répertoire"
           
            Pause
        }
        # Menu pour la gestion de la sécurité
        'E' { 
            Clear-Host
            Write-Host "Vous avez choisi Gestion Sécurité"
         
            Pause
        }
        # Menu pour la gestion des logiciels
        'F' { 
            Clear-Host
            Write-Host "Vous avez choisi Gestion Logiciel"
            
            Pause
        }
        # Menu pour la gestion du Bureau à Distance
        'G' { 
            Clear-Host
            Write-Host "Vous avez choisi Gestion Bureau à Distance"
            
            Pause
            
        # Menu pour Quitter
        }
        'Q' {
            Write-Host "A bientôt !"
            break
        }
        default {
            Write-Host "Choix invalide, veuillez réessayer."
            Pause
        }
    }
} while ($choix -ne 'Q')


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




