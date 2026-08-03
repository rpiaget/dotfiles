#!/usr/bin/env zsh

set -e

DOTFILES_ROOT="${0:A:h}"
LINK_HOME="${DOTFILES_LINK_HOME:-$HOME}"
BACKUP_TIMESTAMP="${DOTFILES_BACKUP_TIMESTAMP:-$(date +%Y%m%d-%H%M%S)}"

mkdir -p "$LINK_HOME/.config"

for app in aerospace ghostty sketchybar; do
  source_path="$DOTFILES_ROOT/config/$app"
  destination="$LINK_HOME/.config/$app"

  if [[ ! -d "$source_path" ]]; then
    print -u2 -- "Tracked config source is missing: $source_path"
    exit 1
  fi

  if [[ -L "$destination" && "${destination:A}" == "${source_path:A}" ]]; then
    print -- "UNCHANGED: $destination already links to the tracked config"
    continue
  fi

  if [[ -e "$destination" || -L "$destination" ]]; then
    backup="${destination}.pre-dotfiles-${BACKUP_TIMESTAMP}"
    suffix=1
    while [[ -e "$backup" || -L "$backup" ]]; do
      backup="${destination}.pre-dotfiles-${BACKUP_TIMESTAMP}-${suffix}"
      (( suffix += 1 ))
    done

    mv "$destination" "$backup"
    print -- "BACKED UP: $destination -> $backup"
  fi
done
