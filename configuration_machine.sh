1. Mise à jour du système AlmaLinux

sudo dnf update -y
sudo dnf upgrade -y
sudo dnf autoremove -y


2. Installation de VS Code

# Importer la clé GPG Microsoft
sudo rpmkeys --import https://packages.microsoft.com/keys/microsoft.asc

# Créer le fichier de dépôt
sudo tee /etc/yum.repos.d/vscode.repo > /dev/null <<EOF
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

# Installer
sudo dnf check-update
sudo dnf install code -y

# Lancer
code


3. Installation de kubectl et minikube (apprentissage Kubernetes)

# 1. Télécharger kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# 2. Rendre kubectl exécutable
chmod +x kubectl

# 3. Déplacer kubectl dans le PATH
sudo mv kubectl /usr/local/bin/

# 4. Vérifier kubectl
kubectl version --client

# 5. Télécharger minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

# 6. Installer minikube dans le PATH
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# 7. Vérifier minikube
minikube version

# 8. Installer les dépendances pour le dépôt Docker
sudo dnf install -y dnf-plugins-core

# 9. Ajouter le dépôt officiel Docker
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# 10. Installer Docker
sudo dnf install -y docker-ce docker-ce-cli containerd.io

# 11. Démarrer Docker et l'activer au boot
sudo systemctl enable --now docker

# 12. Ajouter ton utilisateur au groupe docker
sudo usermod -aG docker $USER

# 13. Appliquer le changement de groupe
newgrp docker

# 14. Démarrer le cluster minikube
minikube start --driver=docker

# 15. Vérifier que le cluster fonctionne
kubectl get nodes





# bis. Installer bash-completion si pas déjà présent
sudo dnf install -y bash-completion











nmcli connection show
# Liste toutes les connexions réseau configurées sur la machine
# (nom de connexion, UUID, type, interface associée)



sudo nmcli connection modify "Bbox-B7025250" \
  ipv4.addresses 192.168.1.82/24 \
  ipv4.gateway 192.168.1.254 \
  ipv4.dns "8.8.8.8,1.1.1.1" \
  ipv4.method manual
# Modifie la connexion "Bbox-B7025250" pour lui fixer une IP statique,
# une passerelle et des serveurs DNS, au lieu du DHCP automatique


sudo nmcli connection down "Bbox-B7025250" && sudo nmcli connection up "Bbox-B7025250"
# Désactive puis réactive la connexion pour que la nouvelle config IP soit appliquée






sudo dnf install -y git
git --version

git config --global user.name "eminck91"
git config --global user.email "emin_caluk_91@hotmail.fr"


https://github.com/eminck91/my-gitops-repo/tree/Project_kub/projet_kub


# Générer une clé SSH
ssh-keygen -t ed25519 -C "emin_caluk_91@hotmail.fr"
# Appuie sur Entrée pour accepter l'emplacement par défaut, puis choisis une passphrase (ou vide)

# Afficher la clé publique à copier
cat ~/.ssh/id_ed25519.pub


The key fingerprint is:
SHA256:eMnH1RWQhMsDaLGGPleSkATw11QdoKn3VFbYwJHyiSg emin_caluk_91@hotmail.fr
The key's randomart image is:
+--[ED25519 256]--+
| ...oo.o+o++X+o.o|
|  .  .=o=o *.+ . |
|   . o.O..*o+ .  |
|    oEo+o+oB     |
|     +ooS.o .    |
|      +.o.       |
|         .       |
|                 |
|                 |
+----[SHA256]-----+


(/home/kubstudent/.ssh/id_ed25519): keygit