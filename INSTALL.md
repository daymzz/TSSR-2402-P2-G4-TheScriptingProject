# Guide d'Installation

## Documentation administrateur

### Prérequis techniques :
 - Accès administrateur sur les machines
 - Connexion internet pour télécharger les paquets
 - Pare-feu désactivé

### Étapes d'installation et configuration :

#### Serveur Debian 12

1. **Configurez les paramètres de la machine**:
   - Nom : SRVLX01
   - Système d'Exploitation : Debian 12
   - Compte : root
   - Mot de passe : Azerty1*
   - Adresse IP : 172.16.10.10/24

2. **Installation de OpenSSH**:
   - Exécutez la commande suivante pour mettre à jour les paquets et installer OpenSSH :
     ```bash
     sudo apt update && sudo apt install -y openssh-server
     ```
   - Vérifiez que le service SSH est actif :
     ```bash
     sudo systemctl status ssh
     ```

#### Serveur Windows Server 2022 

1. **Configurez les paramètres de la machine**:
   - Nom : SRVWIN01
   - Système d'Exploitation : Windows Server 2022
   - Compte : Administrator
   - Mot de passe : Azerty1*
   - Adresse IP : 172.16.10.5/24

2. **Installation de OpenSSH**:
   - Ouvrez PowerShell en tant qu'administrateur et exécutez :
     ```powershell
     Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
     ```
   - Démarrez le service SSH :
     ```powershell
     Start-Service sshd
     ```

3. **Installation de PowerShell 7.4**:
   - Téléchargez et installez PowerShell 7.4 en utilisant la commande suivante :
     ```powershell
     iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI"
     ```
#### Poste Client Windows 10

1. **Configurez les paramètres de la machine**:
   - Nom : CLIWIN01
   - Système d'Exploitation : Windows 10 PRO
   - Compte : Wilder
   - Mot de passe : Azerty1*
   - Adresse IP : 172.16.10.20/24

2. **Installation de OpenSSH**:
   - Ouvrez PowerShell en tant qu'administrateur et exécutez :
     ```powershell
     Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
     ```
   - Démarrez le service SSH :
     ```powershell
     Start-Service sshd
     ```

3. **Installation de PowerShell 7.4**:
   - Téléchargez et installez PowerShell 7.4 en utilisant la commande suivante :
     ```powershell
     iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI"
     ```

4. **Configuration du réseau et du pare-feu**:
   - Ouvrez une console PowerShell en tant qu'administrateur.
   - Récupérez l'index de l'interface réseau et modifiez son profil :
     ```powershell
     # Récupérer l'index de l'interface
     $index = (Get-NetConnectionProfile).InterfaceIndex
     # Modifier le profil en catégorie Privée
     Set-NetConnectionProfile -InterfaceIndex $index -NetworkCategory Private
     ```
   - Si le pare-feu est activé, configurez l'exception pour WinRM :
     ```powershell
     # Activer la règle de pare-feu pour WinRM sur HTTP
     Enable-NetFirewallRule -DisplayName "Windows Remote Management (HTTP-In)"
     ```

5. **Désactivation du pare-feu** (Optionnel, déconseillé pour des raisons de sécurité) :
   - Pour désactiver le pare-feu, exécutez :
     ```powershell
     Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
     ```

6. **Configuration du service Registre Distant**:
   - Assurez-vous que le service de Registre Distant est configuré pour démarrer automatiquement et qu'il est démarré 

7. **Création d'un compte administratif local**:
   - Créez un compte identique au compte administrateur du serveur et ajoutez-le au groupe des administrateurs locaux 

Ces étapes devraient vous permettre de préparer et configurer votre poste client Windows 10 pour une gestion à distance et locale efficace. Veuillez ajuster les paramètres de sécurité selon les politiques de votre organisation.

#### Poste Client Ubuntu 22.04 LTS

1. **Configurez les paramètres de la machine**:
   - Nom : CLILIN01
   - Système d'Exploitation : Ubuntu 22.04 LTS
   - Compte : Wilder
   - Mot de passe : Azerty1*
   - Adresse IP : 172.16.10.30/24

2. **Installation de OpenSSH**:
   - Ouvrez un terminal et exécutez les commandes suivantes pour installer OpenSSH Server :
     ```bash
     sudo apt update
     sudo apt install -y openssh-server
     ```
   - Vérifiez que le service SSH est actif et s'exécute correctement :
     ```bash
     sudo systemctl status ssh
     ```

3. **Installation des utilitaires réseau et de surveillance système**:
   - Installez `net-tools`, qui inclut des commandes utiles comme `ifconfig` :
     ```bash
     sudo apt install -y net-tools
     ```
   - Installez `sysstat` pour surveiller les performances du système :
     ```bash
     sudo apt install -y sysstat
     ```

### FAQ :

**Q : Comment vérifier si OpenSSH est correctement installé et actif sur ma machine ?**
A : Sur Debian et Ubuntu, utilisez la commande `sudo systemctl status ssh` pour vérifier l'état du service. Sur Windows, ouvrez PowerShell en tant qu'administrateur et exécutez `Get-Service sshd` pour voir si le service est actif.

**Q : Que faire si l'installation de PowerShell 7.4 échoue sur Windows ?**
A : Assurez-vous que votre connexion Internet est stable et que vous avez les droits administrateurs. Vérifiez également que vous exécutez la commande dans une session PowerShell avec des droits élevés. Si le problème persiste, consultez la documentation officielle de PowerShell pour des solutions alternatives.

**Q : Comment configurer une adresse IP statique sur les systèmes Linux et Windows ?**
A : Pour Ubuntu, vous pouvez utiliser `netplan` ou éditer directement les fichiers de configuration dans `/etc/network/interfaces`. Pour Windows, vous pouvez aller dans les paramètres du Centre Réseau et partage, cliquer sur 'Modifier les paramètres de la carte', puis configurer les propriétés IPv4 de l'adaptateur réseau.

**Q : Comment puis-je activer la surveillance des performances système sur Ubuntu ?**
A : Après avoir installé `sysstat`, assurez-vous que la collecte de données est activée en modifiant le fichier `/etc/default/sysstat` de `ENABLED="false"` à `ENABLED="true"` et redémarrez le service avec `sudo systemctl restart sysstat`.



