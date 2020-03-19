#!/bin/sh

# Change directory to the shell file's directory
SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

anyenv install --force-init
anyenv install nodenv
exec $SHELL "$SCRIPT_DIR/3.sh" -l
