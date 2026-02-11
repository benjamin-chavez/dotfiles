#!/bin/bash
# .dotfiles/linux/scripts/screenshot-to-clipboard.sh
maim -s /tmp/screenshot.png && \
  xclip -selection clipboard -t image/png < /tmp/screenshot.png && \
  (canberra-gtk-play -i camera-shutter &) && \
  notify-send "Screenshot copied" -t 1500 -i /tmp/screenshot.png
