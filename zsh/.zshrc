# ABOUTME: Main zsh configuration file - optimized for performance
# Sets up environment, paths, plugins, and sources other config files

# ========================================
# INSTANT PROMPT (Must be at the very top)
# ========================================
# Amazon Q pre block
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

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
# Base paths
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
export PATH=/usr/local/bin:$PATH

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

# Load plugins
zplug "plugins/git", from:oh-my-zsh
zplug "tysonwolker/iterm-tab-colors"
zplug "plugins/dotenv", from:oh-my-zsh
zplug "djui/alias-tips"
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
[[ -f /opt/homebrew/etc/bash_completion.d/az ]] && source /opt/homebrew/etc/bash_completion.d/az

# ========================================
# TOOL CONFIGURATIONS
# ========================================
# Autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# NVM (lazy loading for faster startup)
export NVM_DIR="$HOME/.nvm"
function nvm() {
  unset -f nvm
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
  nvm "$@"
}

# Node.js
export NODE_OPTIONS="--no-deprecation"

# Terraform
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
eval "$(gh copilot alias -- zsh)"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Not waiting 
# bwss
# bwe "gh-main-pat"
# For amazon q
export EDITOR=code

### for flutter
export PATH=$HOME/.gem/bin:$PATH
export PATH=$PATH:~/d/flutter/flutter/bin

### for android
export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools;$HOME/Library/Android/sdk/tools/bin

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

# GitHub Copilot CLI
eval "$(github-copilot-cli alias -- "$0")"
eval "$(gh copilot alias -- zsh)"

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
setopt CORRECT                   # Try to correct command spelling
setopt COMPLETE_IN_WORD          # Complete from both ends of a word
setopt IGNORE_EOF                # Don't exit on EOF
setopt INTERACTIVE_COMMENTS      # Allow comments in interactive shells

# ========================================
# SOURCE ADDITIONAL CONFIGS
# ========================================
[[ -f "$HOME/.zsh_aliases" ]] && source "$HOME/.zsh_aliases"
[[ -f "$HOME/.zsh_functions" ]] && source "$HOME/.zsh_functions"
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# ========================================
# FINAL SETUP (Must be at the end)
# ========================================
# Windsurf
export PATH="/Users/stevengonsalvez/.codeium/windsurf/bin:$PATH"

eval "$(mise activate zsh)"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

# Ready message
echo " ✨ Terminal Ready - $(date +%H:%M:%S) ✨"