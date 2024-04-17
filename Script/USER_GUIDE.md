# Implémentation d'un script sur machine distante 



Ce document est réservé à usage interne, il ne peut en aucun cas être divulgué à des tiers.

Dernière mise à jour du Document : **17 Avril 2024**

## **Sommaire**

1. Pré-requis

2. Démarrage et première connexion

3. Découvrir les fonctionnalités du script

1. Linux
2. Windows
 

5. 

6. FAQ


## **1. Prérequis**
## **2. Démarrage et première connexion**
### Introduction

Le script pour actions à distance sur un PC est conçu pour permettre l'exécution de diverses actions et la collecte d'informations sur un ordinateur distant. Cette documentation fournit des instructions pour installer, configurer et utiliser le script de manière efficace.

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
   - Windows : 

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


Lorsque que vous allez lancer le script vous allez tombé sur le premier menu ci dessous 

![2024-04-10 15_37_45-SRVLX01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/7a204afc-c9ef-455e-8e85-a919a07e8fc2)


Comme visible à l'image ci dessus vous avez le choix entre 2 menus.


Le premier menu **``Action``** vous permetttra d'effectuer des actions directement au sein de l'ordinateur ciblé.






Le deuxième menu **``Informations``** vous permettra de prendre des informations de la machine que vous souhaitez utiliser.


On commence par se connecter à la machine cible. Pour cela, il faut lui fournir son adresse IP et le nom d'utilisateur en selectionnant le menu **``Connexion``**


![2024-04-17 10_17_33-SRVLX01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/8dc627b3-8cb1-4fb2-8126-1c99597459fb)






Explorons pour commencer le menu **``Action``**

Le menu **``Action``** est composé de six sous-menus permettant de réaliser des actions sur le PC cible.

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




Voila toutes les actions qui sont réalisable avec le script.




Le menu **``Information``** permet d'accéder à diverses informations personnelles après avoir renseigné son nom d'utilisateur.

![2024-04-17 11_27_46-SRVLX01  En fonction  - Oracle VM VirtualBox](https://github.com/WildCodeSchool/TSSR-2402-P2-G4-TheScriptingProject/assets/161461625/a5f2ea7e-3d25-4d6e-9c5d-d689d0b0ec97)











