
#!/usr/bin/env bash

# .dotfiles/setup.sh

OS="$(uname -s)"

echo "Setting up dotfiles on $OS system..."

link_dir() {
  local src="$1"
  local dest="$2"

  # Already correctly linked — skip
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "✓ $dest already linked"
    return
  fi

  # Exists as a real directory — backup
  if [ -d "$dest" ] && [ ! -L "$dest" ]; then
    mv "$dest" "$dest.backup.$(date +%Y%m%d%H%M%S)"
    echo "⚠ Backed up existing $dest"
  fi

  # Remove stale symlink if exists
  [ -L "$dest" ] && rm "$dest"

  ln -sf "$src" "$dest"
  echo "✓ Linked $dest → $src"
}


# Create symbolic links
# MAC Specific Symlinks
mkdir -p ~/.hammerspoon
# mkdir -p ~/.config/nvim
# mkdir -p ~/.config/ghostty

# ln -sf ~/.dotfiles/mac/hammerspoon/init.lua ~/.hammerspoon/init.lua
# ln -sf ~/.dotfiles/mac/.zshrc ~/.zshrc

ln -sf ~/.dotfiles/.aliases ~/.aliases
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/scripts/aws-sso-login-script.sh ~/aws-sso-login-script.sh
ln -sf ~/.dotfiles/scripts/open_veracity_team_zoom.sh ~/open_veracity_team_zoom.sh
# ln -sf ~/.dotfiles/config/ghostty/config ~/.config/ghostty/config

# ln -sf ~/.dotfiles/config/nvim ~/.config/nvim

# Directory symlinks
link_dir ~/.dotfiles/config/nvim ~/.config/nvim
link_dir ~/.dotfiles/config/ghostty ~/.config/ghostty

if [ "$OS" = "Darwin" ]; then
  echo "Applying macOS specific settings..."

  echo "🍺 Installing Homebrew packages..."
  brew bundle --file=~/.dotfiles/mac/Brewfile

  ln -sf ~/.dotfiles/mac/hammerspoon/init.lua ~/.hammerspoon/init.lua
  ln -sf ~/.dotfiles/mac/.zshrc ~/.zshrc

  link_dir ~/.dotfiles/mac/karabiner ~/.config/karabiner

  chmod +x ~/.dotfiles/mac/.macos
  ~/.dotfiles/mac/.macos

  echo "macOS settings applied. Some changes may require a logout/restart to take effect."
fi



# Create symlink for Node.js to ensure it's available system-wide
if [ -d "$HOME/.nvm/versions/node" ]; then
  # Get the current NVM version (or default to a specific version if needed)
  NODE_VERSION=$(ls -t $HOME/.nvm/versions/node | head -n 1)
  NODE_PATH="$HOME/.nvm/versions/node/$NODE_VERSION/bin/node"

  # Check if the symlink already exists
  if [ ! -e "/usr/local/bin/node" ] || [ -L "/usr/local/bin/node" ]; then
    echo "Creating symlink for Node.js ($NODE_VERSION) to /usr/local/bin/node"

    # Single sudo block to avoid multiple password prompts
    sudo bash -c "
      # Create directory if it doesn't exist
      mkdir -p /usr/local/bin
      # Remove existing symlinks if they exist
      rm -f /usr/local/bin/node /usr/local/bin/npm /usr/local/bin/npx
      # Create new symlinks for node, npm, and npx
      ln -sf '$NODE_PATH' /usr/local/bin/node
      ln -sf '$HOME/.nvm/versions/node/$NODE_VERSION/bin/npm' /usr/local/bin/npm
      ln -sf '$HOME/.nvm/versions/node/$NODE_VERSION/bin/npx' /usr/local/bin/npx
    "
  fi
else
  echo "NVM installation not found. Skipping Node.js symlink."
fi


echo "Dotfiles have been symlinked to home directory."


