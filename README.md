# Mega TP : Administration de Systèmes Répartis 🚀
**Déploiement Automatisé d'une Infrastructure Haute Disponibilité & Sécurisée**

## 1. Présentation du Projet
[cite_start]Ce projet consiste en la refonte complète de l'infrastructure d'une PME pour passer d'un mode manuel à une approche **Infrastructure as Code (IaC)**[cite: 5, 6]. [cite_start]L'objectif est de garantir la tolérance aux pannes, la sécurité par défaut et une surveillance en temps réel via un environnement hétérogène[cite: 7, 8].

## 2. Architecture Technique (Le Lab)
[cite_start]L'infrastructure est déployée via un **Vagrantfile unique** [cite: 12] et comprend :
* [cite_start]**Admin (Ubuntu Server 22.04)** : Nœud de contrôle Ansible et Serveur Zabbix[cite: 13].
* [cite_start]**Node01 & Node02 (Rocky Linux/RedHat)** : Cluster HA pour les services Web (Nginx) et fichiers (Samba)[cite: 13, 31, 32].
* [cite_start]**WinSrv (Windows Server 2019)** : Contrôleur de Domaine Active Directory[cite: 13, 33].
* [cite_start]**VIP (192.168.56.20)** : Adresse IP flottante pour la haute disponibilité[cite: 16, 40].

## 3. Guide d'Installation
### Prérequis
* VirtualBox et Vagrant installés.
* Connexion Internet active pour le téléchargement des images (boxes).

### Déploiement
1.  **Lancer l'infrastructure** :
    ```bash
    vagrant up
    ```
    [cite_start]*Cette commande déploie automatiquement les 4 machines virtuelles[cite: 9, 72].*

2.  **Configuration Ansible** :
    Connectez-vous à la machine Admin et lancez le déploiement automatisé[cite: 37, 50, 73]:
    ```bash
    vagrant ssh admin
    cd /home/vagrant/ansible
    ansible-playbook -i inventory/hosts.ini site.yml
    ```

## 4. Missions Réalisées

### MISSION 1 : Haute Disponibilité (HA)
* [cite_start]**Cluster** : Configuration automatisée de Pacemaker et Corosync[cite: 38].
* [cite_start]**Services** : Nginx et Samba déployés en haute disponibilité (Active/Passive)[cite: 38, 39].
* [cite_start]**Contraintes** : L'IP flottante, Nginx et Samba basculent ensemble sur le nœud sain en cas de défaillance[cite: 41].

### MISSION 2 : Sécurisation Linux
* [cite_start]**Pare-feu** : Configuration via `firewalld` pour n'ouvrir que les ports SSH, HTTP, Cluster et l'agent Zabbix[cite: 46].
* [cite_start]**SSH** : Désactivation complète de la connexion en root[cite: 47].
* [cite_start]**Mises à jour** : Automatisation des paquets de sécurité[cite: 48].

### MISSION 3 : Windows Server & Active Directory
* [cite_start]**AD** : Promotion automatique du serveur en Contrôleur de Domaine[cite: 51].
* [cite_start]**Hardening** : Activation du pare-feu, désactivation du compte Invité, retrait de SMBv1/LLMNR et politique de mot de passe stricte (12 caractères min)[cite: 56, 57, 58, 60, 61].

### MISSION 4 : Supervision avec Zabbix
* [cite_start]**Monitoring** : Zabbix Server sur Admin et Agents sur Node01/Node02[cite: 63, 64].
* [cite_start]**Dashboard** : Affichage de l'état CPU/RAM, de la disponibilité Nginx et alertes visuelles[cite: 67, 68, 69].

## 5. Preuves de Fonctionnement
* [cite_start]**Schéma d'architecture** : [Insérer lien vers image ou fichier Draw.io][cite: 76].
* [cite_start]**Screenshots attendus**[cite: 82]:
    1.  État du Cluster (`pcs status`).
    2.  Dashboard Zabbix personnalisé.
    3.  Page Web Nginx via la VIP (192.168.56.20).
