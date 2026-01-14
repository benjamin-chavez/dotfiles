#!/bin/bash
mkdir -p ~/.local/bin
ln -sf "$HOME/.dotfiles/linux/screenshot-area.sh" ~/.local/bin/screenshot-area.sh
./linux/gnome-keybindings.sh
