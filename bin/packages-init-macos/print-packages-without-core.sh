#!/bin/bash -e

DOTFILES_DIR="$HOME/dotfiles"
PRINT_PACKAGES_PATH="$DOTFILES_DIR/bin/packages-init-macos/print-packages.sh"
BREW_FILE="$DOTFILES_DIR/.Brewfile"
BREW_FILE_CORE="$DOTFILES_DIR/bin/packages-init-macos/brewfile-core"

DUMP_FILE_TMP="/tmp/brewfile-dump"
DUMP_FILE_TMP_CORE="/tmp/brewfile-dump-core"

BREW_TYPE="$1"

bash "$PRINT_PACKAGES_PATH" "$BREW_FILE_CORE" "$BREW_TYPE" | awk -v RS=' ' ' { print $0 }' > "$DUMP_FILE_TMP_CORE"
bash "$PRINT_PACKAGES_PATH" "$BREW_FILE" "$BREW_TYPE" | awk -v RS=' ' ' { print $0 }' > "$DUMP_FILE_TMP"

cat "$DUMP_FILE_TMP_CORE" \
  | diff --new-line-format='%L' --unchanged-line-format='' - "$DUMP_FILE_TMP" \
  | xargs echo

rm "$DUMP_FILE_TMP"
rm "$DUMP_FILE_TMP_CORE"

