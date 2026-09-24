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




Debugging et Troubleshooting

# Le plus important : describe!
kubectl describe pod <pod-name>

# Vérifier les events récents
kubectl get events --sort-by=.metadata.creationTimestamp

# Events d'un namespace spécifique
kubectl get events -n <namespace> --sort-by=.lastTimestamp

# Warnings seulement
kubectl get events --field-selector type=Warning

# Logs du conteneur précédent (crashé)
kubectl logs <pod-name> --previous

# Logs de tous les conteneurs d'un pod
kubectl logs <pod-name> --all-containers=true

# Logs avec timestamps
kubectl logs <pod-name> --timestamps

# Dernières 100 lignes
kubectl logs <pod-name> --tail=100

# Logs depuis les 5 dernières minutes
kubectl logs <pod-name> --since=5m


Pod Temporaire de Debug
# Pod busybox éphémère
kubectl run tmp --image=busybox --rm -it -- /bin/sh

# Pod avec network tools
kubectl run netshoot --image=nicolaka/netshoot --rm -it -- /bin/bash

# Pod curl pour tester les services
kubectl run curl --image=curlimages/curl --rm -it -- sh

# Tester un service interne
kubectl run tmp --image=nginx:alpine --rm -it -- curl http://my-service:80

# Debug avec alpine
kubectl run alpine --image=alpine --rm -it -- /bin/sh



Debug de Réseau
# Tester la résolution DNS
kubectl run dnsutils --image=gcr.io/kubernetes-e2e-test-images/dnsutils:1.3 --rm -it -- nslookup kubernetes.default

# Tester la connectivité
kubectl run tmp --image=busybox --rm -it -- wget -O- http://my-service:80

# Debug réseau avancé
kubectl run netshoot --image=nicolaka/netshoot --rm -it -- /bin/bash
# Puis dans le pod :
# traceroute google.com
# tcpdump
# iperf3

# Vérifier les endpoints d'un service
kubectl get endpoints my-service

# Voir la config DNS d'un pod
kubectl exec <pod-name> -- cat /etc/resolv.conf

# Test de connectivité entre namespaces
kubectl run tmp -n namespace1 --image=busybox --rm -it -- wget -O- http://service.namespace2.svc.cluster.local



Port-Forward et Proxy
# Port-forward simple
kubectl port-forward pod/nginx 8080:80

# Port-forward d'un service
kubectl port-forward service/nginx 8080:80

# Port-forward d'un deployment
kubectl port-forward deployment/nginx 8080:80

# Port-forward avec toutes les interfaces
kubectl port-forward --address 0.0.0.0 pod/nginx 8080:80

# Proxy vers l'API Kubernetes
kubectl proxy --port=8001

# Accéder à l'API via le proxy
# http://localhost:8001/api/v1/namespaces/default/pods







Inspection de Ressources
# Vérifier la définition d'une ressource
kubectl explain pod
kubectl explain pod.spec
kubectl explain pod.spec.containers
kubectl explain deployment.spec.strategy

# Comparer un manifest avec l'état actuel
kubectl diff -f deployment.yaml

# Dry-run côté client (validation syntaxe)
kubectl apply -f deployment.yaml --dry-run=client

# Dry-run côté serveur (validation + admission)
kubectl apply -f deployment.yaml --dry-run=server

# Vérifier les permissions
kubectl auth can-i create deployments
kubectl auth can-i delete pods --as=user@example.com
kubectl auth can-i '*' '*' --all-namespaces



Debug de Problèmes Courants
# Pod en CrashLoopBackOff
kubectl describe pod <pod-name>  # Voir les events
kubectl logs <pod-name> --previous  # Logs du crash
kubectl get pod <pod-name> -o yaml  # Config complète

# ImagePullBackOff
kubectl describe pod <pod-name>  # Vérifier l'erreur exacte
kubectl get pod <pod-name> -o jsonpath='{.status.containerStatuses[*].state.waiting.message}'

# Pending pods
kubectl describe pod <pod-name>  # Voir pourquoi pas schedulé
kubectl get events --field-selector involvedObject.name=<pod-name>

# Service ne route pas le trafic
kubectl get endpoints <service-name>  # Vérifier les endpoints
kubectl describe service <service-name>
kubectl get pods -l app=<label>  # Vérifier les labels

# Node NotReady
kubectl describe node <node-name>
kubectl get nodes -o wide
kubectl top nodes




#Resource Requests et Limits
# Pod avec resources
kubectl run nginx --image=nginx \
  --requests='cpu=100m,memory=256Mi' \
  --limits='cpu=200m,memory=512Mi' \
  $do > pod.yaml

# Vérifier la consommation
kubectl top pods
kubectl top pods --containers
kubectl top nodes

# Pods sans limits (risqué!)
kubectl get pods -A -o json | \
  jq -r '.items[] | select(.spec.containers[].resources.limits == null) | "\(.metadata.namespace)/\(.metadata.name)"'

# Voir l'utilisation par namespace
kubectl top pods -A --sort-by=memory
kubectl top pods -A --sort-by=cpu





# Créer un LimitRange
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: LimitRange
metadata:
  name: default-limits
spec:
  limits:
  - default:
      memory: 512Mi
      cpu: 500m
    defaultRequest:
      memory: 256Mi
      cpu: 250m
    type: Container
EOF

# Créer un ResourceQuota
kubectl create quota my-quota \
  --hard=pods=10,requests.cpu=4,requests.memory=4Gi,limits.cpu=10,limits.memory=10Gi

# Vérifier les quotas
kubectl get resourcequota
kubectl describe resourcequota my-quota




# HPA simple
kubectl autoscale deployment nginx --min=2 --max=10 --cpu-percent=80

# HPA avec metrics personnalisées
cat <<EOF | kubectl apply -f -
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: nginx-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: nginx
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 80
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 80
EOF

# Vérifier le HPA
kubectl get hpa
kubectl describe hpa nginx-hpa

# Vertical Pod Autoscaler (nécessite installation)
# Recommande les bonnes valeurs de requests/limits




#Secrets et ConfigMaps Sécurisés
# Créer un secret depuis un fichier sans l'afficher
kubectl create secret generic db-creds \
  --from-file=username=./username.txt \
  --from-file=password=./password.txt

# Secret TLS
kubectl create secret tls tls-secret \
  --cert=path/to/cert.pem \
  --key=path/to/key.pem

# Docker registry secret
kubectl create secret docker-registry regcred \
  --docker-server=<registry-url> \
  --docker-username=<username> \
  --docker-password=<password> \
  --docker-email=<email>

# Sceller un secret (avec sealed-secrets)
# https://github.com/bitnami-labs/sealed-secrets
kubeseal --format=yaml < secret.yaml > sealed-secret.yaml

# Encoder/décoder base64
echo -n 'my-password' | base64
echo 'bXktcGFzc3dvcmQ=' | base64 -d

# Rotation des secrets
kubectl delete secret app-secret
kubectl create secret generic app-secret --from-literal=password=new-password
kubectl rollout restart deployment/app