#!/usr/bin/env bash
# ~/.dotfiles/setup.sh

case "$(uname -s)" in
  Darwin)  source "$(dirname "$0")/mac/setup.sh" ;;
  Linux)   source "$(dirname "$0")/linux/setup.sh" ;;
  *)       echo "Unsupported OS"; exit 1 ;;
esac