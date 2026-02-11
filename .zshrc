# ~/.dotfiles/.zshrc

# ====================
# Performance Timing
# ====================
zmodload zsh/datetime
start_time=$EPOCHREALTIME

# ====================
# Homebrew (Mac only - must be early - other tools depend on it)
# ====================
[[ "$OSTYPE" == darwin* ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# ====================
# Oh-My-Zsh Configuration
# ====================
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
ZSH_DISABLE_COMPFIX=true # Disable warning about insecure completion-dependent directories


# plugins=(git gitfast last-working-dir common-aliases history-substring-search history)
plugins=(git gitfast last-working-dir history-substring-search history)

source "${ZSH}/oh-my-zsh.sh"
RPROMPT=''
unalias rm 2>/dev/null  # Disable interactive rm from common-aliases plugin

# ====================
# Zsh Completions
# ====================
fpath+=~/.zfunc                   # Add custom completions directory to function path
autoload -Uz compinit && compinit # Load and initialize the completion system

# ====================
# Environment
# ====================
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export HOMEBREW_NO_ANALYTICS=1
export EDITOR="nvim"

# ====================
# Path
# ====================
export PATH="$HOME/bin:$HOME/bin/bash_scripts:$PATH" # Personal bin directory
export PATH="$HOME/.local/bin:$PATH"
# export PATH="./bin:./node_modules/.bin:$PATH"  # Local binstubs (rails, node_modules)

# ====================
# Node.js / JavaScript
# ====================
# eval "$(fnm env --use-on-cd)"  # fnm (node version manager)

# ====================
# Python 🐍 - Deferred Loading
# ====================
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# Loads pyenv on first use of pyenv/python/pip commands.
# Deferred loading speeds up shell startup time.
load_pyenv() {
  unalias pyenv python pip 2>/dev/null
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  # RPROMPT+='[:snake: $(pyenv_prompt_info)]'
  RPROMPT+='[🐍 $(pyenv_prompt_info)]'
}

alias pyenv="load_pyenv && pyenv"
alias python="load_pyenv && python"
alias pip="load_pyenv && pip"

# UV (fast Python package manager)
. "$HOME/.local/bin/env"
eval "$(uv generate-shell-completion zsh)"

# ====================
# Node.js - nvm auto-switch function
# ====================
# Auto-switch node version when entering directory with .nvmrc
# Only active when nvm is loaded (Linux)
load-nvmrc() {
  if nvm -v &>/dev/null; then
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
      if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
      elif [ "$nvmrc_node_version" != "$node_version" ]; then
        nvm use --silent
      fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
      nvm use default --silent
    fi
  fi
}

# ====================
# Golang
# ====================
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$PATH"

# ====================
# Ruby (uncomment if needed)
# ====================
# export BUNDLER_EDITOR=code  # Opens bundle open <gem> in VS Code
# eval "$(rbenv init -)"      # Ruby version manager
# export PATH="./bin:./node_modules/.bin:$PATH"  # Run local binstubs directly (rails instead of bin/rails)

# ====================
# PostgreSQL (pgenv)
# ====================
export PATH="$HOME/.pgenv/bin:$HOME/.pgenv/pgsql/bin:$PATH"
export PGUSER=postgres
export PGDATABASE=postgres

# ====================
# AWS
# ====================
export AWS_PAGER=""  # Disable paging for AWS CLI output (no more `less` for long results)

# ====================
# CLI Tools
# ====================
# eval "$(thefuck --alias)" && alias fk="fuck"
eval "$(zoxide init zsh)" && alias cd="z"  # Zoxide (better cd)
eval "$(direnv hook zsh)"
# PATH="$HOME/.console-ninja/.bin:$PATH"

# ====================
# Syntax Highlighting (loaded async for speed)
# ====================
# Optional: Load syntax highlighting only after everything else is done
# This will make your prompt ready faster, then load highlighting
{ source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh &! } 2>/dev/null

# ====================
# Additional Configs - Load personal aliases last
# ====================
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"
ln -s ~/.dotfiles/.secrets ~/.secrets

unalias gk gke 2>/dev/null  # Remove gitk GUI aliases from git plugin (unused)

# ====================
# macOS
# ====================
_macos() {
  # Oh-My-Zsh Configuration
  # PROMPT=$'\uf8ff %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'  # Original (Apple logo)
  # PROMPT=$'\uf179 %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'    # Apple logo + directory + git

  # Node.js (fnm)
  eval "$(fnm env --use-on-cd)"

  # Node.js / JavaScript
  export PNPM_HOME="$HOME/Library/pnpm"
  export PATH="$PNPM_HOME:$PATH"

  # Golang (Homebrew)
  # export PATH="/opt/homebrew/opt/go/bin:$PATH"  # Go compiler (Homebrew)

  # Additional Configs
  [[ -f "$HOME/.zshrc.work" ]] && source "$HOME/.zshrc.work"
}

# ====================
# Linux
# ====================
_linux() {
  # Oh-My-Zsh Configuration
  # PROMPT=$'\uf8ff %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

  # Ruby (rbenv)
  export PATH="${HOME}/.rbenv/bin:${PATH}"
  type -a rbenv >/dev/null && eval "$(rbenv init -)"
  export BUNDLER_EDITOR=code

  # Golang
  export GOROOT=/usr/local/go
  export PATH="$GOROOT/bin:$PATH"

  # Python - pyenv path (Linux-specific location)
  export PATH="$HOME/.pyenv/bin:$PATH"

  # Node.js (nvm)
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

  autoload -U add-zsh-hook
  type -a nvm >/dev/null && add-zsh-hook chpwd load-nvmrc
  type -a nvm >/dev/null && load-nvmrc

  export PNPM_HOME="$HOME/.local/share/pnpm"
  export PATH="$PNPM_HOME:$PATH"

  # Terraform (tfenv)
  export PATH="$HOME/.tfenv/bin:$PATH"

  # AWS CLI completion
  autoload bashcompinit && bashcompinit
  complete -C '/usr/local/bin/aws_completer' aws

  # Claude CLI
  alias claude="$HOME/.claude/local/claude"
}

# ====================
# OS-Specific Setup
# ====================
case "$OSTYPE" in
  darwin*)  _macos ;;
  linux*)   _linux ;;
esac

# ====================
# Performance Timing
# ====================
end_time=$EPOCHREALTIME
printf "Shell initialized in %.1f ms\n" $((($end_time - $start_time) * 1000))
