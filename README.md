# dotfiles






## Karabiner Notes

The keyboard (Keychron K2 HE) has a physical switch for Windows/macOS mode.

### macOS mode (current)

Fn key works. Use this `simple_modifications`:
```json
[
  {
    "from": { "key_code": "left_control" },
    "to": [{ "key_code": "left_command" }]
  },
  {
    "from": { "key_code": "left_command" },
    "to": [{ "key_code": "left_control" }]
  }
]
```

### Windows mode

Fn key does NOT work (handled by keyboard firmware, invisible to macOS). Use this `simple_modifications` instead:
```json
[
  {
    "from": { "key_code": "left_command" },
    "to": [{ "key_code": "left_option" }]
  },
  {
    "from": { "key_code": "left_control" },
    "to": [{ "key_code": "left_command" }]
  },
  {
    "from": { "key_code": "left_option" },
    "to": [{ "key_code": "left_control" }]
  }
]
```
