#!/usr/bin/env zsh

set -e

DOTFILES_DIR="${0:A:h}"

echo "\n--- Setting up Homebrew ---\n"

if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Current Homebrew treats its core, cask, and bundle repositories as built-ins.
# Remove the retired bat-extras tap if an earlier bootstrap attempt added it;
# bat-extras now ships from official homebrew/core.
if brew tap | grep -qx "eth-p/software"; then
  legacy_bat_extras=()
  while IFS= read -r legacy_formula; do
    [[ -n "$legacy_formula" ]] && legacy_bat_extras+=("$legacy_formula")
  done < <(brew list --formula --full-name | grep '^eth-p/software/bat-extras' || true)

  if (( ${#legacy_bat_extras[@]} )); then
    print -- "Replacing legacy eth-p bat-extras formulae with official homebrew/core bat-extras..."
    brew uninstall "${legacy_bat_extras[@]}"
  fi

  brew untap eth-p/software
  unset legacy_bat_extras legacy_formula
fi

# These reviewed packages do not exist in official Homebrew repositories.
# Trust only the exact formulae/cask used by this configuration, not whole taps.
brew tap hqhq1025/clipaste
brew tap felixkratz/formulae
brew tap nikitabobko/tap
brew trust --formula hqhq1025/clipaste/clipaste
brew trust --formula felixkratz/formulae/borders
brew trust --formula felixkratz/formulae/sketchybar
brew trust --cask nikitabobko/tap/aerospace

brew bundle --file="$DOTFILES_DIR/Brewfile" --verbose
brew services start clipaste
