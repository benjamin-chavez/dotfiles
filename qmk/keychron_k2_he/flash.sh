#!/usr/bin/env bash
#
# /.dotfiles/qmk/keychron_k2_h2/flash.sh
#
# Flashes the compiled QMK firmware to the Keychron K2 HE keyboard.
#
# Prerequisites:
#   - dfu-util installed (brew install dfu-util)
#   - Firmware built via ./build.sh
#
# Usage:
#   ./flash.sh
#
# The keyboard must be in bootloader mode (DFU mode) before flashing:
#   1. Unplug the keyboard
#   2. Hold the Esc key
#   3. Plug in the USB cable while holding Esc
#   4. Release Esc after ~1 second
#
# dfu-util flags:
#   -a 0                   Select alt interface 0 (default for STM32)
#   -D <file>              Download firmware file to device
#   -s 0x08000000:leave    Start address for STM32 flash, then exit DFU mode

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN_FILE="$SCRIPT_DIR/output/keychron_k2_he_ansi_rgb_custom.bin"

if [ ! -f "$BIN_FILE" ]; then
    echo "Firmware not found. Run ./build.sh first."
    exit 1
fi

echo "Put keyboard in bootloader mode (hold Esc + plug in USB), then press Enter..."
read

dfu-util -a 0 -D "$BIN_FILE" -s 0x08000000:leave