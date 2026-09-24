# Démarrer minikube avec Docker comme driver
minikube start --driver=docker

# Vérifier le statut
minikube status


# Vérifier que tous les pods système sont prêts
kubectl get pods -n kube-system

# Attendre que tous les pods soient Running
kubectl wait --for=condition=ready pod --all -n kube-system --timeout=300s


# Afficher les informations du cluster
kubectl cluster-info

# Lister les nœuds
kubectl get nodes

# Afficher plus de détails sur les nœuds
kubectl describe nodes


# Voir les événements du cluster en temps réel
kubectl get events --watch

# Voir les détails du déploiement d'un pod
kubectl describe pod <pod-name>


# Docker Hub (défaut)
kubectl create deployment nginx --image=nginx:latest

# Google Container Registry
kubectl create deployment nginx --image=gcr.io/project/nginx:v1

# Amazon ECR
kubectl create deployment nginx --image=123456789.dkr.ecr.us-east-1.amazonaws.com/nginx:v1

# Registry privé
kubectl create deployment nginx --image=registry.example.com:5000/nginx:v1


# Obtenir plus d'informations sur le pod
kubectl get pods -o wide

# Décrire le pod (remplacer <pod-name> par le nom réel)
kubectl describe pod <pod-name>

# Voir les logs du pod
kubectl logs <pod-name>







#______________________________________________

#Démarrage d'une session de travail

# 1. Ouvrir Ubuntu depuis le menu Démarrer

# 2. Démarrer Docker (si pas automatique)
sudo service docker start

# 3. Démarrer Minikube
minikube start

# 4. Vérifier
kubectl get nodes

# 5. Naviguer vers votre projet
cd ~/kubernetes-formation


#Vérifications rapides

# Cluster OK ?
kubectl get nodes

# Pods OK ?
kubectl get pods -A

# Services OK ?
kubectl get svc

# Tout est OK ?
kubectl get all

#___________________________________________________


# Obtenir tous les pods qui ne sont pas Running
kubectl get pods --field-selector=status.phase!=Running

# Trier les pods par création
kubectl get pods --sort-by=.metadata.creationTimestamp

# Trier par nombre de restarts
kubectl get pods --sort-by=.status.containerStatuses[0].restartCount

# Obtenir les images utilisées
kubectl get pods -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.containers[*].image}{"\n"}{end}'

# Lister les pods avec leur node
kubectl get pods -o wide --sort-by=.spec.nodeName

# Obtenir tous les secrets décodés (attention en prod!)
kubectl get secrets -o json | jq '.items[] | {name: .metadata.name, data: .data | map_values(@base64d)}'

# Lister toutes les ressources dans un namespace
kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --show-kind --ignore-not-found -n <namespace>

# Compter les pods par namespace
kubectl get pods -A --no-headers | awk '{print $1}' | sort | uniq -c

# Trouver les pods sans limits
kubectl get pods -A -o json | jq '.items[] | select(.spec.containers[].resources.limits == null) | .metadata.name'




#Watch et Monitoring en Temps Réel
# Watch sur les pods
kubectl get pods -w

# Watch avec sortie wide
kubectl get pods -o wide -w

# Surveiller les events
kubectl get events -w

# Suivre le rollout
kubectl rollout status deployment/nginx -w

# Logs en temps réel avec label selector
kubectl logs -f -l app=nginx --all-containers=true

# Logs de tous les pods d'un deployment
kubectl logs -f deployment/nginx

# Combiner watch avec grep
kubectl get pods -w | grep --line-buffered "nginx"




