# Guide d'Installation

## Documentation administrateur

### Prérequis techniques :
 - Accès administrateur sur les machines
 - Connexion internet pour télécharger les paquets

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

### FAQ :

## Documentation utilisateur
