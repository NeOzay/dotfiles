# Dotfiles

Gestion des dotfiles via un dépôt Git bare — les fichiers restent à leur emplacement dans `$HOME`, sans symlinks ni outils tiers.

---

## Prérequis

- `git`
- `zsh` + `oh-my-zsh` (si applicable)
- Accès SSH configuré vers GitHub (ou remplacer les URLs SSH par HTTPS)

---

## Premier déploiement sur une nouvelle machine

```bash
# 1. Cloner le dépôt en mode bare
git clone git clone --branch dotfiles --single-branch --bare github.com:NeOzay/dotfiles.git $HOME/.dotfiles

# 2. Définir l'alias de gestion
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# 3. Éviter d'afficher tous les fichiers non-trackés de $HOME
dotfiles config --local status.showUntrackedFiles no

# 4. Déployer les fichiers dans $HOME
dotfiles checkout
```

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
