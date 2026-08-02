# Dotfiles

Portable personal configuration for a fresh macOS development environment.

## Install

```sh
git clone git@github-rpiaget:rpiaget/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

The installer creates symlinks with Dotbot and installs the applications in `Brewfile`. The Homebrew setup is safe to rerun.

## Local layers

The public Zsh configuration loads these optional, untracked files when they exist:

- `~/.config/zsh/local.zsh` for machine-specific personal settings
- `~/.config/zsh/work.zsh` for employer-specific aliases and environment setup
- `~/.config/zsh/work-claude.zsh` for the work Claude/Bedrock environment

Never add credentials or employer-specific configuration to this repository.

## Window management

`devmode` manually toggles AeroSpace, borders, and SketchyBar. AeroSpace machine configuration is intentionally separate and should retain `start-at-login = false`.
