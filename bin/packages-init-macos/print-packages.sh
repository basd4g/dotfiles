#!/bin/bash -e

BREW_FILE="$1"
BREW_TYPE="$2"

if    [ "$BREW_TYPE" != "brew" ] \
  &&  [ "$BREW_TYPE" != "tap" ] \
  &&  [ "$BREW_TYPE" != "cask" ] \
  &&  [ "$BREW_TYPE" != "mas" ]; then
  exit 1
fi

awk '/^[^#]/ { print } ' "$BREW_FILE" \
  | grep -E "^${BREW_TYPE} " \
  | awk -F '"' '{ print $2 }' \
  | xargs echo
