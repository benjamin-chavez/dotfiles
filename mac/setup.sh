#!/usr/bin/env bash

# ~/.dotfiles/mac/setup.sh

echo "Setting up dotfiles on macOS..."

source "$(dirname "$0")/../lib/utils.sh"

# ====================
# Xcode CLT
# ====================
if ! xcode-select -p &>/dev/null; then
  echo "📦 Installing Xcode Command Line Tools..."
  xcode-select --install
  until xcode-select -p &>/dev/null; do
    sleep 5
  done
fi

# ====================
# Homebrew
# ====================
if ! command -v brew &>/dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make brew available in this session (needed on Apple Silicon)
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "🍺 Installing Homebrew packages..."
brew bundle --file=~/.dotfiles/mac/Brewfile

# ====================
# Symlinks
# ====================
mkdir -p ~/.config
mkdir -p ~/.hammerspoon

ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/.aliases ~/.aliases
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/mac/hammerspoon/init.lua ~/.hammerspoon/init.lua

# Directory symlinks
link_dir ~/.dotfiles/config/nvim ~/.config/nvim
link_dir ~/.dotfiles/config/ghostty ~/.config/ghostty
link_dir ~/.dotfiles/mac/karabiner ~/.config/karabiner

# ====================
# pgenv (PostgreSQL version manager)
# ====================
if [ ! -d ~/.pgenv ]; then
  echo "📦 Installing pgenv..."
  git clone https://github.com/theory/pgenv.git ~/.pgenv
  echo "✓ pgenv installed"
else
  echo "✓ pgenv already installed"
fi

# ====================
# macOS Defaults
# ====================
if [ -f ~/.dotfiles/mac/.macos ]; then
  echo "⚙️ Applying macOS defaults..."
  chmod +x ~/.dotfiles/mac/.macos
  ~/.dotfiles/mac/.macos
fi

# # Create symlink for Node.js to ensure it's available system-wide
# # NOTE: Commented out — using fnm instead of nvm now
# if [ -d "$HOME/.nvm/versions/node" ]; then
#   # Get the current NVM version (or default to a specific version if needed)
#   NODE_VERSION=$(ls -t $HOME/.nvm/versions/node | head -n 1)
#   NODE_PATH="$HOME/.nvm/versions/node/$NODE_VERSION/bin/node"
#
#   # Check if the symlink already exists
#   if [ ! -e "/usr/local/bin/node" ] || [ -L "/usr/local/bin/node" ]; then
#     echo "Creating symlink for Node.js ($NODE_VERSION) to /usr/local/bin/node"
#
#     # Single sudo block to avoid multiple password prompts
#     sudo bash -c "
#       # Create directory if it doesn't exist
#       mkdir -p /usr/local/bin
#       # Remove existing symlinks if they exist
#       rm -f /usr/local/bin/node /usr/local/bin/npm /usr/local/bin/npx
#       # Create new symlinks for node, npm, and npx
#       ln -sf '$NODE_PATH' /usr/local/bin/node
#       ln -sf '$HOME/.nvm/versions/node/$NODE_VERSION/bin/npm' /usr/local/bin/npm
#       ln -sf '$HOME/.nvm/versions/node/$NODE_VERSION/bin/npx' /usr/local/bin/npx
#     "
#   fi
# else
#   echo "NVM installation not found. Skipping Node.js symlink."
# fi

# ====================
# Work Setup
# ====================
run_work_setup() {
  echo "💼 Running work setup..."
  # source "$(dirname "$0")/setup-work.sh"
  ln -sf ~/.dotfiles/scripts/aws-sso-login-script.sh ~/aws-sso-login-script.sh
  ln -sf ~/.dotfiles/scripts/open_veracity_team_zoom.sh ~/open_veracity_team_zoom.sh
}

if [[ "$1" == "--work" ]]; then
  run_work_setup
else
  read -p "Is this a work machine? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    run_work_setup
  fi
fi


echo "Dotfiles have been symlinked to home directory."
# echo "macOS settings applied. Some changes may require a logout/restart to take effect."
echo $'\uf179 macOS setup complete. Some changes may require a logout/restart.'