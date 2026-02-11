#!/usr/bin/env bash

# ~/.dotfiles/linux/setup.sh

echo "Setting up dotfiles on Linux..."

source "$(dirname "$0")/../lib/utils.sh"

# ====================
# APT Packages
# ====================
echo "📦 Installing apt packages..."
sudo apt update
packages=(
  # Shell
  zsh                 # Z shell

  # Version Control
  git                 # Version control system
  # gh                  # GitHub CLI — UPGRADE: uncomment on Ubuntu 22.04+

  # Editors
  neovim              # Vim fork, modernized text editor

  # CLI Tools
  bat                 # Syntax highlighting (better cat)
  curl                # URL transfer tool
  duf                 # Disk usage stats (better df)
  fd-find             # Fast file finder (better find)
  fzf                 # Fuzzy finder
  htop                # Interactive process viewer (better top)
  jq                  # JSON processor
  maim                # Screenshot utility (X11)
  ncdu                # Disk usage analyzer
  ripgrep             # Fast text search (better grep)
  tmux                # Terminal multiplexer
  tree                # Directory listing as a file-tree
  wget                # File downloader
  xclip               # Clipboard utility
  direnv              # Per-directory environment variables
  # thefuck installed via pip
  # zoxide              # Smarter cd — UPGRADE: uncomment on Ubuntu 24.04+

  # Build Dependencies (for pyenv, rbenv, etc.)
  build-essential     # GCC, make, etc.
  pkg-config          # Compiler helper for building software
  libssl-dev          # OpenSSL development files
  zlib1g-dev          # Compression library
  libbz2-dev          # BZ2 compression library
  libreadline-dev     # Readline library
  libsqlite3-dev      # SQLite development files
  libffi-dev          # Foreign function interface library
  liblzma-dev         # LZMA compression library
)

failed_packages=()
for pkg in "${packages[@]}"; do
  if ! sudo apt install -y "$pkg" &>/dev/null; then
    failed_packages+=("$pkg")
    echo "  ✗ $pkg failed"
  else
    echo "  ✓ $pkg"
  fi
done

if [ ${#failed_packages[@]} -gt 0 ]; then
  echo ""
  echo "⚠️⚠️⚠️  FAILED PACKAGES: ${failed_packages[*]}"
  echo "⚠️⚠️⚠️  These packages may not be available on $(lsb_release -sc). Check manually."
  echo ""
fi

# Ubuntu installs bat as 'batcat' due to naming conflict — symlink it
ln -sf /usr/bin/batcat ~/.local/bin/bat

# ====================
# GitHub CLI - UPGRADE: remove this section on Ubuntu 22.04+ (use apt instead)
# ====================
if ! command -v gh &>/dev/null; then
  echo "📦 Installing GitHub CLI..."
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
  sudo apt update
  sudo apt install -y gh
else
  echo "✓ gh already installed"
fi

# ====================
# Oh-My-Zsh
# ====================
if [ ! -d ~/.oh-my-zsh ]; then
  echo "📦 Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "✓ oh-my-zsh already installed"
fi

# zsh-syntax-highlighting plugin
if [ ! -d ~/.oh-my-zsh/plugins/zsh-syntax-highlighting ]; then
  echo "📦 Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
else
  echo "✓ zsh-syntax-highlighting already installed"
fi

# ====================
# Symlinks
# ====================
mkdir -p ~/.config
mkdir -p ~/.local/bin
mkdir -p ~/.zfunc  # Custom zsh completions

ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/.aliases ~/.aliases
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig

# Directory symlinks
link_dir ~/.dotfiles/config/nvim ~/.config/nvim
# link_dir ~/.dotfiles/config/ghostty ~/.config/ghostty

echo "Dotfiles have been symlinked to home directory."

# ====================
# Custom Scripts & GNOME Setup
# ====================
echo "📸 Setting up custom scripts..."

if [ -f ~/.dotfiles/linux/scripts/screenshot-to-clipboard.sh ]; then
  ln -sf "$HOME/.dotfiles/linux/scripts/screenshot-to-clipboard.sh" ~/.local/bin/screenshot-to-clipboard.sh
  chmod +x ~/.local/bin/screenshot-to-clipboard.sh
  echo "✓ screenshot-to-clipboard.sh linked"
else
  echo "⚠️  screenshot-to-clipboard.sh not found, skipping"
fi

# GNOME keyindings (only if running GNOME)
if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ] || [ "$XDG_CURRENT_DESKTOP" = "ubuntu:GNOME" ]; then
  if [ -f ~/.dotfiles/linux/gnome-keybindings.sh ]; then
    echo "⌨️  Setting up GNOME keybindings..."
    bash ~/.dotfiles/linux/gnome-keybindings.sh
  fi
fi

# ====================
# zoxide - UPGRADE: remove this section on Ubuntu 24.04+ (use apt instead)
# ====================
if ! command -v zoxide &>/dev/null; then
  echo "📦 Installing zoxide..."
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
else
  echo "✓ zoxide already installed"
fi

# ====================
# thefuck
# ====================
if ! command -v thefuck &>/dev/null; then
  echo "📦 Installing thefuck..."
  pip install thefuck --user --break-system-packages
else
  echo "✓ thefuck already installed"
fi

# ====================
# uv (Python package manager)
# ====================
if ! command -v uv &>/dev/null; then
  echo "📦 Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
else
  echo "✓ uv already installed"
fi

# ====================
# pyenv
# ====================
if [ ! -d ~/.pyenv ]; then
  echo "📦 Installing pyenv..."
  curl https://pyenv.run | bash
else
  echo "✓ pyenv already installed"
fi

# ====================
# nvm - # UPGRADE: consider switching to fnm to match macOS config
# ====================
if [ ! -d ~/.nvm ]; then
  echo "📦 Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
else
  echo "✓ nvm already installed"
fi

# ====================
# rbenv
# ====================
if [ ! -d ~/.rbenv ]; then
  echo "📦 Installing rbenv..."
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
else
  echo "✓ rbenv already installed"
fi

# ====================
# tfenv
# ====================
if [ ! -d ~/.tfenv ]; then
  echo "📦 Installing tfenv..."
  git clone https://github.com/tfutils/tfenv.git ~/.tfenv
else
  echo "✓ tfenv already installed"
fi

# ====================
# Go
# ====================
if [ ! -d /usr/local/go ]; then
  echo "📦 Installing Go..."
  GO_VERSION="1.23.4"
  curl -LO "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"
  sudo tar -C /usr/local -xzf "go${GO_VERSION}.linux-amd64.tar.gz"
  rm "go${GO_VERSION}.linux-amd64.tar.gz"
else
  echo "✓ Go already installed"
fi

# ====================
# pgenv (PostgreSQL version manager)
# ====================
if [ ! -d ~/.pgenv ]; then
  echo "📦 Installing pgenv..."
  git clone https://github.com/theory/pgenv.git ~/.pgenv
else
  echo "✓ pgenv already installed"
fi

# ====================
# Default Shell (zsh)
# ====================
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "🐚 Setting zsh as default shell..."
  chsh -s "$(which zsh)"
else
  echo "✓ zsh is already default shell"
fi

# ====================
# Work Setup
# ====================
run_work_setup() {
  echo "💼 Running work setup..."
  # Add work-specific setup here
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

echo "🐧 Linux setup complete."
