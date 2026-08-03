#!/usr/bin/env zsh

set -e

DOTFILES_ROOT="${0:A:h:h}"
TEST_ROOT="$(mktemp -d /private/tmp/dotfiles-config-links.XXXXXX)"
trap 'rm -rf "$TEST_ROOT"' EXIT

TEST_HOME="$TEST_ROOT/home"
mkdir -p "$TEST_HOME/.config/aerospace"
mkdir -p "$TEST_HOME/.config/ghostty"
mkdir -p "$TEST_HOME/.config/sketchybar"

print -- "existing aerospace config" > "$TEST_HOME/.config/aerospace/local.toml"
print -- "existing ghostty config" > "$TEST_HOME/.config/ghostty/local.conf"
print -- "existing sketchybar config" > "$TEST_HOME/.config/sketchybar/local.sh"

DOTFILES_LINK_HOME="$TEST_HOME" \
DOTFILES_BACKUP_TIMESTAMP="test-run" \
  "$DOTFILES_ROOT/prepare-config-links.zsh"

for app in aerospace ghostty sketchybar; do
  destination="$TEST_HOME/.config/$app"
  backup="$destination.pre-dotfiles-test-run"

  if [[ -e "$destination" || -L "$destination" ]]; then
    print -u2 -- "Conflicting destination was not cleared for linking: $destination"
    exit 1
  fi

  if [[ ! -d "$backup" ]]; then
    print -u2 -- "Conflicting directory was not preserved: $backup"
    exit 1
  fi
done

# A rerun before Dotbot links should be harmless and must not create more backups.
DOTFILES_LINK_HOME="$TEST_HOME" \
DOTFILES_BACKUP_TIMESTAMP="second-run" \
  "$DOTFILES_ROOT/prepare-config-links.zsh"

if find "$TEST_HOME/.config" -name '*.pre-dotfiles-second-run' | grep -q .; then
  print -u2 -- "An idempotent rerun created an unnecessary backup."
  exit 1
fi

# Once Dotbot has linked a config, the preparation step must leave it untouched.
ln -s "$DOTFILES_ROOT/config/ghostty" "$TEST_HOME/.config/ghostty"
DOTFILES_LINK_HOME="$TEST_HOME" \
DOTFILES_BACKUP_TIMESTAMP="linked-run" \
  "$DOTFILES_ROOT/prepare-config-links.zsh"

if [[ ! -L "$TEST_HOME/.config/ghostty" ]]; then
  print -u2 -- "A correct existing symlink was replaced."
  exit 1
fi

linked_ghostty="$TEST_HOME/.config/ghostty"
tracked_ghostty="$DOTFILES_ROOT/config/ghostty"
if [[ "${linked_ghostty:A}" != "${tracked_ghostty:A}" ]]; then
  print -u2 -- "The correct symlink no longer resolves to the tracked config."
  exit 1
fi

print -- "Config-link conflict checks passed."
