# Keychron K2 HE Custom Keymap

Custom QMK keymap for the Keychron K2 HE (Hall Effect) keyboard.

## Dependencies

- Docker
- dfu-util: `brew install dfu-util`

## Quickstart

1. Build firmware (first run takes ~2 min for Docker image):
```bash
   ./build.sh
```

2. Put keyboard in bootloader mode:
    - Unplug keyboard
    - Hold Esc + plug in USB
    - Release Esc after ~1 second

3. Flash to keyboard:
```bash
   ./flash.sh
```

## Changes from Stock

| Layer | Key | Change | Purpose |
|-------|-----|--------|---------|
| MAC_BASE | Caps Lock | `KC_CAPS` → `HYPR_ESC` | Tap for Escape (vim), hold for Hyper (Ctrl+Alt+Cmd+Shift) |
| MAC_BASE | Left modifiers | `KC_LCTL` ↔ `KC_LCMMD` | Command in corner, more natural for Cmd+C/V/etc |
| WIN_BASE | Caps Lock | `KC_CAPS` → `HYPR_ESC` | Same tap/hold behavior as Mac layer |

## References

- [Original Default Keymap](https://github.com/Keychron/qmk_firmware/blob/hall_effect_playground/keyboards/keychron/k2_he/ansi_rgb/keymaps/default/keymap.c)
- [K2 HE Keyboard Definition](https://github.com/Keychron/qmk_firmware/tree/hall_effect_playground/keyboards/keychron/k2_he)
- [QMK Keycodes](https://docs.qmk.fm/keycodes)
- [Mod-Tap](https://docs.qmk.fm/mod_tap)