
# ZSH=$HOME/.oh-my-zsh

# # You can change the theme with another one from https://github.com/robbyrussell/oh-my-zsh/wiki/themes
# ZSH_THEME="robbyrussell"

# # Useful oh-my-zsh plugins for Le Wagon bootcamps
# plugins=(git gitfast last-working-dir common-aliases zsh-syntax-highlighting history-substring-search pyenv)

# # (macOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/docs/Analytics.md
# export HOMEBREW_NO_ANALYTICS=1

# # Disable warning about insecure completion-dependent directories
# ZSH_DISABLE_COMPFIX=true

# # Actually load Oh-My-Zsh
# source "${ZSH}/oh-my-zsh.sh"
# unalias rm # No interactive rm by default (brought by plugins/common-aliases)

# # Load rbenv if installed (to manage your Ruby versions)
# export PATH="${HOME}/.rbenv/bin:${PATH}" # Needed for Linux/WSL
# type -a rbenv >/dev/null && eval "$(rbenv init -)"

# # Load pyenv (to manage your Python versions)
# export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# type -a pyenv >/dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)" && RPROMPT+='[🐍 $(pyenv_prompt_info)]'

# # Load nvm (to manage your node versions)
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# # Call `nvm use` automatically in a directory with a `.nvmrc` file
# autoload -U add-zsh-hook
# load-nvmrc() {
#   if nvm -v &>/dev/null; then
#     local node_version="$(nvm version)"
#     local nvmrc_path="$(nvm_find_nvmrc)"
#     if [ -n "$nvmrc_path" ]; then
#       local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
#       if [ "$nvmrc_node_version" = "N/A" ]; then
#         nvm install
#       elif [ "$nvmrc_node_version" != "$node_version" ]; then
#         nvm use --silent
#       fi
#     elif [ "$node_version" != "$(nvm version default)" ]; then
#       nvm use default --silent
#     fi
#   fi
# }
# type -a nvm >/dev/null && add-zsh-hook chpwd load-nvmrc
# type -a nvm >/dev/null && load-nvmrc

# # Rails and Ruby uses the local `bin` folder to store binstubs.
# # So instead of running `bin/rails` like the doc says, just run `rails`
# # Same for `./node_modules/.bin` and nodejs
# export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"

# # Store your own aliases in the ~/.aliases file and load the here.
# [[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# # Encoding stuff for the terminal
# export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8
# export BUNDLER_EDITOR=code

# # export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1 -a"

# # pnpm
# export PNPM_HOME="/Users/benc/Library/pnpm"
# case ":$PATH:" in
# *":$PNPM_HOME:"*) ;;
# *) export PATH="$PNPM_HOME:$PATH" ;;
# esac
# # pnpm end

# export PATH="$HOME/.local/bin:$PATH"
# export PATH="$HOME/.poetry/bin:$PATH"

# ---------------------------------------------------------------------------------------------------------------------------------- V2
# # Python and Poetry environment setup
# # ====================
# # Environment Setup
# # ====================
# # Basic environment variables that need to be available early
# export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8
# export HOMEBREW_NO_ANALYTICS=1 # Prevent Homebrew analytics reporting

# # ====================
# # Path Management
# # ====================
# # Define path_prepend function first so we can use it for all path modifications
# path_prepend() {
#   if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
#     PATH="$1:$PATH"
#   fi
# }

# # Core paths that should be available early
# path_prepend "/usr/local/bin"
# path_prepend "/usr/local/sbin"
# path_prepend "$HOME/.local/bin"

# # ====================
# # Oh-My-Zsh Configuration
# # ====================
# ZSH=$HOME/.oh-my-zsh
# ZSH_THEME="robbyrussell"
# ZSH_DISABLE_COMPFIX=true # Disable warning about insecure completion-dependent directories

# plugins=(git gitfast last-working-dir common-aliases zsh-syntax-highlighting history-substring-search pyenv history)

# source "${ZSH}/oh-my-zsh.sh"
# unalias rm # Prevent interactive rm prompt

# # ====================
# # Development Tools
# # ====================

# # Python and Poetry Configuration
# export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# if type pyenv >/dev/null; then
#   eval "$(pyenv init -)"
#   eval "$(pyenv virtualenv-init -)"
#   RPROMPT+='[🐍 $(pyenv_prompt_info)]'
# fi

# export POETRY_HOME="$HOME/.poetry"
# path_prepend "$POETRY_HOME/bin"

# # Ruby Configuration
# # if type rbenv >/dev/null; then
# #   path_prepend "$HOME/.rbenv/bin"
# #   eval "$(rbenv init -)"
# # fi

# # Node.js Configuration
# export NVM_DIR="$HOME/.nvm"
# if [ -s "$NVM_DIR/nvm.sh" ]; then
#   source "$NVM_DIR/nvm.sh"
#   source "$NVM_DIR/bash_completion"

#   # Automatic nvm use for projects with .nvmrc
#   autoload -U add-zsh-hook
#   load-nvmrc() {
#     if nvm -v &>/dev/null; then
#       local node_version="$(nvm version)"
#       local nvmrc_path="$(nvm_find_nvmrc)"

#       if [ -n "$nvmrc_path" ]; then
#         local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
#         if [ "$nvmrc_node_version" = "N/A" ]; then
#           nvm install
#         elif [ "$nvmrc_node_version" != "$node_version" ]; then
#           nvm use --silent
#         fi
#       elif [ "$node_version" != "$(nvm version default)" ]; then
#         nvm use default --silent
#       fi
#     fi
#   }
#   add-zsh-hook chpwd load-nvmrc
#   load-nvmrc
# fi

# # PNPM Configuration
# export PNPM_HOME="$HOME/Library/pnpm"
# path_prepend "$PNPM_HOME"

# # ====================
# # Project Paths
# # ====================
# # These are added last since they're the most specific to your workflow
# path_prepend "./bin"
# path_prepend "./node_modules/.bin"

# # ====================
# # Editor Configuration
# # ====================
# export BUNDLER_EDITOR=code

# # ====================
# # Personal Configuration
# # ====================
# # Load personal aliases last so they can override anything above
# [[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# # Finally, export the complete PATH
# export PATH
# export DOTNET_ROOT=/usr/local/share/dotnet
# path_prepend "$HOME/.pgenv/bin"
# path_prepend "$HOME/.pgenv/pgsql/bin"

# ---------------------------------------------------------------------------------------------------------------------------------- V3
# ZSH=$HOME/.oh-my-zsh

# # You can change the theme with another one from https://github.com/robbyrussell/oh-my-zsh/wiki/themes
# ZSH_THEME="robbyrussell"

# # Useful oh-my-zsh plugins for Le Wagon bootcamps
# plugins=(git gitfast last-working-dir common-aliases zsh-syntax-highlighting history-substring-search pyenv)

# # (macOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/docs/Analytics.md
# export HOMEBREW_NO_ANALYTICS=1

# # Disable warning about insecure completion-dependent directories
# ZSH_DISABLE_COMPFIX=true

# # Actually load Oh-My-Zsh
# source "${ZSH}/oh-my-zsh.sh"
# unalias rm # No interactive rm by default (brought by plugins/common-aliases)

# # Load rbenv if installed (to manage your Ruby versions)
# export PATH="${HOME}/.rbenv/bin:${PATH}" # Needed for Linux/WSL
# type -a rbenv >/dev/null && eval "$(rbenv init -)"

# # Load pyenv (to manage your Python versions)
# export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# type -a pyenv >/dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)" && RPROMPT+='[:snake: $(pyenv_prompt_info)]'

# # Load nvm (to manage your node versions)
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# # Call `nvm use` automatically in a directory with a `.nvmrc` file
# autoload -U add-zsh-hook
# load-nvmrc() {
#   if nvm -v &>/dev/null; then
#     local node_version="$(nvm version)"
#     local nvmrc_path="$(nvm_find_nvmrc)"

#     if [ -n "$nvmrc_path" ]; then
#       local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

#       if [ "$nvmrc_node_version" = "N/A" ]; then
#         nvm install
#       elif [ "$nvmrc_node_version" != "$node_version" ]; then
#         nvm use --silent
#       fi
#     elif [ "$node_version" != "$(nvm version default)" ]; then
#       nvm use default --silent
#     fi
#   fi
# }
# type -a nvm >/dev/null && add-zsh-hook chpwd load-nvmrc
# type -a nvm >/dev/null && load-nvmrc

# # Rails and Ruby uses the local `bin` folder to store binstubs.
# # So instead of running `bin/rails` like the doc says, just run `rails`
# # Same for `./node_modules/.bin` and nodejs
# export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"

# # Store your own aliases in the ~/.aliases file and load the here.
# [[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# # Encoding stuff for the terminal
# export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8

# export BUNDLER_EDITOR=code
# # export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1 -a"
# export PATH="$HOME/.pgenv/bin:$HOME/.pgenv/pgsql/bin:$PATH"
# export PGUSER=postgres
# export PGDATABASE=postgres

# # pnpm
# export PNPM_HOME="/Users/benjaminm.chavez/Library/pnpm"
# case ":$PATH:" in
# *":$PNPM_HOME:"*) ;;
# *) export PATH="$PNPM_HOME:$PATH" ;;
# esac
# # pnpm end
# eval "$(/opt/homebrew/bin/brew shellenv)"

# ---------------------------------------------------------------------------------------------------------------------------------- V2
# # ====================
# # Oh-My-Zsh Configuration
# # ====================
# ZSH=$HOME/.oh-my-zsh

# ZSH_THEME="robbyrussell"

# # Useful oh-my-zsh plugins for Le Wagon bootcamps
# plugins=(git gitfast last-working-dir common-aliases zsh-syntax-highlighting history-substring-search pyenv)

# # (macOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/docs/Analytics.md
# export HOMEBREW_NO_ANALYTICS=1

# # Disable warning about insecure completion-dependent directories
# ZSH_DISABLE_COMPFIX=true

# # Actually load Oh-My-Zsh
# source "${ZSH}/oh-my-zsh.sh"
# unalias rm # No interactive rm by default (brought by plugins/common-aliases)

# # Python and Poetry environment setup
# # ====================
# # Environment Setup
# # ====================
# # Basic environment variables that need to be available early
# # export LANG=en_US.UTF-8
# # export LC_ALL=en_US.UTF-8
# # export HOMEBREW_NO_ANALYTICS=1 # Prevent Homebrew analytics reporting

# # ====================
# # Path Management
# # ====================
# # Define path_prepend function first so we can use it for all path modifications
# # path_prepend() {
# #   if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
# #     PATH="$1:$PATH"
# #   fi
# # }

# # Core paths that should be available early
# # path_prepend "/usr/local/bin"
# # path_prepend "/usr/local/sbin"
# # path_prepend "$HOME/.local/bin"

# # source "${ZSH}/oh-my-zsh.sh"
# # unalias rm # Prevent interactive rm prompt

# # ====================
# # Development Tools
# # ====================

# # Python and Poetry Configuration
# export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# type -a pyenv >/dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)" && RPROMPT+='[:snake: $(pyenv_prompt_info)]'

# # export POETRY_HOME="$HOME/.poetry"
# # path_prepend "$POETRY_HOME/bin"
# export PATH="$HOME/.poetry/bin:$PATH"

# # Load nvm (to manage your node versions)
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# # Call `nvm use` automatically in a directory with a `.nvmrc` file
# autoload -U add-zsh-hook
# load-nvmrc() {
#   if nvm -v &>/dev/null; then
#     local node_version="$(nvm version)"
#     local nvmrc_path="$(nvm_find_nvmrc)"

#     if [ -n "$nvmrc_path" ]; then
#       local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

#       if [ "$nvmrc_node_version" = "N/A" ]; then
#         nvm install
#       elif [ "$nvmrc_node_version" != "$node_version" ]; then
#         nvm use --silent
#       fi
#     elif [ "$node_version" != "$(nvm version default)" ]; then
#       nvm use default --silent
#     fi
#   fi
# }
# type -a nvm >/dev/null && add-zsh-hook chpwd load-nvmrc
# type -a nvm >/dev/null && load-nvmrc

# # ====================
# # Project Paths
# # ====================
# # These are added last since they're the most specific to your workflow
# # path_prepend "./bin"
# # path_prepend "./node_modules/.bin"

# # Store your own aliases in the ~/.aliases file and load the here.
# [[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# # Encoding stuff for the terminal
# export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8

# # ====================
# # Editor Configuration
# # ====================
# export BUNDLER_EDITOR=code
# # export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1 -a"
# export PATH="$HOME/.pgenv/bin:$HOME/.pgenv/pgsql/bin:$PATH"
# export PGUSER=postgres
# export PGDATABASE=postgres

# # ====================
# # Personal Configuration
# # ====================
# # Load personal aliases last so they can override anything above
# [[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# # PNPM Configuration
# export PNPM_HOME="$HOME/Library/pnpm"
# # path_prepend "$PNPM_HOME"
# # export PNPM_HOME="/Users/benjaminm.chavez/Library/pnpm"
# case ":$PATH:" in
# *":$PNPM_HOME:"*) ;;
# *) export PATH="$PNPM_HOME:$PATH" ;;
# esac
# # pnpm end
# eval "$(/opt/homebrew/bin/brew shellenv)"

# # # Finally, export the complete PATH
# # export PATH
# # export DOTNET_ROOT=/usr/local/share/dotnet
# # # path_prepend "$HOME/.pgenv/bin"
# # # path_prepend "$HOME/.pgenv/pgsql/bin"


# ---------------------------------------------------------------------------------------------------------------------------------- V4
# ~/.dotfiles/mac/.zshrc

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
# PROMPT=$'\uf8ff %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)' # Original
PROMPT=$'\uf179 %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'   # Apple logo + directory + git
RPROMPT=''
unalias rm 2>/dev/null  # Disable interactive rm from common-aliases plugin

# ====================
# Environment
# ====================
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export HOMEBREW_NO_ANALYTICS=1

# ====================
# Homebrew
# ====================
eval "$(/opt/homebrew/bin/brew shellenv)"

# ====================
# Path
# ====================
export PATH="$HOME/bin:$HOME/bin/bash_scripts:$PATH" # Personal bin directory
export PATH="$HOME/.local/bin:$PATH"

# ====================
# Node.js / JavaScript
# ====================
eval "$(fnm env --use-on-cd)"  # fnm (node version manager)

export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

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
export PATH="/opt/homebrew/opt/go/bin:$PATH"

# ====================
# Ruby (uncomment if needed)
# ====================
# export BUNDLER_EDITOR=code  # Opens bundle open <gem> in VS Code
# eval "$(rbenv init -)"      # Ruby version manager

# ====================
# PostgreSQL (pgenv)
# ====================
export PATH="$HOME/.pgenv/bin:$HOME/.pgenv/pgsql/bin:$PATH"
export PGUSER=postgres
export PGDATABASE=postgres

# ====================
# CLI Tools
# ====================
eval "$(thefuck --alias)"
eval "$(thefuck --alias fk)"
eval "$(zoxide init zsh)"       # Zoxide (better cd)
alias cd="z"

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
[[ -f "$HOME/.zshrc.work" ]] && source "$HOME/.zshrc.work"

unalias gk gke 2>/dev/null  # Remove gitk GUI aliases from git plugin (unused)

# ====================
# Performance Timing
# ====================
end_time=$EPOCHREALTIME
printf "Shell initialized in %.1f ms\n" $((($end_time - $start_time) * 1000))
