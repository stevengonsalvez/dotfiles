# Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.


if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH


export ZSH_DISABLE_COMPFIX=true
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# using zplug to manage plugins
export ZPLUG_HOME=$HOMEBREW_PREFIX/opt/zplug
source $ZPLUG_HOME/init.zsh


# sourcing antigen  
# source $HOMEBREW_PREFIX/share/antigen/antigen.zsh
# antigen init ~/.antigenrc
# antigen apply
# rm ~/.antigen/init.zsh

# # sourcing antidote
# source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh

# # initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
# antidote load

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="myagnoster"

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
# plugins=(git)
zplug "plugins/git",   from:oh-my-zsh
# zplug "bernardop/iterm-tab-color-oh-my-zsh"
zplug tysonwolker/iterm-tab-colors
zplug "plugins/dotenv", from:oh-my-zsh
zplug "djui/alias-tips"
zplug "zsh-users/zsh-syntax-highlighting"


# activate powerlevel10k
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
# autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# fallback source of git plugin 
# source ~/.oh-my-zsh/plugins/git/git.plugin.zsh


# homebrew path
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH

# Source dependent stuff
# source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_aliases
source $HOME/.zsh_functions



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
# [[ -s "/Users/stevengonsalvez/.gvm/scripts/gvm" ]] && source "/Users/stevengonsalvez/.gvm/scripts/gvm"
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH:$GOBIN
export GPG_TTY=$(tty)
#export GO111MODULE=off

gpgconf --launch gpg-agent


# NVM

  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# pyenv
export PATH=$(pyenv root)/shims:$PATH

## terraform
export TF_CLI_ARGS_plan="-compact-warnings"
export TF_CLI_ARGS_apply="-compact-warnings"

## Cheatsheet
PATH_DIR="$HOME/cht"  # or another directory on your $PATH
mkdir -p "$PATH_DIR"
curl -s https://cht.sh/:cht.sh > $PATH_DIR/cht.sh
chmod +x $PATH_DIR/cht.sh
export PATH=$PATH:$PATH_DIR

# #---------------------------------------------------------------------------------------------------
# # AUTOcdOMPLETES 
# #---------------------------------------------------------------------------------------------------
# # https://github.com/nvbn/thefuck
# eval $(thefuck --alias)


# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/google-cloud-sdk/completion.zsh.inc'; fi

#alternate for git colour
#PS1="20%D %*%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

autoload bashcompinit && bashcompinit
compinit -i
## this is path on the M1 macs
source /opt/homebrew/etc/bash_completion.d/az

# java
source ~/.sdkman/bin/sdkman-init.sh

## some executions of predefined functions
# setting github token (depends on .zsh_functions)

## copilot cli
eval "$(github-copilot-cli alias -- "$0")"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Not waiting 
# bwss
# bwe "gh-main-pat"

### for flutter
export PATH=$HOME/.gem/bin:$PATH
export PATH=$PATH:~/d/flutter/flutter/bin

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/stevengonsalvez/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/stevengonsalvez/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/stevengonsalvez/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/stevengonsalvez/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Install plugins if there are plugins that have not been installed
# if ! zplug check --verbose; then
#     printf "Install? [y/N]: "
#     if read -q; then
#         echo; zplug install
#     fi
# fi
zplug install

# Then, source plugins and add commands to $PATH
zplug load #--verbose

echo " ------------------------------READY --------------------------------- "

# Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
