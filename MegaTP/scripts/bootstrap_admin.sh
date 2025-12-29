#!/bin/bash
# -------------------------------------------------------------------------
# Script de provisionnement pour la VM "Admin" (Ubuntu)
# Objectif : Préparer le Nœud de Contrôle Ansible + Prérequis Windows/Zabbix
# -------------------------------------------------------------------------

# Arrêter le script si une commande échoue
set -e

echo ">>> [1/5] Mise à jour du système..."
# On évite les boîtes de dialogue interactives pendant l'install
export DEBIAN_FRONTEND=noninteractive
apt-get update -q
apt-get upgrade -y -q

echo ">>> [2/5] Installation d'Ansible et des dépendances..."
apt-get install -y software-properties-common curl git sshpass
# Ajout du PPA officiel pour avoir une version récente d'Ansible
add-apt-repository --yes --update ppa:ansible/ansible
apt-get install -y ansible

# Installation de Python pip pour gérer les modules Windows
apt-get install -y python3-pip

echo ">>> [3/5] Installation des bibliothèques pour piloter Windows (WinRM)..."
# Nécessaire pour la Mission 3 (Active Directory) via Ansible
pip3 install "pywinrm>=0.3.0"

echo ">>> [4/5] Configuration du réseau (Résolution de noms locale)..."
# Comme nous n'avons pas de serveur DNS au démarrage, on remplit /etc/hosts
# pour que 'ping node01' ou 'ssh node01' fonctionne immédiatement.
cat <<EOF >> /etc/hosts
# --- Lab Infra Hosts ---
192.168.56.10  admin.lab.local  admin
192.168.56.11  node01.lab.local node01
192.168.56.12  node02.lab.local node02
192.168.56.13  winsrv.lab.local winsrv
192.168.56.20  vip-cluster.lab.local vip-cluster
EOF

echo ">>> [5/5] Génération de la clé SSH (pour l'utilisateur vagrant)..."
# L'utilisateur 'vagrant' sera celui qui lancera les playbooks.
# Il a besoin d'une clé SSH pour se connecter aux autres machines sans mot de passe.
if [ ! -f /home/vagrant/.ssh/id_rsa ]; then
    sudo -u vagrant ssh-keygen -t rsa -b 4096 -f /home/vagrant/.ssh/id_rsa -N ""
    echo "Clé SSH générée pour l'utilisateur vagrant."
else
    echo "Une clé SSH existe déjà."
fi

# Correction des permissions sur le dossier partagé (au cas où)
chown -R vagrant:vagrant /home/vagrant

echo ">>> Fin du bootstrap Admin !"
echo ">>> Ansible version : $(ansible --version | head -n 1)"