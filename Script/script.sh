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
        echo "$(date +%F-%X) - $USER - Création d'un utilisateur" >> /var/log/log_evt.log
        if ssh $utilisateur@$ip "getent passwd $user > /dev/null 2>&1"; then
            echo "L'utilisateur $user existe déjà."
	        sleep 2
            echo "$(date +%F-%X) - $USER - ECHEC création de l'utilisateur $user" >> /var/log/log_evt.log
            return 1
        else
            ssh $utilisateur@$ip "sudo -S useradd -m $user"
            echo "Utilisateur $user créé."
	        sleep 2
            echo "$(date +%F-%X) - $USER - REUSSITE Création $user" >> /var/log/log_evt.log
            return 0
        fi
    }

    #ajouter un mot de passe :
    function add_Mdp() {
        read -p "Entrez le nom d'utilisateur à ajouter un mot de passe : " add_MDP_user
        read -s -p "Entrez le mot de passe : " password
        echo "$(date +%F-%X) - $USER - Ajout de mot de passe pour $add_MDP_user" >> /var/log/log_evt.log
        ssh $utilisateur@$ip "echo '$add_MDP_user:$password' | sudo -S chpasswd" #La commande chpasswd administre les mots de passe des utilisateurs.
        echo "Ajout de mot de passe réussi pour $add_MDP_user."
	    sleep 2
        echo "$(date +%F-%X) - $USER - REUSSITE ajout de mot de passe pour $add_MDP_user" >> /var/log/log_evt.log
    }

    #Changement de mot de passe :
    function changeMDP() {
        read -p "Entrez le nom d'utilisateur pour changer le mot de passe : " user
        read -s -p "Entrez le nouveau mot de passe : " password
        echo "$(date +%F-%X) - $USER - Changement de mot de passe pour $user" >> /var/log/log_evt.log
        ssh $utilisateur@$ip "echo '$user:$password' | sudo -S chpasswd" #La commande chpasswd administre les mots de passe des utilisateurs.
        echo "REUSSITE modification de mot de passe pour $user."
	    sleep 2
        echo "$(date +%F-%X) - $USER - REUSSITE changement de mot de passe pour $user" >> /var/log/log_evt.log
    }
    #Suppression de compte utilisateur local :
    function del_user() {
        read -p "Entrez le nom d'utilisateur à supprimer : " suppr_user
        read -p "Voulez-vous vraiment supprimer le compte utilisateur $suppr_user ? (O/N) " delrep
        echo "$(date +%F-%X) - $USER - Suppression de l'utilisateur local $suppr_user" >> /var/log/log_evt.log
        if [[ "$delrep" == "O" ]]; then
            ssh $utilisateur@$ip "sudo -S deluser --remove-home $suppr_user"
            echo "Suppression de $suppr_user réussie."
	        sleep 2
            echo "$(date +%F-%X) - $USER - REUSSITE suppression de $suppr_user" >> /var/log/log_evt.log
            return 0
        else
            echo "Suppression annulée."
	        sleep 2
            echo "$(date +%F-%X) - $USER - ECHEC de la suppression de l'utilisateur " >> /var/log/log_evt.log
            return 1
        fi
    }

    #Activation de compte utilisateur local :
    function activ_User() {
        read -p "Entrez le nom d'utilisateur à activer : " activer_user
        echo "$(date +%F-%X) - $USER - Activation d'un utilisateur" >> /var/log/log_evt.log
        ssh $utilisateur@$ip "sudo -S usermod -U $activer_user"
        echo "Activation de l'utilisateur $activer_user réussie."
	    sleep 2
        echo "$(date +%F-%X) - $USER - REUSSITE activation de l'utilisateur $activer_user" >> /var/log/log_evt.log
    }

    #Désactivation de compte utilisateur local :
    function desactiv_User() {
        read -p "Entrez le nom d'utilisateur à désactiver : " desactiver_user
        echo "$(date +%F-%X) - $USER - Désactivation d'un utilisateur" >> /var/log/log_evt.log
        ssh $utilisateur@$ip "sudo -S usermod -L $desactiver_user"
        echo "Désactivation de $desactiver_user réussie."
	    sleep 2
        echo "$(date +%F-%X) - $USER - REUSSITE désactivation de l'utilisateur $desactiver_user" >> /var/log/log_evt.log 

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
        echo "0. Retour"
        read -p "Choisissez une option : " choix

        case $choix in
            1) create_user ;;
            2) add_Mdp ;;
            3) changeMDP ;;
            4) del_user ;;
            5) activ_User ;;
            6) desactiv_User ;;
            0) clear ;echo "Retour au menu action" ;sleep 2 ;echo "$(date +%F-%X) - $USER - Retour au menu action " >> /var/log/log_evt.log ;break ;;
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
        echo "$(date +%F-%X) - $USER - Ajout d'un utilisateur en groupe administrateur" >> /var/log/log_evt.log 
        if ssh $utilisateur@$ip "id -nG "$admin_add_user" | grep -qw sudo -S"; then
            echo "Cet utilisateur est déjà dans le groupe administrateur."
	        sleep 2
            echo "$(date +%F-%X) - $USER - $admin_add_user déjà ajouté au groupe administrateur" >> /var/log/log_evt.log 
            return 1
        else
            # l-option -a ajoute au -G groupe indiqué apres
            ssh $utilisateur@$ip "sudo -S usermod -aG sudo -S "$admin_add_user""
            echo "Ajout de $admin_add_user en tant qu'administrateur réussi."
	        sleep 2
            echo "$(date +%F-%X) - $USER - REUSSITE ajout $admin_add_user au groupe administrateur" >> /var/log/log_evt.log 
            return 0
        fi
    }

    #Ajout à un groupe local :
    function add_Grp_local() {
        read -p "Entrer le nom d'utilisateur à ajouter au groupe local : " user_add_grp
        # l'option -nG pour afficher uniquement les noms groupes
        echo "$(date +%F-%X) - $USER - Ajout au groupe local" >> /var/log/log_evt.log 
        if ssh $utilisateur@$ip "id -nG "$user_add_grp" | grep -qw users"; then
            echo "Cet utilisateur est déjà dans le groupe local."
	        sleep 2
            echo "$(date +%F-%X) - $USER - $user_add_grp déjà ajouté au groupe local" >> /var/log/log_evt.log 
            return 1
        else
        # l-option -a ajoute au -G groupe indiqué apres
            ssh $utilisateur@$ip "sudo -S usermod -aG users "$user_add_grp""
            echo "Ajout de $user_add_grp au groupe local réussi."
	        sleep 2
            echo "$(date +%F-%X) - $USER - REUSSITE ajout $user_add_grp au groupe local" >> /var/log/log_evt.log 
            return 0
        fi
    }

    #Sortie d'un groupe local :
    function sortie_Grp_local() {
        read -p "Entrer le nom d'utilisateur à sortir du groupe local : " leave_grp
        # l'option -nG pour afficher uniquement les noms groupes
        echo "$(date +%F-%X) - $USER - Sortie du groupe local" >> /var/log/log_evt.log 
        if ssh $utilisateur@$ip "id -nG "$leave_grp" | grep -qw users"; then
            ssh $utilisateur@$ip "sudo -S deluser "$leave_grp" users"
            echo "Sortie de $leave_grp du groupe local réussie."
	        sleep 2
            echo "$(date +%F-%X) - $USER - REUSSITE sortie de $leave_grp du groupe local" >> /var/log/log_evt.log 
            return 0
        else
            echo "Cet utilisateur n'est pas dans le groupe local."
	        sleep 2
            echo "$(date +%F-%X) - $USER - l'utilisateur n'est pas dans le groupe local" >> /var/log/log_evt.log 
            return 1
        fi
    }

    
    while true; do
        clear
        echo "Menu de gestion de groupe :"
        echo "1. Ajouter un utilisateur au groupe d'administrateurs"
        echo "2. Ajouter un utilisateur à un groupe local"
        echo "3. Retirer un utilisateur d'un groupe local"
        echo "0. Retour"
        read -p "Choisissez une option : " choix

        case $choix in
            1) add_admin ;;
            2) add_Grp_local ;;
            3) sortie_Grp_local ;;
            0) clear ;echo "Retour au menu action " ;sleep 2 ;echo "$(date +%F-%X) - $USER - Retour menu action " >> /var/log/log_evt.log ;return ;;
            *) echo "Option non valide. Veuillez choisir une option valide." ;;
        esac
    done
}


function gestion_systeme() {

    # Arrêt de l'ordinateur
    function stop_ordi() {
        echo "Arrêt de l'ordinateur client..."
        ssh $utilisateur@$ip "sudo -S shutdown -h now"
        echo "$(date +%F-%X) - $USER - Arrêt de l'ordinateur $ip" >> /var/log/log_evt.log 
        sleep 3
        # l'option -h indique a la commande d'arreter le système l'option now maintenant
    }

    # Redémarrage de l'ordinateur
    function restart_ordi() {
        echo "L'ordinateur va redémarrer..."
        ssh $utilisateur@$ip "sudo -S reboot"
        echo "$(date +%F-%X) - $USER - Redémarrage de l'ordinateur $ip" >> /var/log/log_evt.log 
        sleep 3
    }

    # Verrouillage de l'ordinateur
    function verrouiller_ordi() {
        echo "L'ordinateur va être mis en veille..."
        ssh $utilisateur@$ip "sudo -S systemctl suspend"
        echo "$(date +%F-%X) - $USER - Mise en veille de l'ordinateur $ip" >> /var/log/log_evt.log 
        sleep 3
    }

    # Mise à jour du système
    function maj_systeme() {
        echo "Mise à jour du système en cours..."
        ssh $utilisateur@$ip "sudo -S apt update && sudo -S apt upgrade -y"
        echo "$(date +%F-%X) - $USER - Mise à jour de l'ordinateur $ip" >> /var/log/log_evt.log 
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
        echo "0. Retour"
        read -p "Choisissez une option : " choix

        case $choix in
            1) stop_ordi ;;
            2) restart_ordi ;;
            3) verrouiller_ordi ;;
            4) maj_systeme ;;
            0) clear ;echo "Retour au menu action " ;sleep 2 ;echo "$(date +%F-%X) - $USER - Retour au menu action " >> /var/log/log_evt.log  ;return ;;
            *) echo "Option non valide. Veuillez choisir une option valide." ;;
        esac
    done
}

function gestion_repertoire() {
    # Création de répertoire
    function create_directory() {
        read -p "Entrez le nom du dossier à créer: " create_dossier
        echo "$(date +%F-%X) - $USER - Création d'un répertoire" >> /var/log/log_evt.log 
        ssh $utilisateur@$ip "mkdir -p "$create_dossier""
        echo "Création du répertoire $create_dossier réussie."
	sleep 2
        echo "$(date +%F-%X) - $USER - REUSSITE création du répertoire $create_dossier" >> /var/log/log_evt.log 
    }

    # Modification de répertoire
    function modify_directory() {
        read -p "Entrez le nom de dossier à modifier: " mod_dossier
        read -p "Entrez le nouveau nom du dossier: " new_dossier
        echo "$(date +%F-%X) - $USER - Modification de nom du répertoire" >> /var/log/log_evt.log 
        ssh $utilisateur@$ip "mv "$mod_dossier" "$new_dossier""
        echo "Modification du répertoire $mod_dossier en $new_dossier réussie."
	    sleep 2
        echo "$(date +%F-%X) - $USER - REUSSITE modification de nom du répertoire $mod_dossier en $new_dossier" >> /var/log/log_evt.log 
    }

    # Suppression de répertoire
    function del_directory() {
        read -p "Entrez le nom du dossier à supprimer: " del_dossier
        echo "$(date +%F-%X) - $USER - Suppression d'un répertoire" >> /var/log/log_evt.log 
        ssh $utilisateur@$ip "rm -rf "$del_dossier""
        echo "Suppression du répertoire $del_dossier réussie."
	    sleep 2
        echo "$(date +%F-%X) - $USER - REUSSITE suppression du répertoire $del_dossier" >> /var/log/log_evt.log 
    }

    # Menu de gestion de répertoire
    while true; do
        clear
        echo "Menu de gestion de répertoires :"
        echo "1. Créer un répertoire"
        echo "2. Modifier un répertoire"
        echo "3. Supprimer un répertoire"
        echo "0. Retour"
        read -p "Choisissez une option: " choix

        case $choix in
            1) create_directory ;;
            2) modify_directory ;;
            3) del_directory ;;
            0) clear ;echo "Retour au menu action " ;sleep 2 ;echo "$(date +%F-%X) - $USER - Retour au menu action " >> /var/log/log_evt.log ;return ;;
            *) echo "Option non valide. Veuillez choisir une option valide." ;;
        esac
    done
}

function gestion_securite() {

    # Activation du pare-feu
    function activer_pare_feu() {
        ssh $utilisateur@$ip "sudo -S ufw enable"
        echo "Activation du pare-feu réussie."
	    sleep 2
        echo "$(date +%F-%X) - $USER - Activation du pare-feu" >> /var/log/log_evt.log 
    }

    # Désactivation du pare-feu
    function desactiver_pare_feu() {
        ssh $utilisateur@$ip "sudo -S ufw disable"
        echo "Désactivation du pare-feu réussie."
	    sleep 2
        echo "$(date +%F-%X) - $USER - Désactivation du pare-feu" >> /var/log/log_evt.log 
    }

    # Menu de gestion de la sécurité
    while true; do
        clear
        echo "Menu de gestion de la sécurité :"
        echo "1. Activer le pare-feu"
        echo "2. Désactiver le pare-feu"
        echo "0. Retour"
        read -p "Choisissez une option : " choix

        case $choix in
            1) activer_pare_feu ;;
            2) desactiver_pare_feu ;;
            0) clear ;echo "Retour au menu action " ;sleep 2 ;echo "$(date +%F-%X) - $USER - Retour au menu action " >> /var/log/log_evt.log ;return ;;
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
	    local fichier="$HOME/Documents/${utilisateur}_$(date +%F).txt"
        echo "Affiche la date de dernière connexion"
        ssh $utilisateur@$ip "sudo -S w -u"
	    sleep 5
	    ssh $utilisateur@$ip "sudo -S w -u" >> "$fichier"
        echo "$(date +%F-%X) - $USER - Date de dernière connexion" >> /var/log/log_evt.log
        return 
    }

    # Date de dernière modification du mot de passe
    function date_derniere_modif_mot_de_passe() {
        clear
	    local fichier="$HOME/Documents/${utilisateur}_$(date +%F).txt"
        lastmodif_user=""
        read -p "Entrez le nom d'utilisateur : " lastmodif_user
        echo "Affiche la date de dernière modification du mot de passe pour $lastmodif_user"
	    ssh $utilisateur@$ip "sudo -S chage -l $lastmodif_user"
	    sleep 5
        ssh $utilisateur@$ip "sudo -S chage -l $lastmodif_user" >> "$fichier"
        echo "$(date +%F-%X) - $USER - Date de dernière modification du mot de passe de $lastmodif_user" >> /var/log/log_evt.log
	return 
    }

    # Liste des sessions ouvertes par l'utilisateur
    function liste_sessions_utilisateur() {
        clear
	    local fichier="$HOME/Documents/${utilisateur}_$(date +%F).txt"
        user_session=""
        read -p "Entrez le nom d'utilisateur : " user_session
        echo "Affiche la liste des sessions ouvertes par $user_session"
        ssh $utilisateur@$ip "w -u $user_session"
	    sleep 5
	    ssh $utilisateur@$ip "w -u $user_session" >> "$fichier"
        echo "$(date +%F-%X) - $USER - Liste des sessions de l'utilisateur $user_session" >> /var/log/log_evt.log
        return 
    }

    # Liste des commandes effectuées par l'utilisateur
    function liste_commandes_utilisateur() {
        clear
        local fichier="$HOME/Documents/${utilisateur}_$(date +%F).txt"
        user_history=""
        read -p "Entrez le nom de l'utilisateur : " user_history 
        echo "Affiche la liste des commandes effectuées par $user_history"
        ssh $utilisateur@$ip "cat .bash_history -n | tail -30"
        sleep 5
        ssh $utilisateur@$ip "cat .bash_history -n" >> "$fichier"
        echo "$(date +%F-%X) - $USER - Liste des commandes effectuées par $user_history" >> /var/log/log_evt.log
        return 
    }


    # Groupe d'appartenance d'un utilisateur
    function groupe_appartenance_utilisateur() {
        clear
	    local fichier="$HOME/Documents/${utilisateur}_$(date +%F).txt"
        grp_user=""
        read -p "Entrez le nom d'utilisateur : " grp_user
        echo "Affiche le groupe d'appartenance de $grp_user"
        ssh $utilisateur@$ip "groups $grp_user"
	    sleep 5
	    ssh $utilisateur@$ip "groups $grp_user" >> "$fichier"
        echo "$(date +%F-%X) - $USER - Groupe d'appartenance de l'utilisateur $grp_user" >> /var/log/log_evt.log
        return 
    }

    # Droits et permissions sur un dossier
    function droits_permissions_dossier() {
        clear
	    local fichier="$HOME/Documents/${utilisateur}_$(date +%F).txt"
        road_directory=""
        read -p "Entrez le chemin du dossier, ex: /home/user/repertoire/dossier : " road_directory
        echo "Affiche les droits et permissions sur le dossier $road_directory"
        ssh $utilisateur@$ip "ls -ld \"$road_directory\""
	    sleep 5
	    ssh $utilisateur@$ip "ls -ld \"$road_directory\"" >> "$fichier"
        echo "$(date +%F-%X) - $USER - Droits et Permissions sur le dossier $road_directory" >> /var/log/log_evt.log
        return 
    }

    # Droits et permissions sur un fichier
    function droits_permissions_fichier() {
        clear
	    local fichier="$HOME/Documents/${utilisateur}_$(date +%F).txt"
        road_file=""
        read -p "Entrez le chemin du fichier, ex: /home/user/directory/file.txt : " road_file
        echo "Affiche les droits et permissions sur le fichier $road_file"
        ssh $utilisateur@$ip "ls -l \"$road_file\""
	    sleep 5
	    ssh $utilisateur@$ip "ls -l \"$road_file\"" >> "$fichier"
        echo "$(date +%F-%X) - $USER - Droits et Permissions sur le fichier $road_file" >> /var/log/log_evt.log
        return 
    }

    # Version de l'OS, nombre de disques, partitions, etc.
    function version_os() {
        clear
	    local fichier="$HOME/Documents/${ip}_$(date +%F).txt"
        echo "Affichage de la version de l'OS du client"
        ssh $utilisateur@$ip "lsb_release -a"
	    sleep 5
	ssh $utilisateur@$ip "lsb_release -a" >> "$fichier"
        echo "$(date +%F-%X) - $USER - Version de l'OS $ip" >> /var/log/log_evt.log
        return 
    }

    #Nombre de disques de l'ordinateur client :
    function nombre_disques() {
        clear
	    local fichier="$HOME/Documents/${ip}_$(date +%F).txt"
        echo "Affiche le nombre de disque du client"
        ssh $utilisateur@$ip "lsblk | grep disk | wc -l"
	    sleep 5
	    ssh $utilisateur@$ip "lsblk | grep disk | wc -l" >> "$fichier"
        echo "$(date +%F-%X) - $USER - Nombre de disques sur l'ordinateur $ip" >> /var/log/log_evt.log
        return 
    }

    #Partition par disque de l'ordinateur client :
    function partition_par_disque() {
        clear
	    local fichier="$HOME/Documents/${ip}_$(date +%F).txt"
        echo "Affichage des informations sur les partitions par disque du client"
        ssh $utilisateur@$ip "lsblk | grep sd"
	    sleep 5
	    ssh $utilisateur@$ip "lsblk | grep sd" >> "$fichier"
        echo "$(date +%F-%X) - $USER - Partition par disque sur l'ordinateur $ip" >> /var/log/log_evt.log
        return 
    }
    #Nom et espace disque d'un dossier :

    function espace_disque_dossier () {
        clear
	    local fichier="$HOME/Documents/${ip}_$(date +%F).txt"
        echo "Affiche le nom et l'espace disque du dossier"
	    ssh $utilisateur@$ip "df -h #/chemin/du/dossier"
	    sleep 5
	    ssh $utilisateur@$ip "df -h #/chemin/du/dossier" >> "$fichier"
        echo "$(date +%F-%X) - $USER - Espace disque dossier sur l'ordinateur $ip" >> /var/log/log_evt.log
        return 
        
    }

    #Liste des lecteurs montés :

    function lecteurs_montes () {
        clear
	    local fichier="$HOME/Documents/${ip}_$(date +%F).txt"
    	echo "Affiche le liste des lecteurs montés"
        ssh $utilisateur@$ip "df -h"
	    sleep 5
	    ssh $utilisateur@$ip "df -h" >> "$ficher"
        echo "$(date +%F-%X) - $USER - Lecteurs montés sur l'ordinateur $ip" >> /var/log/log_evt.log 
        return 
        
    }

    #Nombre d'interfaces et adresse ip :

    function interfaces_ip () {
        clear
	    local fichier="$HOME/Documents/${ip}_$(date +%F).txt"
	    echo "Affiche le nombre d'interfaces et leur adresse ip"
        ssh $utilisateur@$ip "sudo -S netstat -i && ip addr"
	    sleep 5
        ssh $utilisateur@$ip "sudo -S netstat -i && ip addr" >> "$fichier"
        echo "$(date +%F-%X) - $USER - Interfaces IP sur l'ordinateur $ip" >> /var/log/log_evt.log 
        return 
    }

    #Liste des ports ouverts :

    function ports_ouverts () {
        clear
    	local fichier="$HOME/Documents/${ip}_$(date +%F).txt"
        echo "Affiche la liste des ports ouverts"
	    sh $utilisateur@$ip "sudo -S netstat -l && ip addr"
	    sleep 5
	    ssh $utilisateur@$ip "sudo -S netstat -l && ip addr" >> "$fichier"
        echo "$(date +%F-%X) - $USER - Ports Ouverts sur l'ordinateur $ip" >> /var/log/log_evt.log
        return 
    }

    #Statut du pare-feu :

    function statut_pare_feu () {
        clear
	    local fichier="$HOME/Documents/${ip}_$(date +%F).txt"
        echo "Affiche le statut du pare-feu"
	    ssh $utilisateur@$ip "sudo -S ufw status"
	    sleep 5
	        ssh $utilisateur@$ip "sudo -S ufw status" >> "$fichier"
        echo "$(date +%F-%X) - $USER - Status Pare-feu sur l'ordinateur $ip" >> /var/log/log_evt.log 
        return 
    }

    #Recherche des événements dans le fichier log_evt.log pour un utilisateur :

    function recherche_evenements_utilisateur () {
        clear
    	local fichier="$HOME/Documents/${utilisateur}_$(date +%F).txt"
	    read -p "Entrez le nom de l'utilisateur ciblé : "  nom_user
	    echo "Affiche les événements du fichier log_evt.log pour un utilisateur"
        cat /var/log/log_evt.log | grep "$nom_user"
	    sleep 10
	    cat /var/log/log_evt.log | grep "$nom_user" | tail 20 >> "$fichier"
        echo "$(date +%F-%X) - $USER - Recherches des événements de l'utilisateur" >> /var/log/log_evt.log 
        return 
    }

    #Recherche des événements dans le fichier log_evt.log pour un ordinateur :

    function recherche_evenements_ordinateur () {
        clear
        local fichier="$HOME/Documents/${ip}_$(date +%F).txt"
        read -p "Entrez l'adresse IP de l'ordinateur ciblé : "  ordi_cible
	    echo "Affiche les événements du fichier log_evt.log pour un ordinateur"
	    cat /var/log/log_evt.log | grep "$ordi_cible"
    	sleep 10
	    cat /var/log/log_evt.log | grep "$ordi_cible" | tail 20 >> "$fichier"
        echo "$(date +%F-%X) - $USER - Recherches des événements de l'ordinateur" >> /var/log/log_evt.log 
        return 
    }

    # Menu de gestion des informations
    while true; do
        clear
        echo "==========================="
        echo "       Menu Information:   "
        echo "==========================="
        echo "Menu de gestion des informations :"
        echo "1. Date de dernière connexion d'un utilisateur"
        echo "2. Date de dernière modification du mot de passe"
        echo "3. Liste des sessions ouvertes par l'utilisateur"
        echo "4. Liste des commandes effectuées par l'utilisateur"
        echo "5. Groupe d'appartenance d'un utilisateur"
        echo "6. Droits et permissions sur un dossier"
        echo "7. Droits et permissions sur un fichier"
        echo "8. Version de l'OS du client"
        echo "9. Nombre de disques du client"
        echo "10. Informations sur les partitions par disque"
        echo "11. Nom et espace disque d'un dossier "
        echo "12. Liste des lecteurs montés"
        echo "13. Nombre d'interfaces et adresse ip"
        echo "14. Liste des ports ouverts "
        echo "15. Statut du pare-feu "
        echo "16. Recherche des événements dans le fichier log_evt.log pour un utilisateur"
        echo "17. Recherche des événements dans le fichier log_evt.log pour un ordinateur"
        echo "0. Retour au menu principal"
        read -p "Choisissez une option : " choix

        case $choix in
            1) date_derniere_connexion ;;
            2) date_derniere_modif_mot_de_passe ;;
            3) liste_sessions_utilisateur ;;
            4) liste_commandes_utilisateur ;;
            5) groupe_appartenance_utilisateur ;;
            6) droits_permissions_dossier ;;
            7) droits_permissions_fichier ;;
            8) version_os ;;
            9) nombre_disques ;;
            10) partition_par_disque ;;
            11) espace_disque_dossier ;;
            12) lecteurs_montes ;;
            13) interfaces_ip ;;
            14) ports_ouverts ;;
            15) statut_pare_feu ;;
            16) recherche_evenements_utilisateur ;; 
            17) recherche_evenements_ordinateur ;;
            0) clear ;echo "Retour au menu principal" ;sleep 2 ;echo "$(date +%F-%X) - $USER - Retour au menu principal" >> /var/log/log_evt.log ;return ;;
            *) echo "Option non valide. Veuillez choisir une option valide." ;;
        esac
    done
}

function connexion () {
    read -p "IP du serveur : " ip
    echo "$(date +%F-%X) - $USER - Rentre l'adresse IP" >> /var/log/log_evt.log
    read -p "Nom d'utilisateur pour la connexion SSH : " utilisateur
    echo "$(date +%F-%X) - $USER - Rentre le nom de l'utilisateur" >> /var/log/log_evt.log

}

function menu_action () {
    while true; do
        clear
        echo "==========================="
        echo "       Menu Action:        "
        echo "==========================="
        echo "1. Gestion des utilisateurs"
        echo "2. Gestion des groupes"
        echo "3. Gestion du système"
        echo "4. Gestion des répertoires"
        echo "5. Gestion prise en main à distance"
        echo "6. Gestion sécurité"
        echo "0. Retour au menu principal"
        read -p "Choisissez une option :"  choix
        case $choix in
            1) gestion_utilisateur ;echo "$(date +%F-%X) - $USER - Gestion Utilisateur" >> /var/log/log_evt.log ;;
            2) gestion_groupe ;echo "$(date +%F-%X) - $USER - Gestion Groupe" >> /var/log/log_evt.log ;;
            3) gestion_systeme ;echo "$(date +%F-%X) - $USER - Gestion Système" >> /var/log/log_evt.log ;;
            4) gestion_repertoire ;echo "$(date +%F-%X) - $USER - Gestion Répertoire" >> /var/log/log_evt.log ;;
            5) gestion_prise_main_distance ;echo "$(date +%F-%X) - $USER - Gestion Prise en main à distance" >> /var/log/log_evt.log ;;
            6) gestion_securite ; echo "$(date +%F-%X) - $USER - Gestion Sécurité" >> /var/log/log_evt.log ;;
            0) clear ;echo "Retour au menu principal" ;sleep 2 ;echo "$(date +%F-%X) - $USER - Retour au menu principal" >> /var/log/log_evt.log ;return ;;
            *) echo "Option non valide !?!?!?" ;;
        esac
        done
}

echo "$(date +%F-%X) - $USER - ********StartScript********" >> /var/log/log_evt.log
while true; do
clear
echo "==========================="
echo "      Menu principal       "
echo "==========================="
echo "1. Menu Action"
echo "2. Menu des informations"
echo "3. Connexion"
echo "0. Quitter"
read -p "Choisissez une option :"  choix
case $choix in
    1) menu_action ;echo "$(date +%F-%X) - $USER - Menu Action" >> /var/log/log_evt.log ;;
    2) gestion_information ;echo "$(date +%F-%X) - $USER - Gestion Information" >> /var/log/log_evt.log ;;
    3) connexion ;echo "$(date +%F-%X) - $USER - Connexion SSH" >> /var/log/log_evt.log ;;
    0) clear ;echo "Au revoir !!!!!";sleep 3 ;clear ;echo "$(date +%F-%X) - $USER - ********EndScript********" >> /var/log/log_evt.log; exit  ;;
    *) echo "Option non valide !?!?!?" ;;
esac
done
