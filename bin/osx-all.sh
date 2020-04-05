#!/bin/sh

# change directory to the shell file's directory
SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

DOT_DIRECTORY="${HOME}/dotfiles"

ech(){ sh "$SCRIPT_DIR/echo.sh" "$*"; }

function CheckOSType () {
  if [ $(uname) != "Darwin" ];then
    ech "Your computer is not macOS"
    ech "Abort to setup"
    exit
  fi
}

function InstallXcodeDevTool () {
  ech "Install XCode-developper tool"
  while :
  do
    xcode-select -v
    if [ "$?" = '0' ]; then
      break
    fi
    ech "Need command line tools for xcode"
    xcode-select -install

    ech "If you finish to install 'command line tools for xcode', Prease press Enter key"
    read hoge
  done
}

function InstallBrew () {
  ech "Install homebrew"
  while :
  do
    which brew
    if [ "$?" = '0' ]; then
      break
    fi
    ech "Need homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    ech "If you finish to install 'homebrew', Prease press Enter key"
    read hoge
  done
}

function InstallMasCli () {
  ech "Check to be installed mas-cli"
  while :
  do
    which mas
    if [ "$?" = '0' ];then
      break
    fi
    ech 'Need mas-cli'
    brew install mas-cli
    ech "If you finish to install 'mas-cli', Prease press Enter key"
    read hoge
  done
}

function SignInToAppleID () {
  ech "Sign in to Apple ID"
  while :
  do
    mas account > /dev/null 2>&1
    if [ "$?" = '0' ]; then
      break
    fi
    ech "Prease sign in to Apple ID for mas-cli"
    mas open
    ech "If you finish to sign in, Prease press Enter key"
    read hoge
  done
}

CheckOSType
InstallXcodeDevTool
InstallBrew
/bin/bash osx/brew-install.sh
InstallMasCli
SignInToAppleID
/bin/bash osx/mas-install.sh
/bin/bash deploy.sh
 
