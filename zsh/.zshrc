# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# ABOUTME: Main zsh configuration file - optimized for fast startup
# Rule: nothing at startup may fork a process. Slow tool init is cached
# (~/.cache/zsh) or lazy-loaded behind a stub function. Run `zshtime` to
# measure, `zshcache-clear` after upgrading gh/mise/pyenv/etc.

# ========================================
# NON-INTERACTIVE SHELL EARLY EXIT
# ========================================
if [[ ! -o interactive ]]; then
  export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:$PATH
  export PATH="$HOME/.cargo/bin:$PATH"
  export PATH="$HOME/.local/bin:$PATH"
  export GOPATH=$HOME/go
  export GOBIN=$GOPATH/bin
  export PATH=$PATH:$GOPATH:$GOBIN
  return 0
fi

# ========================================
# INSTANT PROMPT (must stay near the top)
# ========================================
# Anything that prints to the console before this point kills instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

setopt extended_glob

# ========================================
# EVAL CACHE
# ========================================
# Caches the stdout of slow `eval "$(tool init)"` commands. Refreshes when the
# cache is older than a week; `zshcache-clear` forces it after a tool upgrade.
ZSH_EVALCACHE_DIR=$HOME/.cache/zsh
[[ -d $ZSH_EVALCACHE_DIR ]] || mkdir -p $ZSH_EVALCACHE_DIR

_evalcache() {  # _evalcache <name> <command> [args...]
  local f=$ZSH_EVALCACHE_DIR/$1.zsh; shift
  if [[ ! -s $f || -n ${f}(#qNmh+168) ]]; then
    command "$@" >| $f 2>/dev/null || return
  fi
  source $f
}

zshcache-clear() { rm -f $ZSH_EVALCACHE_DIR/*.zsh(N); echo "eval cache cleared; run: exec zsh" }
zshtime() { for i in 1 2 3; do /usr/bin/time zsh -i -c exit; done }
zshprof() { ZSH_PROFILE_RC=1 zsh -i -c 'zprof | head -30' }

[[ -n $ZSH_PROFILE_RC ]] && zmodload zsh/zprof

# ========================================
# ENVIRONMENT VARIABLES
# ========================================
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export GPG_TTY=$TTY               # zsh sets $TTY for free; $(tty) forks
export EDITOR=code
export NODE_OPTIONS="--no-deprecation"
export TF_CLI_ARGS_plan="-compact-warnings"
export TF_CLI_ARGS_apply="-compact-warnings"
export LEARNINGS_HOME="$HOME/.learnings"

export ZSH_DISABLE_COMPFIX=true
export ZSH="$HOME/.oh-my-zsh"
export HOMEBREW_PREFIX=/opt/homebrew   # hardcoded; `brew --prefix` costs ~150ms

# Oracle/ora defaults
export ORA_ENGINE="browser"
export ORA_PRIMARY_MODEL="gemini-3-pro"
export ORA_FALLBACK_MODEL="gpt-5.2-pro"

# ========================================
# PATH (single pass, no subshells)
# ========================================
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export ANDROID_HOME=$HOME/Library/Android/sdk
export PYENV_ROOT=$HOME/.pyenv

path=(
  /usr/sbin
  $HOME/.local/bin
  $HOME/.antigravity/antigravity/bin
  $HOME/.codeium/windsurf/bin
  $HOME/.cargo/bin
  $HOME/.gem/bin
  $PYENV_ROOT/shims
  ${KREW_ROOT:-$HOME/.krew}/bin
  /usr/local/opt/openjdk@17/bin
  /usr/local/opt/python@3.8/bin
  /opt/homebrew/bin
  /opt/homebrew/sbin
  /usr/local/bin
  $path
  $GOPATH
  $GOBIN
  $HOME/d/flutter/flutter/bin
  $HOME/cht
  $ANDROID_HOME/emulator
  $ANDROID_HOME/platform-tools
  $ANDROID_HOME/cmdline-tools/latest/bin
)
typeset -U path                       # dedupe, keep first occurrence
path=($^path(N-/))                    # drop entries that don't exist

# Node from nvm's default alias, without sourcing nvm.sh (~1s). `nvm` itself is
# lazy-loaded below; this only puts the default version's bin on PATH.
export NVM_DIR="$HOME/.nvm"
if [[ -r $NVM_DIR/alias/default ]]; then
  read -r _nvm_default < $NVM_DIR/alias/default
  [[ -d $NVM_DIR/versions/node/$_nvm_default/bin ]] && \
    path=($NVM_DIR/versions/node/$_nvm_default/bin $path)
  unset _nvm_default
fi

# ========================================
# PLUGINS (sourced directly; zplug added ~800ms of flock/awk overhead)
# ========================================
ZSH_PLUGINS=$HOME/.zsh/plugins

# Bootstrap on a fresh machine (or after deleting ~/.zsh/plugins):
zsh-plugins-install() {
  local p
  mkdir -p $ZSH_PLUGINS
  for p in djui/alias-tips zsh-users/zsh-autosuggestions \
           zsh-users/zsh-completions zsh-users/zsh-syntax-highlighting; do
    [[ -d $ZSH_PLUGINS/${p:t} ]] || git clone --depth 1 https://github.com/$p $ZSH_PLUGINS/${p:t}
  done
}

# ---- completions: one compinit, was five. Must run before any plugin that
# ---- calls compdef (the omz git plugin does).
fpath=($ZSH_PLUGINS/zsh-completions/src $fpath)
autoload -Uz compinit
# Full compinit (security audit + rebuild) at most once a day; -C otherwise.
if [[ -n ${HOME}/.zcompdump(#qNmh-24) ]]; then
  compinit -C
else
  compinit
  # compile the dump so the next shell loads bytecode
  [[ ! -s ~/.zcompdump.zwc || ~/.zcompdump -nt ~/.zcompdump.zwc ]] && zcompile ~/.zcompdump
fi

source $ZSH/lib/git.zsh                     # helpers used by the git plugin
source $ZSH/plugins/git/git.plugin.zsh
source $ZSH/plugins/dotenv/dotenv.plugin.zsh
source $ZSH_PLUGINS/alias-tips/alias-tips.plugin.zsh

# Dropped: tysonwolker/iterm-tab-colors - it ran an AppleScript per prompt
# (~400ms x5 at startup, 37% of total). Re-add if you miss the tab colours.

# ========================================
# THEME
# ========================================
source $HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ========================================
# LAZY TOOL LOADING
# ========================================
# Each stub replaces itself with the real thing on first call.
_lazy() {  # _lazy "<loader body>" cmd...
  local body=$1; shift
  local c all="$*"
  for c in "$@"; do
    eval "$c() { unfunction $all 2>/dev/null; $body; $c \"\$@\" }"
  done
}

# nvm (~1s to source)
_lazy '[[ -s /opt/homebrew/opt/nvm/nvm.sh ]] && source /opt/homebrew/opt/nvm/nvm.sh' nvm

# sdkman (~120ms)
export SDKMAN_DIR="$HOME/.sdkman"
_lazy '[[ -s $SDKMAN_DIR/bin/sdkman-init.sh ]] && source $SDKMAN_DIR/bin/sdkman-init.sh' sdk

# conda
_lazy 'source $HOME/anaconda3/etc/profile.d/conda.sh 2>/dev/null || path=($HOME/anaconda3/bin $path)' conda

# rbenv - `which rbenv` + `rbenv init -` both forked at startup
_lazy 'eval "$(command rbenv init - zsh)"' rbenv

# azure cli completion (~130ms, was sourced twice)
az() {
  unfunction az
  autoload -Uz bashcompinit && bashcompinit
  [[ -f /opt/homebrew/etc/bash_completion.d/az ]] && source /opt/homebrew/etc/bash_completion.d/az
  command az "$@"
}

# autojump
[[ -s /opt/homebrew/etc/autojump.sh ]] && source /opt/homebrew/etc/autojump.sh

# gh copilot aliases (~1.5s per eval, and it was evaluated twice)
_evalcache gh-copilot gh copilot alias -- zsh

# mise: NOT activated. `mise ls` is empty and there is no global config, so the
# precmd hook was costing ~136ms per prompt for nothing. Run `mise-on` in a
# shell that needs it (or restore the _evalcache line if you start using mise).
mise-on() { eval "$(command mise activate zsh)"; echo "mise activated in this shell" }

# Cheatsheet fetch: was a curl check on every shell. Run `cht-install` once.
cht-install() {
  mkdir -p ~/cht && curl -s https://cht.sh/:cht.sh > ~/cht/cht.sh && chmod +x ~/cht/cht.sh
}

# Dropped `gpgconf --launch gpg-agent` (~600ms) - gpg launches its agent on
# first use anyway. Run it by hand if a signing hang ever suggests otherwise.

# ========================================
# HISTORY
# ========================================
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# ========================================
# GENERAL ZSH OPTIONS
# ========================================
setopt AUTO_CD
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF
setopt INTERACTIVE_COMMENTS
unsetopt CORRECT_ALL
setopt NO_CORRECT

# ========================================
# ALIASES / FUNCTIONS
# ========================================
[[ -f "$HOME/.zsh_aliases" ]] && source "$HOME/.zsh_aliases"
[[ -f "$HOME/.zsh_functions" ]] && source "$HOME/.zsh_functions"

alias oracle='PATH="/usr/sbin:$PATH" oracle --engine browser'
alias clawdbot="node ~/d/git/clawdbot/dist/entry.js"
alias popashot="clawdbot tui --session agent:popashot:main"

# Tab name = current directory
autoload -Uz add-zsh-hook
function set_warp_tab_name() { print -Pn "\e]0;%1~\a" }
add-zsh-hook precmd set_warp_tab_name

# --WCGW_ENVIRONMENT_START--
if [ -n "$IN_WCGW_ENVIRONMENT" ]; then
 PROMPT_COMMAND='printf "◉ $(pwd)──➤ \r\e[2K"'
 prmptcmdwcgw() { eval "$PROMPT_COMMAND" }
 add-zsh-hook -d precmd prmptcmdwcgw
 precmd_functions+=prmptcmdwcgw
fi
# --WCGW_ENVIRONMENT_END--

# OTEL config - machine-specific endpoint, resource attrs, Grafana Cloud creds.
[[ -f "$HOME/.agents-in-a-box/otel/grafana-cloud.env" ]] && source "$HOME/.agents-in-a-box/otel/grafana-cloud.env"

[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# ========================================
# SYNTAX HIGHLIGHTING / AUTOSUGGESTIONS (must be last)
# ========================================
source $ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
