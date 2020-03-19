#!/bin/sh

# Change directory to the shell file's directory
SCRIPT_DIR=`dirname $0`
cd $SCRIPT_DIR

nodenv install --list
