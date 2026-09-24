#Installation de VS Code

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


#Installation de kubectl et minikube (apprentissage Kubernetes)

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



# Ajouter à ~/.bashrc
echo 'source <(kubectl completion bash)' >> ~/.bashrc
echo 'alias k=kubectl' >> ~/.bashrc
echo 'complete -o default -F __start_kubectl k' >> ~/.bashrc

# Recharger
source ~/.bashrc




