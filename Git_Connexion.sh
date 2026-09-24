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


eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
ssh -T git@github.com



The key fingerprint is:
SHA256:Fh3LKhxAcK94WSKdnXIQZSWDVRyJD3kensi6w+tTI2k emin_caluk_91@hotmail.fr
The key's randomart image is:
+--[ED25519 256]--+
|  .o*=**+o.      |
|   o.B++=o o     |
|  . =.BB.o+      |
|   o Oo.=o       |
|  . +oo S        |
|   .E oo         |
|   o + .         |
|    =            |
|   .o+           |
+----[SHA256]-----+


ssh -T git@github.com
projet_kub



ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIMAmjt7pGn/q8/kiLajSnxVRMpA6N7lj3LQRbcB/WwS emin_caluk_91@hotmail.fr

# Si tu clones un repo existant
git clone git@github.com:eminck91/formation_kub.git

# Ou si tu pars d'un dossier local existant
cd ton-projet
git init
git remote add origin git@github.com:eminck91/formation_kub.git
git add .
git commit -m "Premier commit"
git push -u origin main


https://github.com/eminck91/formation_kub




#. Premier push vers GitHub
cd ton-repo   # dossier où sont tes fichiers
git status
git add .
git commit -m "Premiers fichiers du projet"
git push -u origin main


#10. Cycle de travail au quotidien (à répéter à chaque modification)
git status          #  voir ce qui a changé
git add .
git status           #  confirmer que les fichiers sont bien en vert (staged)
git commit -m "Description du changement"
git push