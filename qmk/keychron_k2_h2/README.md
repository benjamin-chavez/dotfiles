# Keychron K2 HE Custom Keymap

Custom QMK keymap for the Keychron K2 HE (Hall Effect) keyboard.

## Changes from Stock

| Layer | Key | Change | Purpose |
|-------|-----|--------|---------|
| MAC_BASE | Caps Lock | `KC_CAPS` → `HYPR_ESC` | Tap for Escape (vim), hold for Hyper (Ctrl+Alt+Cmd+Shift) |
| MAC_BASE | Left modifiers | `KC_LCTL` ↔ `KC_LCMMD` | Command in corner, more natural for Cmd+C/V/etc |
| WIN_BASE | Caps Lock | `KC_CAPS` → `HYPR_ESC` | Same tap/hold behavior as Mac layer |


## Setup
```bash
./setup.sh
```

Clones the Keychron QMK fork and symlinks this keymap.

## Build
```bash
./build.sh
```

## Flash

1. Unplug keyboard
2. Hold Esc while plugging in USB
3. Run: `./build.sh flash`

## Dependencies

- QMK CLI: `brew install qmk/qmk/qmk`
- ARM toolchain: `brew install osx-cross/arm/arm-none-eabi-gcc@8`
- AVR toolchain: `brew install osx-cross/avr/avr-gcc@8`
- Binutils: `brew install osx-cross/arm/arm-none-eabi-binutils`

## References

- [Keychron QMK Fork](https://github.com/Keychron/qmk_firmware/tree/hall_effect_playground)
- [QMK Keycodes](https://docs.qmk.fm/keycodes)
- [Mod-Tap](https://docs.qmk.fm/mod_tap)