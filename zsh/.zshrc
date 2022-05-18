# Fig pre block. Keep at the top of this file.
. "$HOME/.fig/shell/zshrc.pre.zsh"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="myagnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git)
plugins=(
  git
  bundler
  dotenv
  osx
  rake
  rbenv
  ruby
  kubectl
  autojump
  gh
)

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

#---------------------------------------------------------------------------------------------------
# PATH groupings 
#---------------------------------------------------------------------------------------------------

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# export PATH="$HOME/d/9.1.4.0-IBM-MQ-Toolkit-MacX64/bin:$HOME/d/9.1.4.0-IBM-MQ-Toolkit-MacX64/samp/bin:$PATH"
# export DYLD_LIBRARY_PATH="$HOME/d/9.1.4.0-IBM-MQ-Toolkit-MacX64/lib64"
export PATH="/usr/local/opt/python@3.8/bin:/usr/local/bin:$PATH"
export PATH="/usr/local/opt/openjdk@17/bin:$PATH"

#---------------------------------------------------------------------------------------------------
# TOOL specific groupings 
#---------------------------------------------------------------------------------------------------

# GOLANG
export GOPATH=~/d/go
export PATH=$PATH:$GOPATH
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent


# NVM

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## redo config

export REDO_EDITOR="vim"
export HISTFILE="$HOME/.zsh_history"
source "$(redo alias-file)"




#---------------------------------------------------------------------------------------------------
# Functions 
#---------------------------------------------------------------------------------------------------

bwss(){
  eval $(bw unlock | grep export | awk -F"\$" {'print $2'})
}


bwdd(){
	bw delete item $(bw get item $1 | jq .id | tr -d '"')
}

bws(){
  eval $(bw get item $1 | jq -r '.notes')
}

bwc(){
  export | awk '{printf "%s\\n", $0}' |  sed 's/"/\\"/g' >/tmp/.env
  bw get template item | jq --arg a "$(cat /tmp/env)" --arg b "$1" '.type = 2 | .secureNote.type = 0 | .notes = $a | .name = $b' | bw encode | bw create item
}

#---------------------------------------------------------------------------------------------------
# ALIASES 
#---------------------------------------------------------------------------------------------------

#alias j="autojump"
alias vimmy="vim -c 'set mouse=a'"
alias gst="git status"
alias gview="gh repo view --web"
git config --global alias.add-commit '!git add -A && git commit'
function lazygit() {
    git add .
    git commit -a -m "$1"
    git push
}
eval $(thefuck --alias)

# All bitwarden
alias bwgaz="bw list items | jq '.[] | .name' | grep "az-""
alias bwg="bw get item"

#---------------------------------------------------------------------------------------------------
# AUTOcdOMPLETES 
#---------------------------------------------------------------------------------------------------

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/google-cloud-sdk/completion.zsh.inc'; fi

#alternate for git colour
#PS1="20%D %*%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

autoload bashcompinit && bashcompinit
compinit -i
source /usr/local/etc/bash_completion.d/az




# Fig post block. Keep at the bottom of this file.
# . "$HOME/.fig/shell/zshrc.post.zsh"