#!/usr/bin/env bash

# aws-sso-login-script.sh

output=$(aws sso login)
success_url=$(echo "$output" | sed 's/.*\(https:\/\/.*\)/\1/' | tail -1)

browser_cmd=""
if [ -n "$success_url" ]; then
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
fi

if [ -n "$browser_cmd" ]; then
  eval "$browser_cmd '$success_url'"
else
  echo "Unsupported OS. Failed to open browser to URL: $success_url"
fi
