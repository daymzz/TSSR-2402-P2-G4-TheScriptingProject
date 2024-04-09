# Définitions des fonctions vides
function ActionCompte {
    
}

function ActionGroupe {
    
}

function ActionSysteme {
  
}

function ActionRepertoire {
   
}

function ActionSecurite {
    
}

function ActionLogiciel {
    
}

function ActionBureauADistance {
    
}

function InformationUtilisateur {
    
}

function InformationSysteme {
    
}

# Boucle principale du menu
while ($true) {
    Afficher-MenuPrincipal
    Clear-Host
    Write-Host "=============="
    Write-Host "Menu Principal"
    Write-Host "=============="
    Write-Host "1 - Menu Action"
    Write-Host "2 - Menu Information"
    Write-Host "3 - Quitter"
    $choixMenuPrincipal = Read-Host "Entrez votre choix"
    
    param(
        [int]$choixMenuPrincipal
    )
    switch ($choixMenuPrincipal) {

        1 {
            Clear-Host
            Write-Host "==============="
            Write-Host "Menu de Action"
            Write-Host "==============="
            Write-Host "1 - Action Utilisateur"
            Write-Host "2 - Action Groupe"
            Write-Host "3 - Action Système"
            Write-Host "4 - Action Répertoire"
            Write-Host "5 - Action Sécurité"
            Write-Host "6 - ActionLogiciel"
            Write-Host "7 - ActionBureau à Distance"
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
                '8' { break }
            }
        }

        2 {
            Clear-Host
            Write-Host "==============="
            Write-Host "Menu d'Information"
            Write-Host "==============="
            Write-Host "1 - Information Utilisateur"
            Write-Host "2 - Information Système"
            Write-Host "3 - Quitter"
            $choixMenuInformation = Read-Host "Entrez votre choix"
            switch ($choixMenuInformation) {
                1 { Information-Utilisateur }
                2 { Information-Systeme }
                3 { break }
            }
        }

        '3' { exit}

    }

}
