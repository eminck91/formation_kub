

# Installer VS Code sur Windows depuis https://code.visualstudio.com/

Windows Terminal (Recommandé)

Windows Terminal est un terminal moderne qui améliore l'expérience WSL2 :

# Installer via Microsoft Store
# Chercher "Windows Terminal"

# Ou via winget (PowerShell)
winget install Microsoft.WindowsTerminal

Configurer Ubuntu comme profil par défaut :

    Ouvrir Windows Terminal
    Settings (Ctrl + ,)
    Startup → Default profile → Ubuntu-22.0

# Alias kubectl
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kdp='kubectl describe pod'
alias kdd='kubectl describe deployment'
alias kl='kubectl logs'
alias klf='kubectl logs -f'
alias kex='kubectl exec -it'

# Alias Minikube
alias mk='minikube'
alias mks='minikube status'
alias mkstart='minikube start'
alias mkstop='minikube stop'
alias mkd='minikube dashboard'

# Alias Docker
alias d='docker'
alias dps='docker ps'
alias di='docker images'

# Recharger .bashrc
alias reload='source ~/.bashrc'
