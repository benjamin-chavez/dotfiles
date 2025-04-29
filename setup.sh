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

echo "Dotfiles have been symlinked to home directory."
