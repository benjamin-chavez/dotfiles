#!/usr/bin/env bash
# ~/.dotfiles/qmk/keychron_k2_he/setup.sh

set -e

QMK_REPO="https://github.com/Keychron/qmk_firmware.git"
QMK_BRANCH="hall_effect_playground"
QMK_PATH="$HOME/code/qmk_firmware_keychron"
KEYMAP_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ ! -d "$QMK_PATH" ]; then
    echo "Cloning QMK firmware..."
    git clone -b "$QMK_BRANCH" "$QMK_REPO" "$QMK_PATH"
fi

ln -sf "$KEYMAP_DIR" "$QMK_PATH/keyboards/keychron/k2_he/ansi_rgb/keymaps/custom"

echo "Done. To build:"
echo "  qmk compile -kb keychron/k2_he/ansi_rgb -km custom"