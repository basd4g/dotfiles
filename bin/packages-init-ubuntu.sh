#!/bin/bash -e

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

ech(){ sh "$DOTFILES_DIR/bin/echo.sh" "$*"; }

if [ "$(whoami)" != "root" ]; then
  echo "Require root privilege"
  exit 1
fi
if ! which apt-get > /dev/null 2>&1 ; then
  ech "Need apt-get"
  exit 1
fi

ech "Install packages"

# ========== nodejs ==========
curl -sL https://deb.nodesource.com/setup_13.x | bash -
apt-get update
apt-get upgrade -y
apt-get install -y nodejs

# ========== apt-get ==========
apt-get install -y yarn
apt-get install -y vim
apt-get install -y zsh

apt-get install -y gdebi
apt-get install -y ffmpeg
apt-get install -y git
apt-get install -y lynx
apt-get install -y mysql-server
apt-get install -y mysql-client
apt-get install -y nkf
apt-get install -y nmap
apt-get install -y shellcheck
apt-get install -y tree
apt-get install -y ibus-mozc

# ========== xkeysnail ==========
apt-get install python3-pip
pip3 install xkeysnail

# ========== snap ==========
snap install --classic code
snap install --classic heroku

# ========== docker ==========
curl https://get.docker.com | sh

# docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# ========== Chrome ==========
sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt-get/sources.list.d/google.list'
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-get-key add -
apt-get update
apt-get install google-chrome-stable

# Extension
# LINE
# BitWarden

# ========== HackGen ==========
TMP_FILE="/tmp/dotfiles/hackgen.zip"
mkdir -p "$(dirname "$TMP_FILE")"
VERSION="$(curl -sI https://github.com/yuru7/HackGen/releases/latest | grep location | awk -F '/' '{print $NF }')"
mkdir -p "$(dirname "$TMP_HYPER")"
curl "https://github.com/yuru7/HackGen/releases/download/$VERSION/HackGen_$VERSION.zip" -o "$TMP_FILE"
unzip "$TMP_FILE"
mv "HackGen_$VERSION" "/usr/share/fonts/HackGen"
fc-cache -fv

# ========== hyper ==========
TMP_FILE="/tmp/dotfiles/hyper.deb"
mkdir -p "$(dirname "$TMP_FILE")"
curl -L https://releases.hyper.is/download/deb -o "$TMP_FILE"
gdebi "$TMP_FILE"

