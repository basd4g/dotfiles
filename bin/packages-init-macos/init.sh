#!/bin/bash -e

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

ech(){ sh "$DOTFILES_DIR/bin/echo.sh" "$*"; }


if ! which brew > /dev/null 2>&1 ; then
  ech "Need homebrew. Prease install homebrew and retry the script."
  exit 1
fi

ech "Install packages"
brew bundle --global

