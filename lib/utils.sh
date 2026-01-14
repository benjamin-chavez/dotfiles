#!/usr/bin/env bash

# ~/.dotfiles/lib/utils.sh
# Shared utility functions for setup scripts

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