#!/usr/bin/env bash
# ~/.dotfiles/qmk/keychron_k2_he/build.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
IMAGE_NAME="keychron-k2-he-qmk"

# Build image if it doesn't exist
if ! docker image inspect "$IMAGE_NAME" &>/dev/null; then
    echo "Building Docker image..."
    docker build -t "$IMAGE_NAME" "$SCRIPT_DIR"
fi

mkdir -p "$SCRIPT_DIR/output"

docker run --rm \
    -v "$SCRIPT_DIR":/qmk_firmware/keyboards/keychron/k2_he/ansi_rgb/keymaps/custom \
    -v "$SCRIPT_DIR/output":/output \
    "$IMAGE_NAME" \
    sh -c "qmk compile -kb keychron/k2_he/ansi_rgb -km custom && cp *.bin /output/"

echo ""
echo "Firmware saved to: $SCRIPT_DIR/output/"
echo "To flash: put keyboard in bootloader mode (hold Esc + plug in), then run:"
echo "  dfu-util -a 0 -D $SCRIPT_DIR/output/keychron_k2_he_ansi_rgb_custom.bin -s 0x08000000:leave"

# --------------------------
# non-docker machine install version:
#!/usr/bin/env bash
# qmk/keychron_k2_he/build.sh

#set -e
#
#export PATH="/opt/homebrew/opt/avr-gcc@8/bin:$PATH"
#export PATH="/opt/homebrew/opt/arm-none-eabi-gcc@8/bin:$PATH"
#export PATH="/opt/homebrew/opt/arm-none-eabi-binutils/bin:$PATH"
#
#if [ "$1" = "flash" ]; then
#    qmk flash -kb keychron/k2_he/ansi_rgb -km custom
#else
#    qmk compile -kb keychron/k2_he/ansi_rgb -km custom
#fi