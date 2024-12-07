# #!/bin/bash

handle_error() {
  echo "Error: $1"
  exit 1
}

INSTALLED_VERSION=$(printf "%s\n" "$(cat /opt/Webstorm/build.txt 2>/dev/null)" |
  sed 's/WS-\([0-9]\{2\}\)\([0-9]\)\.\([0-9]\+\).*/20\1.\2.1/')
echo "Installed Version: $INSTALLED_VERSION"

LTS_VERSION=$(curl -s https://data.services.jetbrains.com/products/releases\?code\=WS\&type\=release\&type\=lts |
  grep -o '"version":"[^"]*"' |
  head -1 |
  sed 's/"version":"//g' |
  sed 's/"//g')
echo "Webstorm LTS: $LTS_VERSION"
echo

if [ -n "$INSTALLED_VERSION" ] && [ "$INSTALLED_VERSION" = "$LTS_VERSION" ]; then # -n: string is not empty
  echo "Latest version of Webstorm already installed. Exiting script..."
  exit 0
fi

cd ~/Downloads || handle_error "Could not change to Downloads directory"

wget "https://download.jetbrains.com/webstorm/WebStorm-${LTS_VERSION}.tar.gz" || handle_error "Download failed"

sudo rm -rf /opt/Webstorm

[ -f "WebStorm-${LTS_VERSION}.tar.gz" ] || handle_error "Downloaded file not found" # -f: exists and is a regular file
tar -xzf "WebStorm-${LTS_VERSION}.tar.gz" || handle_error "Extraction failed"

sudo mv WebStorm-*/ /opt/Webstorm

NEWLY_INSTALLED_VERSION=$(printf "%s\n" "$(cat /opt/Webstorm/build.txt)" | sed 's/WS-\([0-9]\{2\}\)\([0-9]\)\.\([0-9]\+\).*/20\1.\2.\3/')
printf "Successfully installed Webstorm version %s\n" "$NEWLY_INSTALLED_VERSION"

rm "WebStorm-${LTS_VERSION}.tar.gz"*

echo "$LTS_VERSION"
