#!/bin/bash -e

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

ech(){ sh "$DOTFILES_DIR/bin/echo.sh" "$*"; }

if ! which yarn > /dev/null 2>&1 ; then
  ech "Need yarn. Prease install yarn and retry the script."
  exit 1
fi

yarn global add
