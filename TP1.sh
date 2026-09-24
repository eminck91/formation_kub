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


    # Créer un déploiement nginx
kubectl create deployment nginx-demo --image=nginx:latest

# Vérifier le déploiement
kubectl get deployments

# Vérifier les pods
kubectl get pods

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


#


