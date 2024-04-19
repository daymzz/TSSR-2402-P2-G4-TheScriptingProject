# Implémentation d'un script sur machine distante 



Ce document est réservé à usage interne, il ne peut en aucun cas être divulgué à des tiers.

Dernière mise à jour du Document : **19 Avril 2024**

## **Sommaire**

### 1. Pré-requis

### 2. Démarrage et première connexion

### 3. Découvrir les fonctionnalités du script

#### - Linux
#### - Windows
 

### 4. FAQ



## **1. Prérequis**


## **2. Démarrage et première connexion**

### Introduction

Le script conçu pour les actions à distance sur un PC permet d'exécuter diverses actions et de recueillir des informations sur un ordinateur distant. Cette documentation fournit des instructions pour installer, configurer et utiliser le script de manière efficace.

### Prérequis

Avant d'utiliser ce script, assurez-vous que les éléments suivants sont en place :

1. Un ordinateur distant accessible sur le réseau.
2. Les informations de connexion nécessaires (adresse IP, nom d'utilisateur, mot de passe).

### Installation

1. Récuperez le script depuis le Github.
2. Assurez-vous d'avoir les autorisations appropriées pour exécuter le script.
3. Sur la partie Linux la documentation est en graphique pour une meilleure visibilité, il est aussi fonctionnel en CLI évidemment.

### Utilisation

1. Ouvrez une fenêtre de terminal (ou invite de commande) sur votre ordinateur local en tant qu'administrateur.
2. Naviguez vers le répertoire où se trouve le script.
3. Exécutez le script en utilisant la commande suivante :
   - Linux : `bash ./script.sh`
   - Windows : clique droit sur le fichier script et executer avec powershell 7

### Dépannage

En cas de problème lors de l'exécution du script, veuillez vérifier les points suivants :

1. Assurez-vous que l'ordinateur distant est accessible sur le réseau et que les informations de connexion sont correctes.
2. Vérifiez les autorisations d'accès aux fichiers et d'exécution du script.

Si le problème persiste, consultez la documentation avancée ou contactez le support technique pour obtenir de l'aide supplémentaire.

### Limitations

- Ce script peut ne pas prendre en charge toutes les fonctionnalités ou configurations spécifiques à certains systèmes d'exploitation ou environnements réseau.
- Certaines actions ou informations peuvent nécessiter des autorisations spécifiques sur l'ordinateur distant.

### Conclusion

La documentation de base fournie ici devrait vous permettre d'installer, de configurer et d'utiliser le script pour exécuter des actions à distance sur un PC. Pour des instructions plus avancées, veuillez vous référer à la documentation avancée.


## **3. Découvrir les fonctionnalités du script**




### **1. Linux** 




Lorsque vous lancerez le script, vous tomberez sur le premier menu ci-dessous. 

![2024-04-10 15_37_45-SRVLX01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/7a204afc-c9ef-455e-8e85-a919a07e8fc2)


Comme visible dans l'image ci-dessus, vous avez le choix entre 2 menus.

Le premier menu **``Action``** vous permettra d'effectuer des actions directement sur l'ordinateur ciblé.

Le deuxième menu **``Informations``** vous permettra de recueillir des informations sur la machine que vous souhaitez utiliser.

Nous débutons en nous connectant à la machine cible. Pour ce faire, veuillez fournir son adresse IP et le nom d'utilisateur en sélectionnant le menu **``Connexion``**.


![2024-04-17 10_17_33-SRVLX01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/8dc627b3-8cb1-4fb2-8126-1c99597459fb)






Commençons par explorer le menu **``Action``**.

Le menu **``Action``** comprend six sous-menus permettant d'effectuer des actions sur le PC cible.

![2024-04-17 10_17_55-SRVLX01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/9e322eb2-148a-4175-8723-eab194039b36)



Le menu **``Gestion des utilisateurs``** 


![2024-04-17 10_18_16-SRVLX01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/d4cc7ffa-5ce7-4409-85f1-1c515fed2fc2)



Le menu **``Gestion des groupes``**


![2024-04-17 10_18_34-SRVLX01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/d4eaa12f-57ef-4f95-bd31-58d03784252f)


Le menu **``Gestion du système``**


![2024-04-17 10_18_52-SRVLX01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/0aa539d3-1b1a-4392-ae0c-0ea007193100)


Le menu **``Gestion des répertoires``**


![2024-04-17 10_19_09-SRVLX01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/6f769484-7e14-4aa5-ba95-6eac2d9ec925)


Le menu **``Gestion prise en main à distance``**


![2024-04-17 14_38_31-SRVLX01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/e574d48a-ab42-4670-9d97-8a0aa0528954)



Le menu **``Gestion sécurité``**


![2024-04-17 14_58_12-SRVLX01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/648491ab-6a14-4644-b129-e9c708d9a125)


Voila toutes les actions qui sont réalisable avec le script.




Le menu **``Information``** permet d'accéder à diverses informations personnelles après avoir renseigné votre nom d'utilisateur.

![2024-04-17 11_27_46-SRVLX01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/a5f2ea7e-3d25-4d6e-9c5d-d689d0b0ec97)








### **2. Windows** 


En premier lieu, vous allez vous connecter en entrant le nom de l'utilisateur ciblé, son adresse IP, ainsi que le compte **``Administrator``**.



![2024-04-19 11_16_59-SRVWIN01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/758358f6-e629-48e0-93c5-ca35cbf67ae1)



Lorsque vous lancerez le script, vous tomberez sur le premier menu ci-dessous. 


![2024-04-19 09_39_40-VirtualBoxVM](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/33f24834-a291-4206-9a34-9e13e5b91c91)



Comme visible dans l'image ci-dessus, vous avez le choix entre 2 menus.

Le premier menu **``Action``** vous permettra d'effectuer des actions directement sur l'ordinateur ciblé.

Le deuxième menu **``Informations``** vous permettra de recueillir des informations sur la machine que vous souhaitez utiliser.

Explorons pour commencer le menu **``Action``** ci-dessous.

Le menu **``Action``** est composé de six sous-menus permettant de réaliser des actions sur le PC cible.


![2024-04-19 09_40_11-SRVWIN01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/99f6072e-d97b-47fd-90a5-78a2b6bdb9ab)



Le menu **``Action Utilisateur``** 


![2024-04-19 09_40_55-SRVWIN01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/84d05067-9926-40a1-bf8a-12f4e5bea933)




Le menu **``Action Groupe``**


![2024-04-19 09_41_39-SRVWIN01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/684a7db6-6690-4274-88d1-ed2934d15b5c)



Le menu **``Action Système``**


![2024-04-19 09_42_21-SRVWIN01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/4e97eac7-2d99-49dc-b69c-b6e8f88bd174)



Le menu **``Action Répertoire``**



![2024-04-19 09_53_16-SRVWIN01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/94f4e23a-0e37-412b-8d3b-0191c891621a)



Le menu **``Action sécurité``**



![2024-04-19 09_43_13-SRVWIN01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/fc9db26d-4ded-44d3-9aaa-56f6ceaaf54d)




Le menu **``Action Logiciel``**



![2024-04-19 09_55_48-SRVWIN01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/c82bbc50-a25c-4557-8cab-3cda586f9cd6)




Le menu **``Action Bureau à Distance à distance``**








Voici toutes les actions qui sont réalisable avec le script.




Le menu **``Information``** permet d'accéder à diverses informations personnelles après avoir renseigné votre nom d'utilisateur.



![2024-04-19 10_08_25-SRVWIN01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/b2d4c586-7560-445a-82bf-fa22a5ea6872)



## **4. F.A.Q**


### **Quel est l'objectif de ce script PowerShell ?**

Ce script PowerShell est conçu pour permettre l'administration à distance d'un ordinateur Windows. Il offre une interface conviviale pour exécuter diverses actions telles que la gestion des utilisateurs, des groupes, des logiciels, des dossiers, etc., sur une machine distante.

### **Quels sont les prérequis pour exécuter ce script ?**

Vous devez disposer d'une machine locale exécutant Windows avec PowerShell 7. De plus, vous devez avoir des autorisations suffisantes pour exécuter des commandes à distance sur la machine cible.

### **Comment exécuter le script ?**

Téléchargez le script sur votre machine locale, ouvrez PowerShell et exécutez-le en spécifiant les informations requises telles que le nom du compte distant, l'adresse IP de l'ordinateur distant et les informations d'identification administrateur.

### **Quelles actions puis-je effectuer avec ce script ?**

Vous pouvez effectuer diverses actions telles que la création, la modification et la suppression des utilisateurs, des groupes, des dossiers, des logiciels, ainsi que des opérations système telles que l'arrêt, le redémarrage et la mise à jour du système.

### **Comment gérer les erreurs lors de l'exécution du script ?**

Si vous rencontrez des erreurs, vérifiez d'abord que toutes les conditions préalables sont remplies, telles que l'activation de PowerShell Remoting et les autorisations appropriées. Vérifiez également que les informations saisies sont correctes. Vous pouvez consulter la documentation PowerShell ou rechercher des solutions en ligne pour résoudre les problèmes spécifiques.

### **Existe-t-il des bonnes pratiques à suivre lors de l'utilisation de ce script ?**

Oui, quelques bonnes pratiques incluent : vérifier les autorisations avant d'exécuter des commandes système, vérifier deux fois les informations saisies pour éviter les erreurs, et tester d'abord sur des environnements de test avant de déployer sur des environnements de production.






