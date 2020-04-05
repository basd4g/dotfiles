#!/bin/sh

# Change directory to the shell file's directory
SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

ech(){ sh "$SCRIPT_DIR/../echo.sh" "$*"; }

# Check to be installed mas
if [ -z `which brew` ]; then
  ech 'Error. Need homebrew'
  exit 1
fi


ech 'Add brew taps'
# Taps
brew tap homebrew/cask
brew tap homebrew/cask-drivers
brew tap homebrew/cask-fonts


ech 'Install packages with brew'
# brew install hogehoge
BREW_LIST_PATH="$SCRIPT_DIR/brew-list"
cat "$BREW_LIST_PATH" | awk '{ print $1 }' | while read package
do
  brew list "$package" > /dev/null 2>&1
  if [ "$?" = "0" ]; then
    ech "  Skip to install package $package because it is Already installed"
    continue
  fi
  ech "  Install package $package"
  brew install "$package"
done


ech 'Install packages with brew-cask'
# brew cask install hogehoge
CASK_LIST_PATH="$SCRIPT_DIR/cask-list"
cat "$CASK_LIST_PATH" | awk '{ print $1 }' | while read package
do
  brew list "$package" > /dev/null 2>&1
  if [ "$?" = "0" ]; then
    ech "  Skip to install package $package because it is Already installed"
    continue
  fi
  ech "  Install package $package"
  brew cask install "$package"
done
