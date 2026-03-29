# export HOME="$(realpath $HOME)"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Install oh-my-zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# D�finir l'emplacement du fichier de cache Zcompdump
export ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump-$HOST-$ZSH_VERSION"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  poetry
  zsh-syntax-highlighting
  zsh-autosuggestions
  distrobox
  ollama
  # pnpm-shell-completion
  # pnpm
) 

# fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
# autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
if [ -d "$HOME/.local/bin/" ] ; then
  PATH="$PATH:$HOME/.local/bin"
fi

if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
  # add Homebrew to path
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
fi

# eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/atomicBit.omp.json')"

autoload -U compinit && compinit

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BDésolé, pas de résultats pour : %d%b'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:mv:*' ignore-line yes
zstyle ':completion:*:cp:*' ignore-line yes

autoload -U bashcompinit
bashcompinit

autoload -U promptinit
promptinit
# if [[ -f `realpath ~/.termux` ]];then
#   PROMPT='%B%{$fg[blue]%}┌─(%{$fg[green]%}%0~%{$fg[blue]%})
# └>%{$fg[cyan]%}$ %{$reset_color%}%b'
# else
#   PROMPT='%{$fg[blue]%}┌─(%{$fg[green]%}%0~%{$fg[blue]%})
# └>%{$fg[cyan]%}$ %{$reset_color%}'
# fi
# Example aliases
alias zshconfig="nvim ~/.zshrc"
alias sozsh="source ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
# alias ll="lsd -a"
alias nvconf="cd ~/.config/nvim/ && nvim"


alias cls=clear
# alias ll="ls -a"                             

# alias ls='ls --color=auto' 
alias grep='grep --color=auto' 
alias fgrep='fgrep --color=auto' 
alias egrep='egrep --color=auto' 
alias diff='diff - -color=auto'
#man color
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

command -v lsd > /dev/null && alias ls='lsd --group-dirs first'

if [[ $1 == eval ]]
then
    "$@"
set --
fi

export PATH="$HOME/.local/bin:$PATH"

export YARN_ENABLE_GLOBAL_CACHE=true

vv() {
  select config in nvimold nvim
  do NVIM_APPNAME=$config nvim $1; break; done
}


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# add dotnet to path
export PATH="/home/linuxbrew/.linuxbrew/opt/dotnet@8/bin:$PATH"
# export DOTNET_ROOT="/home/linuxbrew/.linuxbrew/opt/dotnet@8/libexec"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# completion
command -v pnpm > /dev/null && eval "$(pnpm completion zsh)"
# pnpm end

command -v gh > /dev/null && eval "$(gh completion -s zsh)"

command -v fcitx5-remote > /dev/null && fcitx5-remote -s keyboard-fr-nodeadkeys

alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
