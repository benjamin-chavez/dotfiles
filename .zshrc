# ~/.dotfiles/.zshrc

# ====================
# Performance Timing
# ====================
zmodload zsh/datetime
start_time=$EPOCHREALTIME

# ====================
# Oh-My-Zsh Configuration
# ====================
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
ZSH_DISABLE_COMPFIX=true # Disable warning about insecure completion-dependent directories

plugins=(git gitfast last-working-dir common-aliases history-substring-search history)

source "${ZSH}/oh-my-zsh.sh"
RPROMPT=''
unalias rm 2>/dev/null  # Disable interactive rm from common-aliases plugin

# ====================
# Environment
# ====================
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export HOMEBREW_NO_ANALYTICS=1

# ====================
# Path
# ====================
export PATH="$HOME/bin:$HOME/bin/bash_scripts:$PATH" # Personal bin directory
export PATH="$HOME/.local/bin:$PATH"

# ====================
# Node.js / JavaScript
# ====================
eval "$(fnm env --use-on-cd)"  # fnm (node version manager)

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
# Golang
# ====================
export PATH="$HOME/go/bin:$PATH"  # Go-installed binaries (go install)

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
# CLI Tools
# ====================
eval "$(thefuck --alias)" && alias fk="fuck"
eval "$(zoxide init zsh)" && alias cd="z"  # Zoxide (better cd)

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
[[ -f "$HOME/.secrets" ]] && source "$HOME/.secrets"

unalias gk gke 2>/dev/null  # Remove gitk GUI aliases from git plugin (unused)

# ====================
# macOS
# ====================
_macos() {
  # Homebrew
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # Oh-My-Zsh Configuration
  # PROMPT=$'\uf8ff %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'  # Original (Apple logo)
  PROMPT=$'\uf179 %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'    # Apple logo + directory + git

  # Node.js / JavaScript
  export PNPM_HOME="$HOME/Library/pnpm"
  export PATH="$PNPM_HOME:$PATH"

  # Golang
  export PATH="/opt/homebrew/opt/go/bin:$PATH"  # Go compiler (Homebrew)

  # Additional Configs
  [[ -f "$HOME/.zshrc.work" ]] && source "$HOME/.zshrc.work"
}

# ====================
# Linux
# ====================
_linux() {
  # Oh-My-Zsh Configuration
  PROMPT=$'\uf8ff %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)' # Original

  # Node.js / JavaScript
  export PNPM_HOME="$HOME/.local/share/pnpm"
  export PATH="$PNPM_HOME:$PATH"
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
