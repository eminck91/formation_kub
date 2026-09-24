Vous (kubectl)
    │
    ▼
┌───────────────────────────────────────────┐
│      Cluster Kubernetes                   │
│                                          │
│  API Server → etcd                       │
│       ↓                                  │
│  Deployment Controller                   │
│       ↓                                  │
│  ReplicaSet Controller                   │
│       ↓                                  │
│  Scheduler                               │
│       ↓                                  │
│  ┌────────────────────────┐             │
│  │  Nœud (minikube)       │             │
│  │                        │             │
│  │  Kubelet               │             │
│  │    ↓                   │             │
│  │  Container Runtime     │             │
│  └────────┬───────────────┘             │
│           │                              │
└───────────┼──────────────────────────────┘
            │ Pull image
            ▼
    ┌─────────────────┐
    │   Docker Hub    │  registry-1.docker.io
    │  nginx:latest   │  (image officielle)
    └─────────────────┘

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


echo 'export PROMPT_DIRTRIM=2' >> ~/.bashrc
# Limite l'affichage du chemin dans le prompt aux 2 derniers dossiers,
# remplace le reste par "..."


source ~/.bashrc
# Recharge la config bash sans redémarrer le terminal



# k9s - Terminal UI pour Kubernetes
curl -sS https://webinstall.dev/k9s | bash
source ~/.bashrc

# Helm - Gestionnaire de packages Kubernetes
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# kubectx/kubens - Changer de contexte facilement
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens




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



k


