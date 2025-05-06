#!/usr/bin/env bash

# .dotfiles/setup.sh

OS="$(uname -s)"

echo "Setting up dotfiles on $OS system..."

# Create symbolic links
# MAC Specific Symlinks
mkdir -p ~/.hammerspoon
ln -sf ~/.dotfiles/mac/hammerspoon/init.lua ~/.hammerspoon/init.lua
ln -sf ~/.dotfiles/mac/.zshrc ~/.zshrc

ln -sf ~/.dotfiles/.aliases ~/.aliases
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/scripts/aws-sso-login-script.sh ~/aws-sso-login-script.sh
ln -sf ~/.dotfiles/scripts/open_veracity_team_zoom.sh ~/open_veracity_team_zoom.sh

ln -sf ~/.dotfiles/config/nvim/init.vim ~/.config/nvim/init.vim

# Create symlink for Node.js to ensure it's available system-wide
if [ -d "$HOME/.nvm/versions/node" ]; then
  # Get the current NVM version (or default to a specific version if needed)
  NODE_VERSION=$(ls -t $HOME/.nvm/versions/node | head -n 1)
  NODE_PATH="$HOME/.nvm/versions/node/$NODE_VERSION/bin/node"

  # Check if the symlink already exists
  if [ ! -e "/usr/local/bin/node" ] || [ -L "/usr/local/bin/node" ]; then
    echo "Creating symlink for Node.js ($NODE_VERSION) to /usr/local/bin/node"
    # Create directory if it doesn't exist
    sudo mkdir -p /usr/local/bin
    # Remove existing symlink if it exists
    sudo rm -f /usr/local/bin/node
    # Create new symlink
    sudo ln -sf "$NODE_PATH" /usr/local/bin/node

    # Also create symlinks for npm and npx
    sudo ln -sf "$HOME/.nvm/versions/node/$NODE_VERSION/bin/npm" /usr/local/bin/npm
    sudo ln -sf "$HOME/.nvm/versions/node/$NODE_VERSION/bin/npx" /usr/local/bin/npx
  fi
else
  echo "NVM installation not found. Skipping Node.js symlink."
fi

echo "Dotfiles have been symlinked to home directory."
