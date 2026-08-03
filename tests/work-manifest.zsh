#!/usr/bin/env zsh

set -e

DOTFILES_ROOT="${0:A:h:h}"

if ! grep -Fqx 'brew tap hashicorp/tap' "$DOTFILES_ROOT/install-work"; then
  print -u2 -- "Work installer does not explicitly tap HashiCorp before Brew Bundle."
  exit 1
fi

if ! grep -Fqx 'brew trust --formula hashicorp/tap/terraform' "$DOTFILES_ROOT/install-work"; then
  print -u2 -- "Work installer does not trust the exact Terraform formula."
  exit 1
fi

tap_line=$(grep -nF 'brew tap hashicorp/tap' "$DOTFILES_ROOT/install-work" | cut -d: -f1)
trust_line=$(grep -nF 'brew trust --formula hashicorp/tap/terraform' "$DOTFILES_ROOT/install-work" | cut -d: -f1)
bundle_line=$(grep -nF 'brew bundle --file="$DOTFILES_DIR/Brewfile.work" --verbose' "$DOTFILES_ROOT/install-work" | cut -d: -f1)

if (( tap_line >= trust_line || trust_line >= bundle_line )); then
  print -u2 -- "HashiCorp tap and formula trust must run before Brew Bundle."
  exit 1
fi

zsh -n "$DOTFILES_ROOT/install-work"
print -- "Work manifest checks passed."
