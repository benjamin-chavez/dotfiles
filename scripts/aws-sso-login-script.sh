#!/usr/bin/env bash

# aws-sso-login-script.sh - Automatically opens AWS SSO login URL in browser

output=$(aws sso login "$@")

# Auth Url Pattern: https://oidc.region.amazonaws.com/authorize?response_type=code&client_id=...
# Success Url Pattern: https://d-12345abcde.awsapps.com/start
auth_url=$(echo "$output" | grep -o 'https://[^ ]*authorize[^ ]*' | head -1)
success_url=$(echo "$output" | grep -o 'https://.*\.awsapps\.com/start' | head -1)

url_to_open="${auth_url:-$success_url}"

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

if [[ -n "$browser_cmd" && -n "$url_to_open" ]]; then
  echo "Opening URL in browser: $url_to_open"
  $browser_cmd "$url_to_open"
else
  [[ -z "$browser_cmd" ]] && echo "Unsupported OS. Failed to open browser."
  [[ -z "$url_to_open" ]] && echo "No URL found to open. Check AWS SSO login output."
fi
