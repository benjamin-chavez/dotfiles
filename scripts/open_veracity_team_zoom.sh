#!/usr/bin/env bash

# bash_scripts/open_veracity_team_zoom.sh

ZOOM_URL="https://us06web.zoom.us/j/85671091851?pwd=JsN5yAZC4SiKECe4Xgo7pCOklgPqwz.1"

browser_cmd=""

if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  # browser_cmd="open -a 'Google Chrome' || open"
  browser_cmd="open"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux
  browser_cmd="xdg-open"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
  # Windows
  browser_cmd="start"
fi

if [ -n "$browser_cmd" ]; then
  eval "$browser_cmd '$ZOOM_URL'"
else
  echo "Unsupported OS. Failed Veracity Team Zoom Channel"
fi
