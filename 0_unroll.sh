#! /usr/bin/env bash
DOTFILES_D=~/.dotfiles

cd ~ || exit


# Unroll files
for SOURCE in $(find "$DOTFILES_D" -maxdepth 1 -type f -name ".*")
do
  DESTINATION=$(basename "$SOURCE")
  [[ -f $SOURCE ]] && ln --symbolic --interactive "$SOURCE" "$DESTINATION"
done


# Unroll folders
function unroll_folder {
  local SOURCE=$1
  local DESTINATION=$2
  [[ -d $DESTINATION ]] && echo "Merging $DESTINATION folder..." && cp --recursive "$DESTINATION"/* "$SOURCE"
  rm -rf "$DESTINATION"
  ln --symbolic "$SOURCE" "$DESTINATION"
}

unroll_folder $DOTFILES_D/.bashrc.d .bashrc.d
unroll_folder $DOTFILES_D/.local/share/nautilus/scripts .local/share/nautilus/scripts


unset DOTFILES_D
