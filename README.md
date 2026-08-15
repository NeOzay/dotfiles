# Dotfiles

Gestion des dotfiles via un dépôt Git bare — les fichiers restent à leur emplacement dans `$HOME`, sans symlinks ni outils tiers.

---

## Prérequis

- `git`
- `zsh` + `oh-my-zsh` (si applicable)
- Accès SSH configuré vers GitHub (ou remplacer les URLs SSH par HTTPS)

---

## Authentification SSH avec GitHub

### 1. Générer la clé SSH
```bash
ssh-keygen -t ed25519 -C "ton@email.com" -f ~/.ssh/git
```

### 2. Ajouter la clé à `~/.ssh/config`
```bash
cat >> ~/.ssh/config << 'EOF'
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/git
    AddKeysToAgent yes
EOF
```

### 3. Copier la clé publique
```bash
cat ~/.ssh/git.pub
```

Ajouter la clé sur GitHub : **Settings → SSH and GPG keys → New SSH key** → coller.

### 4. Tester la connexion
```bash
ssh -T git@github.com
```

Résultat attendu : `Hi <utilisateur>! You've successfully authenticated...`

---

## Premier déploiement sur une nouvelle machine

```bash
# 1. Cloner le dépôt en mode bare
git clone --bare git@github.com:NeOzay/dotfiles.git $HOME/.dotfiles

# 2. Définir l'alias de gestion
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# 3. Configurer le suivi de la branche `dotfiles` (voir l'avertissement ci-dessous)
dotfiles config --local remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
dotfiles config --local branch.dotfiles.remote origin
dotfiles config --local branch.dotfiles.merge refs/heads/dotfiles
dotfiles config --local pull.ff only
dotfiles fetch origin
dotfiles remote set-head origin dotfiles

# 4. Éviter d'afficher tous les fichiers non-trackés de $HOME
dotfiles config --local status.showUntrackedFiles no

# 5. Déployer les fichiers dans $HOME
dotfiles checkout dotfiles
```

> **Pourquoi l'étape 3 est indispensable** : `git clone --bare` ne configure ni refspec
> `remote.origin.fetch`, ni refs de suivi `refs/remotes/origin/*`, ni `branch.<nom>.merge` —
> git traite un dépôt bare comme un miroir. Ajouter `--branch dotfiles --single-branch` n'y
> change rien, ces options sont sans effet en mode bare. Sans l'étape 3, un `dotfiles pull`
> sans argument suit le `HEAD` distant du dépôt et peut tirer une autre branche que
> `dotfiles` — la branche `readme`, qui ne contient que ce fichier, provoquant la
> suppression de tous les dotfiles du suivi.

> **Conflits éventuels** : si des fichiers existent déjà (ex. `~/.zshrc` par défaut),
> Git refusera le checkout. Supprimer ou sauvegarder les fichiers concernés avant de relancer.

```bash
# Exemple : sauvegarder avant de remplacer
mkdir -p ~/.dotfiles-backup
dotfiles checkout 2>&1 | grep "^\s" | awk '{print $1}' | xargs -I{} mv $HOME/{} ~/.dotfiles-backup/{}
dotfiles checkout
```

---

## Rendre l'alias permanent

Ajouter dans `~/.zshrc` (ou `~/.bashrc`) :

```zsh
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Puis recharger :

```bash
source ~/.zshrc
```

---

## Utilisation quotidienne

L'alias `dotfiles` remplace `git` pour toutes les opérations sur les dotfiles.

```bash
# Voir l'état des fichiers trackés
dotfiles status

# Ajouter un fichier
dotfiles add ~/.zshrc

# Committer
dotfiles commit -m "feat: update zshrc"

# Synchroniser
dotfiles pull
dotfiles push
```

---

## Ajouter un nouveau fichier à tracker

```bash
dotfiles add ~/.config/nvim/init.lua
dotfiles commit -m "feat: add neovim config"
dotfiles push
```

---

## Structure du dépôt

Les fichiers sont trackés directement depuis `$HOME`. Exemples de fichiers gérés :

```
~/.zshrc
~/.gitconfig
~/.config/nvim/init.lua
...
```

Le dépôt Git bare est stocké dans `~/.dotfiles/` et n'interfère pas avec les autres dépôts Git du système.

---

## Branches

| Branche | Contenu |
|---|---|
| `dotfiles` | Les dotfiles eux-mêmes. **C'est la branche de travail.** |
| `readme` | Ce fichier uniquement. Aucun dotfile — ne jamais la fusionner dans `dotfiles`. |

Les deux branches sont volontairement disjointes : `readme` ne contient pas les dotfiles,
et `dotfiles` ne contient pas ce README. Fusionner l'une dans l'autre supprime le contenu
de la branche de destination.
