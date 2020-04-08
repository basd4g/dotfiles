#!/bin/bash -e

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

ech(){ sh "$DOTFILES_DIR/bin/echo.sh" "$*"; }

function BrewInstall() {
  PACKAGES_LIST_PATH="$1"
  ech "Install packages in $PACKAGES_LIST_PATH"
  brew bundle --file "$PACKAGES_LIST_PATH"
}

function InstallPackagesForMac() {
 if ! which brew > /dev/null 2>&1 ; then
    ech "Need homebrew. Prease install homebrew and retry the script."
    exit 1
  fi

  BREWFILE_CORE="$DOTFILES_DIR/etc/brewfile-core"
  BREWFILE="$DOTFILES_DIR/etc/brewfile"

  BrewInstall "$BREWFILE_CORE"

  if [ "$INSTALL_PACKAGES_CORE_ONLY" = "1" ]; then
    ech "Skip to install packages in $BREWFILE"
    return 0
  fi

  BrewInstall "$BREWFILE"
}

function AptInstall() {
  PACKAGES_LIST_PATH="$1"
  PASSWORD="$2"
  ech "Install packages in $PACKAGES_LIST_PATH"
  while read -r PACKAGE
  do
    echo "$PASSWORD" | sudo --stdin apt install -y "$PACKAGE"
  done < "$PACKAGES_LIST_PATH"
}

function InstallPackagesForUbuntu() {

  ech "Need root privilege to install with apt"
  read -rsp "Password: " PASSWORD

  if ! which apt > /dev/null 2>&1 ; then
    ech "Need apt"
    exit 1
  fi

  curl -sL https://deb.nodesource.com/setup_13.x | bash -
  echo "$PASSWORD" | sudo --stdin apt update
  echo "$PASSWORD" | sudo --stdin apt upgrade -y

  APTFILE_CORE="$DOTFILES_DIR/etc/aptfile-core"
  APTFILE="$DOTFILES_DIR/etc/aptfile"

  AptInstall "$APTFILE_CORE" "$PASSWORD"

  if [ "$INSTALL_PACKAGES_CORE_ONLY" = "1" ]; then
    ech "Skip to install packages in $APTFILE"
    return 0
  fi

  AptInstall "$APTFILE" "$PASSWORD"
}


if [ "$(uname)" = "Darwin" ];then
  ech "Install packages for macOS"
  InstallPackagesForMac

elif [ "$(uname)" = "Linux" ];then
  ech "Install packages for Linux"
  InstallPackagesForUbuntu
fi

