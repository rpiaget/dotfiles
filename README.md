# Dotfiles

Portable personal configuration for a fresh macOS development environment.

## Install the base layer

```sh
git clone git@github-rpiaget:rpiaget/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

The base installer creates symlinks with Dotbot and installs the intentionally small shared toolset in `Brewfile`: shell and development CLIs, Git, Go, Python, Node, Docker Desktop, Ghostty, Raycast, Shottr, and the opt-in AeroSpace/SketchyBar environment. It also starts the Clipaste service.

## Optional install layers

Install work command-line prerequisites after Cisco enrollment:

```sh
~/.dotfiles/install-work
```

`Brewfile.work` installs AWS CLI/SAM/log tooling, network diagnostics, and Terraform from HashiCorp's official tap. Cisco-managed applications, Streamline, Claude Code, Codex, and corporate authentication still use their supported installation flows.

Install selected personal applications only when wanted:

```sh
~/.dotfiles/install-personal
```

`Brewfile.personal` installs Dropbox, Cursor, VS Code, Spotify, Steam, Instapaper, and only the Go, Python/Pylance, and GitHub pull-request VS Code extensions.

Obsidian, VirtualBox, BetterDisplay/DisplayLink, legacy App Store applications, and broad language-extension packs are intentionally omitted. Obsidian data remains independently preserved in Dropbox and does not require the app to be installed during bootstrap.

## Local layers

The public Zsh configuration loads these optional, untracked files when they exist:

- `~/.config/zsh/local.zsh` for machine-specific personal settings
- `~/.config/zsh/work.zsh` for employer-specific aliases and environment setup
- `~/.config/zsh/work-claude.zsh` for the work Claude/Bedrock environment

Never add credentials or employer-specific configuration to this repository.

## macOS preferences

After installation, review and apply the audited system preferences:

```sh
~/.dotfiles/macos/defaults.zsh
```

See `macos/README.md` for manual shortcuts, Raycast export/import and Clipboard History, Shottr, text replacements, and intentionally omitted machine-specific state.

## Window management

`devmode` manually toggles AeroSpace, borders, and SketchyBar. The linked AeroSpace configuration retains `start-at-login = false`.
