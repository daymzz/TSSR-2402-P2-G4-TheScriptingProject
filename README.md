# PROJET SCRIPT
![](https://vignette.wikia.nocookie.net/logopedia/images/c/cb/Script.png/revision/latest?cb=20151220181603?raw=true)
___

## SOMMAIRE  

___

1. Présentation du projet et objectif  
2. Mise en contexte  
3. Membres du projet  
4. Choix techniques  
5. Difficultés trouvées  
6. Solutions trouvées  
7. Améliorations possibles  

### 1. PRESENTATION DU PROJET ET OBJECTIF  

___

1- Création un script fonctionnel et intuitif, effectuant des tâches ou des requêtes sur une ou des machines distantes sous un même OS sur un réseau local.

2- Faire fonctionner notre script pour agir ou interroger une machine distante en reseau local mais ***avec des OS différentes***

### 2.  MISE EN CONTEXTE  

___

Mise en place d'un script "Bash" pour interroger ou effectuer des actions sur poste client UBUNTU depuis un serveur DEBIAN.  

ET  

Mise en place d'un script "PowerShell" pour interroger ou effectuer des actions sur un poste client WINDOWS 10 PRO depuis un serveur WINDOWS SERVER 2022.

### 3. MEMBRES DU PROJET  

___

L'équipe du projet est composé de :

- CAULIER Charles
- HORTHOLARY Yanis
- KAMARA Maxime
- LEGAY Damien  

Durant les 4 prochaines semaines les rôles et tâches de chacun changeront.

***SEMAINE 1***  

- RÔLE

    |      SM       |        PO        |
    |     :---:     |       :---:      |
    | LEGAY Damien | HORTHOLARY Yanis |  

- TÂCHES

    |     *MEMBRE*     |            *TÂCHES*            |
    |       :---:      |              :---:             |
    |  CAULIER Charles |          Documentation         |
    | HORTHOLARY Yanis |    Commentaire et code Bash    |
    |   KAMARA Maxime  | Commentaire et code PowerShell |
    |   LEGAY Damien   |      Arborescence menu Bash    |

***SEMAINE 2***

- RÔLE

    |      SM       |        PO        |
    |     :---:     |       :---:      |
    | KAMARA Maxime |  CAULIER Charles |  

- TÂCHES

    |     *MEMBRE*     |                                        *TÂCHES*                                 |
    |       :---:      |                                          :---:                                  |
    |  CAULIER Charles |                   Documentation, code bash et mise en réseau                    |
    | HORTHOLARY Yanis |                   Documentation, code bash et mise en réseau                    |
    |   KAMARA Maxime  |               Documentation, script powerShell et mise en réseau                |
    |   LEGAY Damien   | Documentation, intégrer le squelette bash, commencer les test et mise en réseau |  

***SEMAINE 3***

- RÔLE

    |         SM       |        PO        |
    |        :---:     |       :---:      |
    | HORTHOLARY Yanis |    KAMARA Maxime |  

- TÂCHES

    |     *MEMBRE*     |                                     *TÂCHES*                                  |
    |       :---:      |                                      :---:                                    |
    |  CAULIER Charles |            Gestion des fichiers logs et test code bash , Powershell           |
    | HORTHOLARY Yanis |           Documentation, tests et finalisation du code Bash, PowerShell       |
    |   KAMARA Maxime  |          Documentation, implémentation du SSH, tests du code Bash, Powershell |
    |   LEGAY Damien   |          Documentation,  tests et finalisation du code Bash, Powershell       |  

***SEMAINE 4***

- RÔLE

    |      SM       |        PO        |
    |     :---:     |       :---:      |
    | CAULIER Charles |                  |  

- TÂCHES

    |     *MEMBRE*     |            *TÂCHES*            |
    |       :---:      |              :---:             |
    |  CAULIER Charles |      Gestion des fichiers logS, test code Powershell et documentation       |
    | HORTHOLARY Yanis |          Documentation, tests et finalisation du code PowerShell            |
    |   KAMARA Maxime  |   Documentation, finalisation du code PowerShell, tests du code Powershell  |
    |   LEGAY Damien   |   Documentation, finalisation du code PowerShell, tests du code Powershell  |  

**SM** = *Scrum Master*
**PO** = *Product Owner*

### 4. CHOIX TECHNIQUES

___

Pour le choix des serveurs, nous avons :

- ***Serveur 1***

  - **DEBIAN 12**  
        -Nom : **SRVLX01**  
        -Compte : **root**  
        -Mot de passe : **Azerty1***  
        -Adresse IP : **172.16.10.10/24**  

- ***Serveur 2***

  - **WINDOWS SERVER 2022**  
        -Nom : **SRVWIN01**  
        -Compte : **Administrator**  
        -Mot de passe : **Azerty1***  
        -Adresse IP : **172.16.10.5/24**  

Pour le choix des postes clients, nous avons :

- ***Poste 1***
  - **UBUNTU 22.04 LTS**  
        -Nom : **CLILIN01**  
        -Compte : **wilder**  
        -Mot de passe : **Azerty1***  
        -Adresse IP : **172.16.10.30/24**  

- ***Poste 2***
  - **WINDOWS 10 PRO**  
        -Nom : **CLIWIN01**  
        -Compte **wilder**  
        -Mot de passe : **Azerty1***  
        -Adresse IP : **172.16.10.20/24**  

### 5. DIFFICULTES TROUVEES  

**1. Configuration réseau :** 
- Des problèmes liés à la configuration réseau peuvent gêner la communication à distance entre les machines, notamment par le pare-feux, la configurations réseau complexes.

**2. Sécurité et authentification :**
- Configurer correctement l'authentification à distance peut être un difficile, en particulier pour garantir que seules les personnes autorisées ont accès aux machines distantes. Cela peut impliquer la gestion des clés SSH et des commandes Windows.

**3. Gestion des erreurs et débogage :**
- Identifier et résoudre les erreurs lors de l'exécution de commandes à distance peut être complexe, en particulier lorsqu'il y a des problèmes de communication ou de configuration. Lister, réessayer, modifier : ceci peut prendre énormément de temps.

**4. Évolutivité et gestion du Script :** 
- À mesure que script évolue et grandit, la gestion et la maintenance de l'infrastructure devient plus complexes. Il est essentiel de mettre en place des pratiques et des règles pour gérer efficacement son environnement.

**5. Documentation et traçabilité :** 
- Maintenir une documentation complète et à jour sur la configuration, les procédures et les problèmes rencontrés est essentiel pour assurer la traçabilité des actions effectuées à distance et faciliter la résolution des problèmes futurs.


### 6. SOLUTIONS TROUVEES  

**1. Configuration réseau :**
- Assurez-vous de bien comprendre la configuration réseau de chaque machine et des réseaux entre elles. Utilisez des outils de diagnostic réseau tels que ping. Configurez les pare-feux pour autoriser le trafic réseau nécessaire, et simplifiez les configurations réseau si possible.

**2. Sécurité et authentification :**
- Mettre des pratiques de sécurité, telles que l'utilisation de clés SSH sécurisées et la configuration des autorisations d'accès appropriées. Sur Windows, utilisez les fonctionnalités d'authentification intégrées ou des solutions pour gérer l'accès à distance de manière sécurisée.

**3. Gestion des erreurs et débogage :**
- Adoptez une approche de débogage en vérifiant systématiquement chaque commande créée.

**4. Documentation et traçabilité :**
- Mettre en place des mises à jour régulières de la documentation afin de rester à jour et coordonné entre les membres du projet.

### 7. AMELIORATIONS POSSIBLES  

**1. Ergonomie des scripts :**
- Diviser le script en modules de fonction distincts pour améliorer la lisibilité et faciliter la maintenance.
- Utiliser des commentaires clairs et concis pour expliquer le fonctionnement de chaque partie du script.
- Adopter des conventions de nommage cohérentes et intuitives pour les variables, les fonctions et les modules.

**2. Système de couleur :**
- Mettre en place un système de coloration pour améliorer la lisibilité et la compréhension du script.
- Utiliser des couleurs distinctes pour différencier les messages d'erreur, les avertissements, les confirmations et les informations.

**3. Gestion des erreurs :**
- Renforcer la gestion des erreurs en identifiant et en traitant les erreurs de manière plus précise.
- Afficher des messages d'erreur clairs et des suggestions de résolution pour guider l'utilisateur en cas de problème.
- Intégrer des mécanismes de détection automatique des erreurs pour anticiper les problèmes potentiels avant qu'ils ne surviennent.

**4. Documentation et traçabilité :**
- Mettre en place des processus réguliers de révision et de mise à jour de la documentation pour garantir sa validité et sa pertinence au fil du temps.
- Utiliser des outils de gestion de la documentation et de suivi des modifications pour faciliter la collaboration entre les membres de l'équipe.
- Assurer la traçabilité des modifications apportées au script en documentant les mises à jour, les corrections de bogues et les nouvelles fonctionnalités ajoutées.

**En implémentant ces améliorations, vous pourrez rendre votre projet plus convivial, plus robuste et plus facile à gérer pour l'ensemble de l'équipe.**
