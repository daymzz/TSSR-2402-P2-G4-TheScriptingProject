#!/bin/bash

######################### https://github.com/RehanSaeed/Bash-Cheat-Sheet ###################################
################################### liste de commandes bash ################################################
############################################################################################################
#######################################   action fonction   ################################################
############################################################################################################

ip=""
utilisateur=""

function gestion_utilisateur() {

    #Création de compte utilisateur local avec mot de passe :
    function create_user() {
        read -p "Entrez le nom de l'utilisateur à créer : " user
        if ssh $utilisateur@$ip "getent passwd $user > /dev/null 2>&1"; then
            echo "L'utilisateur $user existe déjà."
            return 1
        else
            ssh $utilisateur@$ip "sudo -S useradd -m $user"
            echo "Utilisateur $user créé."
            return 0
        fi
    }

    #ajouter un mot de passe :
    function add_Mdp() {
        read -p "Entrez le nom d'utilisateur à ajouter un mot de passe : " add_MDP_user
        read -s -p "Entrez le mot de passe : " password
        ssh $utilisateur@$ip "echo '$add_MDP_user:$password' | sudo -S chpasswd" #La commande chpasswd administre les mots de passe des utilisateurs.
        echo "Ajout de mot de passe réussi pour $add_MDP_user."
    }

    #Changement de mot de passe :
    function changeMDP() {
        read -p "Entrez le nom d'utilisateur pour changer le mot de passe : " user
        read -s -p "Entrez le nouveau mot de passe : " password
        ssh $utilisateur@$ip "echo '$user:$password' | sudo -S chpasswd" #La commande chpasswd administre les mots de passe des utilisateurs.
        echo "Modification de mot de passe réussie pour $user."
    }
    #Suppression de compte utilisateur local :
    function del_user() {
        read -p "Entrez le nom d'utilisateur à supprimer : " suppr_user
        read -p "Voulez-vous vraiment supprimer le compte utilisateur $suppr_user ? (O/N) " delrep
        if [[ "$delrep" == "O" ]]; then
            ssh $utilisateur@$ip "sudo -S deluser --remove-home $suppr_user"
            echo "Suppression de $suppr_user réussie."
            return 0
        else
            echo "Suppression annulée."
            return 1
        fi
    }

    #Activation de compte utilisateur local :
    function activ_User() {
        read -p "Entrez le nom d'utilisateur à activer : " activer_user
        ssh $utilisateur@$ip "sudo -S usermod -U $activer_user"
        echo "Activation de l'utilisateur $activer_user réussie."
    }

    #Désactivation de compte utilisateur local :
    function desactiv_User() {
        read -p "Entrez le nom d'utilisateur à désactiver : " desactiver_user
        ssh $utilisateur@$ip "sudo -S usermod -L $desactiver_user"
        echo "Désactivation de $desactiver_user réussie."
    }


    while true; do
        clear
        echo "Menu de gestion d'utilisateurs :"
        echo "1. Créer un utilisateur"
        echo "2. Ajouter un mot de passe"
        echo "3. Changer le mot de passe"
        echo "4. Supprimer un utilisateur"
        echo "5. Activer un utilisateur"
        echo "6. Désactiver un utilisateur"
        echo "7. Quitter"
        read -p "Choisissez une option : " choix

        case $choix in
            1) create_user ;;
            2) add_Mdp ;;
            3) changeMDP ;;
            4) del_user ;;
            5) activ_User ;;
            6) desactiv_User ;;
            7) echo "Au revoir !"; break ;;
            *) echo "Option non valide. Veuillez choisir une option valide." ;;
        esac
    done
}

function gestion_groupe() {
    
    #Ajout à un groupe d'administrateur :
    #-nG affiche les noms de tous les groupes auxquels appartient l'utilisateur
    function add_admin() {
        read -p "Entrer le nom d'utilisateur à ajouter en administrateur : " admin_add_user
        #l'option -nG pour afficher uniquement les noms des groupes et 
        # -qw Mode silencieux et s'assure qu'il es un mot entier
        if ssh $utilisateur@$ip "id -nG "$admin_add_user" | grep -qw sudo -S"; then
            echo "Cet utilisateur est déjà dans le groupe administrateur."
            return 1
        else
            # l-option -a ajoute au -G groupe indiqué apres
            ssh $utilisateur@$ip "sudo -S usermod -aG sudo -S "$admin_add_user""
            echo "Ajout de $admin_add_user en tant qu'administrateur réussi."
            return 0
        fi
    }

    #Ajout à un groupe local :
    function add_Grp_local() {
        read -p "Entrer le nom d'utilisateur à ajouter au groupe local : " user_add_grp
        # l'option -nG pour afficher uniquement les noms groupes
        if ssh $utilisateur@$ip "id -nG "$user_add_grp" | grep -qw users"; then
            echo "Cet utilisateur est déjà dans le groupe local."
            return 1
        else
        # l-option -a ajoute au -G groupe indiqué apres
            ssh $utilisateur@$ip "sudo -S usermod -aG users "$user_add_grp""
            echo "Ajout de $user_add_grp au groupe local réussi."
            return 0
        fi
    }

    #Sortie d'un groupe local :
    function sortie_Grp_local() {
        read -p "Entrer le nom d'utilisateur à sortir du groupe local : " leave_grp
        # l'option -nG pour afficher uniquement les noms groupes
        if ssh $utilisateur@$ip "id -nG "$leave_grp" | grep -qw users"; then
            ssh $utilisateur@$ip "sudo -S deluser "$leave_grp" users"
            echo "Sortie de $leave_grp du groupe local réussie."
            return 0
        else
            echo "Cet utilisateur n'est pas dans le groupe local."
            return 1
        fi
    }

    
    while true; do
        clear
        echo "Menu de gestion de groupe :"
        echo "1. Ajouter un utilisateur au groupe d'administrateurs"
        echo "2. Ajouter un utilisateur à un groupe local"
        echo "3. Retirer un utilisateur d'un groupe local"
        echo "4. Quitter"
        read -p "Choisissez une option : " choix

        case $choix in
            1) add_admin ;;
            2) add_Grp_local ;;
            3) sortie_Grp_local ;;
            4) echo "Au revoir !"; return ;;
            *) echo "Option non valide. Veuillez choisir une option valide." ;;
        esac
    done
}


function gestion_systeme() {

    # Arrêt de l'ordinateur
    function stop_ordi() {
        echo "Arrêt de l'ordinateur client..."
        ssh $utilisateur@$ip "sudo -S shutdown -h now"
        sleep 3
        # l'option -h indique a la commande d'arreter le systeme l'option now maintenant
    }

    # Redémarrage de l'ordinateur
    function restart_ordi() {
        echo "L'ordinateur va redémarrer..."
        ssh $utilisateur@$ip "sudo -S reboot"
        sleep 3
    }

    # Verrouillage de l'ordinateur
    function verrouiller_ordi() {
        echo "L'ordinateur va être mis en veille..."
        ssh $utilisateur@$ip "sudo -S systemctl suspend"
        sleep 3
    }

    # Mise à jour du système
    function maj_systeme() {
        echo "Mise à jour du système en cours..."
        ssh $utilisateur@$ip "sudo -S apt update && sudo -S apt upgrade -y"
        sleep 3
    }

    # Menu de gestion du système
    while true; do
        clear
        echo "Menu de gestion du système :"
        echo "1. Arrêter l'ordinateur"
        echo "2. Redémarrer l'ordinateur"
        echo "3. Mettre l'ordinateur en veille"
        echo "4. Mettre à jour le système"
        echo "5. Quitter"
        read -p "Choisissez une option : " choix

        case $choix in
            1) stop_ordi ;;
            2) restart_ordi ;;
            3) verrouiller_ordi ;;
            4) maj_systeme ;;
            5) echo "Au revoir !"; return ;;
            *) echo "Option non valide. Veuillez choisir une option valide." ;;
        esac
    done
}

function gestion_repertoire() {
    # Création de répertoire
    function create_directory() {
        read -p "Entrez le nom du dossier à créer: " create_dossier
        ssh $utilisateur@$ip "mkdir -p "$create_dossier""
        echo "Création du répertoire $create_dossier réussie."
    }

    # Modification de répertoire
    function modify_directory() {
        read -p "Entrez le nom de dossier à modifier: " mod_dossier
        read -p "Entrez le nouveau nom du dossier: " new_dossier
        ssh $utilisateur@$ip "mv "$mod_dossier" "$new_dossier""
        echo "Modification du répertoire $mod_dossier en $new_dossier réussie."
    }

    # Suppression de répertoire
    function del_directory() {
        read -p "Entrez le nom du dossier à supprimer: " del_dossier
        ssh $utilisateur@$ip "rm -rf "$del_dossier""
        echo "Suppression du répertoire $del_dossier réussie."
    }

    # Menu de gestion de répertoire
    while true; do
        clear
        echo "Menu de gestion de répertoires :"
        echo "1. Créer un répertoire"
        echo "2. Modifier un répertoire"
        echo "3. Supprimer un répertoire"
        echo "4. Quitter"
        read -p "Choisissez une option: " choix

        case $choix in
            1) create_directory ;;
            2) modify_directory ;;
            3) del_directory ;;
            4) echo "Au revoir !"; return ;;
            *) echo "Option non valide. Veuillez choisir une option valide." ;;
        esac
    done
}

function gestion_securite() {

    # Activation du pare-feu
    function activer_pare_feu() {
        ssh $utilisateur@$ip "sudo -S ufw enable"
        echo "Activation du pare-feu réussie."
    }

    # Désactivation du pare-feu
    function desactiver_pare_feu() {
        ssh $utilisateur@$ip "sudo -S ufw disable"
        echo "Désactivation du pare-feu réussie."
    }

    # Menu de gestion de la sécurité
    while true; do
        clear
        echo "Menu de gestion de la sécurité :"
        echo "1. Activer le pare-feu"
        echo "2. Désactiver le pare-feu"
        echo "3. Quitter"
        read -p "Choisissez une option : " choix

        case $choix in
            1) activer_pare_feu ;;
            2) desactiver_pare_feu ;;
            3) echo "Retour au menu principal."; return ;;
            *) echo "Option non valide. Veuillez choisir une option valide." ;;
        esac
    done
}
function  gestion_prise_main_distance () {
    ssh $utilisateur@$ip
}

function gestion_information() {


    # Date de dernière connexion
    function date_derniere_connexion() {
        clear
        read -p "Entrez le nom d'utilisateur : " lastlog_user
        echo "Affiche la date de dernière connexion de $lastlog_user"
        ssh $utilisateur@$ip "sudo -S lastlog $lastlog_user"
        sleep 5
        return 
    }

    # Date de dernière modification du mot de passe
    function date_derniere_modif_mot_de_passe() {
        clear
        read -p "Entrez le nom d'utilisateur : " lastmodif_user
        echo "Affiche la date de dernière modification du mot de passe pour $lastmodif_user"
        ssh $utilisateur@$ip "sudo -S chage -l $lastmodif_user"
        sleep 5
        return 
    }

    # Liste des sessions ouvertes par l'utilisateur
    function liste_sessions_utilisateur() {
        clear
        read -p "Entrez le nom d'utilisateur : " user_session
        echo "Affiche la liste des sessions ouvertes par $user_session"
        ssh $utilisateur@$ip "w -u $user_session"
        sleep 5
        return 
    }

    # Groupe d'appartenance d'un utilisateur
    function groupe_appartenance_utilisateur() {
        clear
        read -p "Entrez le nom d'utilisateur : " grp_user
        echo "Affiche le groupe d'appartenance de $grp_user"
        ssh $utilisateur@$ip "groups $grp_user"
        sleep 5
        return 
    }

    # Droits et permissions sur un dossier
    function droits_permissions_dossier() {
        clear
        read -p "Entrez le chemin du dossier, ex: /home/user/repertoire/dossier : " road_directory
        echo "Affiche les droits et permissions sur le dossier $road_directory"
        ssh $utilisateur@$ip "ls -ld \"$road_directory\""
        sleep 5
        return 
    }

    # Droits et permissions sur un fichier
    function droits_permissions_fichier() {
        clear
        read -p "Entrez le chemin du fichier, ex: /home/user/directory/file.txt : " road_file
        echo "Affiche les droits et permissions sur le fichier $road_file"
        ssh $utilisateur@$ip "ls -l \"$road_file\""
        sleep 5
        return 
    }

    # Version de l'OS, nombre de disques, partitions, etc.
    function version_os() {
        clear
        echo "Affichage de la version de l'OS du client"
        ssh $utilisateur@$ip "lsb_release -a"
        sleep 5
        return 
    }

    #Nombre de disques de l'ordinateur client :
    function nombre_disques() {
        clear
        echo "Affiche le nombre de disque du client"
        ssh $utilisateur@$ip "lsblk | grep disk | wc -l"
        sleep 5
        return 
    }

    #Partition par disque de l'ordinateur client :
    function partition_par_disque() {
        clear
        echo "Affichage des informations sur les partitions par disque du client"
        ssh $utilisateur@$ip "lsblk | grep sd"
        sleep 5
        return 
    }
    #Nom et espace disque d'un dossier :

    function espace_disque_dossier () {
        clear
        ssh $utilisateur@$ip "df -h #/chemin/du/dossier"
        echo "Affiche le nom et l'espace disque du dossier"
        sleep 5
        return 
        
    }

    #Liste des lecteurs montés :

    function lecteurs_montes () {
        clear
        ssh $utilisateur@$ip "df -h"
        echo "Affiche le liste des lecteurs montés"
        sleep 5
        return 
        
    }

    #Nombre d'interfaces et adresse ip :

    function interfaces_ip () {
        clear
        ssh $utilisateur@$ip "sudo -S netstat -i | --interfaces && ip addr" #a verifier 
        echo "Affiche le nombre d'interfaces et leur adresse ip"
        sleep 5
        return 
    }

    #Liste des ports ouverts :

    function ports_ouverts () {
        clear
        ssh $utilisateur@$ip "sudo -S netstat -l | --listening && ip addr"
        echo "Affiche la liste des ports ouverts"
        sleep 5
        return 
    }

    #Statut du pare-feu :



    function statut_pare_feu () {
        clear
        ssh $utilisateur@$ip "sudo -S ufw status"
        echo "Affiche le statut du pare-feu"
        sleep 5
        return 
    }

    #Recherche des événements dans le fichier log_evt.log pour un utilisateur :

    function recherche_evenements_utilisateur () {
        clear
        ssh $utilisateur@$ip "grep "nom_user" #/chemin/dufichier/log_evt.log"
        echo "Affiche es evenements du fichier log_evt.log pour un utilisateur"
        sleep 5
        return 
    }

    #Recherche des événements dans le fichier log_evt.log pour un ordinateur :

    function recherche_evenements_ordinateur () {
        clear
        ssh $utilisateur@$ip "grep "adresse_ip" #/chemin/dufichier/log_evt.log"
        echo "Affiche les événements du fichier log_evt.log pour un ordinateur"
        sleep 5
        return 
    }

    # Menu de gestion des informations
    while true; do
        clear
        echo "==========================="
        echo "       Menu Information:"
        echo "==========================="
        echo "Menu de gestion des informations :"
        echo "1. Date de dernière connexion d'un utilisateur"
        echo "2. Date de dernière modification du mot de passe"
        echo "3. Liste des sessions ouvertes par l'utilisateur"
        echo "4. Groupe d'appartenance d'un utilisateur"
        echo "5. Droits et permissions sur un dossier"
        echo "6. Droits et permissions sur un fichier"
        echo "7. Version de l'OS du client"
        echo "8. Nombre de disques du client"
        echo "9. Informations sur les partitions par disque"
        echo "10. Nom et espace disque d'un dossier "
        echo "11. Liste des lecteurs montés"
        echo "12. Nombre d'interfaces et adresse ip"
        echo "13. Liste des ports ouverts "
        echo "14. Statut du pare-feu "
        echo "15. Recherche des événements dans le fichier log_evt.log pour un utilisateur"
        echo "16. Recherche des événements dans le fichier log_evt.log pour un ordinateur"
        echo "17. Quitter"
        read -p "Choisissez une option : " choix

        case $choix in
            1) date_derniere_connexion ;;
            2) date_derniere_modif_mot_de_passe ;;
            3) liste_sessions_utilisateur ;;
            4) groupe_appartenance_utilisateur ;;
            5) droits_permissions_dossier ;;
            6) droits_permissions_fichier ;;
            7) version_os ;;
            8) nombre_disques ;;
            9) partition_par_disque ;;
            10) espace_disque_dossier ;;
            11) lecteurs_montes ;;
            12) interfaces_ip ;;
            13) ports_ouverts ;;
            14) statut_pare_feu ;;
            15) recherche_evenements_utilisateur ;; 
            16) recherche_evenements_ordinateur ;;
            17) echo "Retour au menu principal."; clear;return ;;
            *) echo "Option non valide. Veuillez choisir une option valide." ;;
        esac
    done
}

function connexion () {
    read -p "IP du serveur : " ip
    read -p "Nom d'utilisateur pour la connexion SSH : " utilisateur

}

function menu_action () {
    while true; do
        clear
        echo "==========================="
        echo "       Menu Action:"
        echo "==========================="
        echo "1. Gestion des utilisateurs"
        echo "2. Gestion des groupes"
        echo "3. Gestion du système"
        echo "4. Gestion des répertoires"
        echo "5. Gestion prise en main à distance"
        echo "7. Retour menu principal"
        read -p "Choisissez une option : " choix
        case $choix in
            1) gestion_utilisateur ;;
            2) gestion_groupe ;;
            3) gestion_systeme ;;
            4) gestion_repertoire ;;
            5) gestion_prise_main_distance ;;
            7) echo "Au revoir !!!!!"; clear;return ;;
            *) echo "Option non valide !?!?!?" ;;
        esac
        done
}

while true; do
clear
echo "==========================="
echo "      Menu principal       "
echo "==========================="
echo "1. Menu Action"
echo "2. Menu des informations"
echo "3. Connexion"
echo "4. Quitter"
read -p "Choisissez une option : " choix
case $choix in
    1) menu_action;;
    2) gestion_information ;;
    3) connexion;;
    4) echo "Au revoir !!!!!"; clear; exit  ;;
    *) echo "Option non valide !?!?!?" ;;
esac
done