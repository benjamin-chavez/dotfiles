#!/bin/bash
# Set up custom keybindings for GNOME

for cmd in maim xclip; do
  if ! command -v $cmd &> /dev/null; then
    echo "Missing $cmd. Install with: sudo apt install maim xclip"
    exit 1
  fi
done

keys="org.gnome.settings-daemon.plugins.media-keys"
path="$keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"

gsettings set $keys custom-keybindings \
  "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"

gsettings set $path name "Area Screenshot"
gsettings set $path command "$HOME/.local/bin/screenshot-area.sh"
gsettings set $path binding "<Control><Shift>4"

echo "✓ GNOME keybindings configured"
