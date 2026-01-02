# ABOUTME: Main zsh configuration file - minimal server setup
# Sets up environment, paths, plugins, and sources other config files

# ========================================
# INSTANT PROMPT (Must be at the very top)
# ========================================
# Amazon Q pre block
# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ========================================
# ENVIRONMENT VARIABLES
# ========================================
# Terminal settings
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export GPG_TTY=$(tty)

# Oh-my-zsh settings
export ZSH_DISABLE_COMPFIX=true
export ZSH="$HOME/.oh-my-zsh"

# Homebrew
export HOMEBREW_PREFIX=$(brew --prefix)

# ========================================
# PATH CONFIGURATION (Consolidated)
# ========================================
# Base paths (Intel Mac uses /usr/local for Homebrew)
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# Development tools
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
export PATH="/usr/local/opt/openjdk@17/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH:$GOBIN

# Python (pyenv)
export PATH=$(pyenv root)/shims:$PATH

# Ruby
export PATH=$HOME/.gem/bin:$PATH

# Flutter
export PATH=$PATH:~/d/flutter/flutter/bin

# Custom scripts
PATH_DIR="$HOME/cht"
export PATH=$PATH:$PATH_DIR

# ========================================
# PLUGIN MANAGEMENT (zplug)
# ========================================
export ZPLUG_HOME=$HOMEBREW_PREFIX/opt/zplug
source $ZPLUG_HOME/init.zsh

# Load plugins (minimal set for server)
zplug "plugins/git", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"

# Install plugins if needed
if ! zplug check; then
    zplug install
fi

# Load plugins
zplug load

# ========================================
# THEME
# ========================================
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

# ========================================
# COMPLETIONS
# ========================================
autoload -Uz compinit
# Only check for insecure directories once a day
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

autoload bashcompinit && bashcompinit
[[ -f /usr/local/etc/bash_completion.d/az ]] && source /usr/local/etc/bash_completion.d/az

# ========================================
# TOOL CONFIGURATIONS
# ========================================
# Autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# NVM (properly initialized to make node available)
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

# Node.js
export NODE_OPTIONS="--no-deprecation"

# Terraform
export TF_CLI_ARGS_plan="-compact-warnings"
export TF_CLI_ARGS_apply="-compact-warnings"

# Cheatsheet directory (if exists)
[[ -d "$HOME/cht" ]] && export PATH=$PATH:$HOME/cht

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

# Azure CLI completions already loaded above

# SDKMAN is lazy-loaded below

## some executions of predefined functions
# setting github token (depends on .zsh_functions)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Not waiting 
# bwss
# bwe "gh-main-pat"
# For amazon q
export EDITOR=code

# Flutter/Android paths disabled for server use
# export PATH=$PATH:~/d/flutter/flutter/bin
# export ANDROID_HOME=$HOME/Library/Android/sdk

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
function sdk() {
  unset -f sdk
  [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
  sdk "$@"
}

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Conda (lazy loading)
function conda() {
  unset -f conda
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
  conda "$@"
}

# Google Cloud SDK
[[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]] && source "$HOME/google-cloud-sdk/path.zsh.inc"
[[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]] && source "$HOME/google-cloud-sdk/completion.zsh.inc"

# GPG
gpgconf --launch gpg-agent

# ========================================
# HISTORY CONFIGURATION
# ========================================
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space
setopt HIST_VERIFY               # Don't execute immediately upon history expansion
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits
setopt SHARE_HISTORY             # Share history between all sessions

# ========================================
# GENERAL ZSH OPTIONS
# ========================================
setopt AUTO_CD                   # If you type a directory name, cd into it
# setopt CORRECT                   # Try to correct command spelling (DISABLED - causes annoying prompts)
setopt COMPLETE_IN_WORD          # Complete from both ends of a word
setopt IGNORE_EOF                # Don't exit on EOF
setopt INTERACTIVE_COMMENTS      # Allow comments in interactive shells

# Disable autocorrection for specific commands that are commonly misidentified
unsetopt CORRECT_ALL
setopt NO_CORRECT

# ========================================
# SOURCE ADDITIONAL CONFIGS
# ========================================
[[ -f "$HOME/.zsh_aliases" ]] && source "$HOME/.zsh_aliases"
[[ -f "$HOME/.zsh_functions" ]] && source "$HOME/.zsh_functions"
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# Terminal tab name disabled for server use

# Rust path
export PATH="$HOME/.cargo/env:$HOME/.cargo/bin:$PATH"


# ========================================
# FINAL SETUP (Must be at the end)
# ========================================
# mise tool version manager
command -v mise &>/dev/null && eval "$(mise activate zsh)"
