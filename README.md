# Mega TP : Administration de Systèmes Répartis 🚀
**Déploiement Automatisé d'une Infrastructure Haute Disponibilité & Sécurisée**

## 1. Présentation du Projet
Ce projet consiste en la refonte complète de l'infrastructure d'une PME pour passer d'un mode manuel à une approche **Infrastructure as Code (IaC)**. L'objectif est de garantir la tolérance aux pannes, la sécurité par défaut et une surveillance en temps réel via un environnement hétérogène.

## 2. Architecture Technique (Le Lab)
L'infrastructure est déployée via un **Vagrantfile unique**  et comprend :
* **Admin (Ubuntu Server 22.04)** : Nœud de contrôle Ansible et Serveur Zabbix.
* **Node01 & Node02 (Rocky Linux/RedHat)** : Cluster HA pour les services Web (Nginx) et fichiers (Samba).
* **WinSrv (Windows Server 2019)** : Contrôleur de Domaine Active Directory.
* **VIP (192.168.56.20)** : Adresse IP flottante pour la haute disponibilité.

## 3. Guide d'Installation
### Prérequis
* VMWare et Vagrant installés.
* Connexion Internet active pour le téléchargement des images (boxes).
* Vagrant pour VMWare Workstation Pro
* Installer le plugin pour VmWare Workstation
  ```bash
  vagrant plugin install vagrant-vmware-desktop
  ```

### Déploiement
1.  **Lancer l'infrastructure** :
    ```bash
    vagrant up
    ```
    ou
    ```bash
    vagrant up --provider vmware_desktop
    ```
    *Cette commande déploie automatiquement les 4 machines virtuelles.*

3.  **Configuration Ansible** :
    Connectez-vous à la machine Admin et lancez le déploiement automatisé :
    ```bash
    vagrant ssh admin
    cd /home/vagrant/ansible
    ansible-playbook -i inventory/hosts.ini site.yml
    ```
    Mission 1:
    ```bash
    ansible-playbook -i hosts.ini mission1fix.yml
    ansible-playbook -i hosts.ini mission1bug.yml
    ansible-playbook -i hosts.ini mission1_deploy.yml
    ansible-playbook -i hosts.ini mission1f.yml
    ```
    Mission 2:
    ```bash
    ansible-playbook -i hosts.ini mission2.yml
    ```
    Mission 3:
    ```bash
    ansible-playbook -i hosts.ini mission3install.yml
    ansible-playbook -i hosts.ini mission3.yml
    ```
    Mission 4:
     ```bash
      ansible-playbook -i hosts.ini mission4fix.yml
      ansible-playbook -i hosts.ini mission4.yml
     ```

## 4. Missions Réalisées

### MISSION 1 : Haute Disponibilité (HA)
* **Cluster** : Configuration automatisée de Pacemaker et Corosync.
* **Services** : Nginx et Samba déployés en haute disponibilité (Active/Passive).
* **Contraintes** : L'IP flottante, Nginx et Samba basculent ensemble sur le nœud sain en cas de défaillance.

### MISSION 2 : Sécurisation Linux
* **Pare-feu** : Configuration via `firewalld` pour n'ouvrir que les ports SSH, HTTP, Cluster et l'agent Zabbix.
* **SSH** : Désactivation complète de la connexion en root.
* **Mises à jour** : Automatisation des paquets de sécurité.

### MISSION 3 : Windows Server & Active Directory
* **AD** : Promotion automatique du serveur en Contrôleur de Domaine.
* **Hardening** : Activation du pare-feu, désactivation du compte Invité, retrait de SMBv1/LLMNR et politique de mot de passe stricte (12 caractères min).

### MISSION 4 : Supervision avec Zabbix
* **Monitoring** : Zabbix Server sur Admin et Agents sur Node01/Node02.
* **Dashboard** : Affichage de l'état CPU/RAM, de la disponibilité Nginx et alertes visuelles.

## 5. Preuves de Fonctionnement
* **Schéma d'architecture** :
* <img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/05e912db-81dc-4ff9-88ac-26f800b262df" />

* **Screenshots attendus**:
    1. : État du Cluster (`pcs status`)
       <img width="945" height="423" alt="image" src="https://github.com/user-attachments/assets/35832138-b51f-4961-811d-625e91149305" />

    2.  Dashboard Zabbix personnalisé:
       <img width="1919" height="825" alt="image" src="https://github.com/user-attachments/assets/6273cfb8-f82a-48de-b69a-893cd60dbdb9" />

    3.  Page Web Nginx via la VIP (192.168.56.100):  
      <img width="1919" height="913" alt="image" src="https://github.com/user-attachments/assets/e22a6b0a-1c18-4b36-b77f-05fe14aefbee" />

