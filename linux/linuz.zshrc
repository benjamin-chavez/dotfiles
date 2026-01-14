ZSH=$HOME/.oh-my-zsh

# You can change the theme with another one from https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="robbyrussell"

# Useful oh-my-zsh plugins for Le Wagon bootcamps
plugins=(git gitfast last-working-dir common-aliases zsh-syntax-highlighting history-substring-search pyenv ssh-agent history sudo colored-man-pages)

# Disable warning about insecure completion-dependent directories
ZSH_DISABLE_COMPFIX=true

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)

# Load rbenv if installed (to manage your Ruby versions)
export PATH="${HOME}/.rbenv/bin:${PATH}" # Needed for Linux/WSL
type -a rbenv >/dev/null && eval "$(rbenv init -)"

# PYTHON:
# Poetry configuration
export PATH="$HOME/.local/bin:$PATH"

# Load pyenv (to manage your Python versions)
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# type -a pyenv > /dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)" && RPROMPT+='[🐍 $(pyenv_prompt_info)]'

fpath+=~/.zfunc
autoload -Uz compinit && compinit

# NODE JS:
# Load nvm (to manage your node versions)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Call `nvm use` automatically in a directory with a `.nvmrc` file
autoload -U add-zsh-hook
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
type -a nvm >/dev/null && add-zsh-hook chpwd load-nvmrc
type -a nvm >/dev/null && load-nvmrc

# Rails and Ruby uses the local `bin` folder to store binstubs.
# So instead of running `bin/rails` like the doc says, just run `rails`
# Same for `./node_modules/.bin` and nodejs
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export BUNDLER_EDITOR=code
# export BUNDLER_EDITOR="subl $@ >/dev/null 2>&1 -a"

export PATH="$HOME/.pgenv/bin:$HOME/.pgenv/pgsql/bin:$PATH"
export PGUSER=benchavez

# Set default code editor
export EDITOR="code --wait"

# PNPM
export PNPM_HOME="/home/benchavez/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Golang
# if [[ ":$PATH:" != *":/usr/local/go/bin:"* ]]; then
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
# fi

# NX:
export PATH="$PATH:/home/benchavez/.local/share/pnpm/global/5/.pnpm/node_modules/.bin"
# export PATH="/home/benchavez/.tfenv/bin:/home/benchavez/.pgenv/bin:/home/benchavez/.pgenv/pgsql/bin:/home/benchavez/.local/share/pnpm:./bin:./node_modules/.bin:/home/benchavez/.nvm/versions/node/v18.15.0/bin:/home/benchavez/.pyenv/plugins/pyenv-virtualenv/shims:/home/benchavez/.pyenv/shims:/home/benchavez/.pyenv/bin:/home/benchavez/.rbenv/shims:/home/benchavez/.rbenv/bin:/home/benchavez/.pyenv/plugins/pyenv-virtualenv/shims:/home/benchavez/.pyenv/bin:/home/benchavez/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/sbin:/usr/local/go/bin:/home/benchavez/.local/share/pnpm/global/5/.pnpm/node_modules/.bin"

export PATH="$HOME/.tfenv/bin:$PATH"

# AWS CLI Autocomplete
export PATH=/usr/local/bin/aws_completer/:$PATH
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws


# pnpm
export PNPM_HOME="/home/benchavez/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

PATH=~/.console-ninja/.bin:$PATH
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

NGROK_AUTHTOKEN='2Xdkkqa63uti4KdJsfIOC7ZYs9D_4NMrEpLGRHudfQbdPHqUr'
export AWS_PAGER=""

alias claude="/home/benchavez/.claude/local/claude"
