#!/usr/bin/env bash

# ~/.dotfiles/linux/setup.sh

echo "Setting up dotfiles on Linux..."

source "$(dirname "$0")/../lib/utils.sh"

# ====================
# Symlinks
# ====================
mkdir -p ~/.config

ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/.aliases ~/.aliases
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig

# Directory symlinks
link_dir ~/.dotfiles/config/nvim ~/.config/nvim
# link_dir ~/.dotfiles/config/ghostty ~/.config/ghostty

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
# Linux-specific setup
# ====================
# Add apt packages, etc. as needed
# Example:
# sudo apt update
# sudo apt install -y zsh ripgrep fd-find fzf


echo "Dotfiles have been symlinked to home directory."
echo "🐧 Linux setup complete."