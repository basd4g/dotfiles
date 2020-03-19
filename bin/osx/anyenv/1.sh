#!/bin/sh

# Change directory to the shell file's directory
SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

# Check to be installed mas
if [ -z `which brew` ]; then
  echo 'Need homebrew'
  exit 1
fi

brew install anyenv
exec $SHELL "$SCRIPT_DIR/2.sh" -l
