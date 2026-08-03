#!/usr/bin/env zsh

set -e

DOTFILES_ROOT="${0:A:h:h}"

if grep -Eq '^tap "homebrew/(bundle|cask|core)"$' "$DOTFILES_ROOT/Brewfile"; then
  print -u2 -- "Brewfile contains an obsolete built-in Homebrew tap."
  exit 1
fi

if grep -q 'eth-p/software' "$DOTFILES_ROOT/Brewfile"; then
  print -u2 -- "Brewfile still references the retired third-party bat-extras tap."
  exit 1
fi

required_trust_entries=(
  'brew trust --formula hqhq1025/clipaste/clipaste'
  'brew trust --formula felixkratz/formulae/borders'
  'brew trust --formula felixkratz/formulae/sketchybar'
  'brew trust --cask nikitabobko/tap/aerospace'
)

for trust_entry in "${required_trust_entries[@]}"; do
  if ! grep -Fqx "$trust_entry" "$DOTFILES_ROOT/setup_homebrew.zsh"; then
    print -u2 -- "Missing scoped Homebrew trust entry: $trust_entry"
    exit 1
  fi
done

zsh -n "$DOTFILES_ROOT/setup_homebrew.zsh"
bash -n "$DOTFILES_ROOT/bootstrap-macos"

print -- "Bootstrap manifest checks passed."
