# Dotfiles

Portable personal configuration for a fresh macOS development environment.

## Bootstrap a bare Mac

From the built-in macOS Terminal, with only internet access:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/rpiaget/dotfiles/main/bootstrap-macos)"
```

`bootstrap-macos` triggers Apple's Command Line Tools installer when needed,
installs Homebrew, clones this repository over HTTPS, installs the base layer,
and offers the work, personal, and macOS-defaults layers interactively. The base
layer includes the 1Password desktop app and CLI, ChatGPT desktop with Codex,
the Codex CLI, and Ghostty, so none of those are prerequisites.

Cisco enrollment, Duo Desktop, account sign-in, 1Password SSH-agent approval,
OneDrive synchronization, and restoration of Cisco-only files remain separate
authenticated steps.

## Install the base layer

```sh
git clone git@github-rpiaget:rpiaget/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

The base installer creates symlinks with Dotbot and installs the intentionally small shared toolset in `Brewfile`: shell and development CLIs, Git, Go, Python, Node, Docker Desktop, 1Password Desktop and CLI, ChatGPT/Codex desktop, Codex CLI, Ghostty, Raycast, Shottr, and the opt-in AeroSpace/SketchyBar environment. It also starts the Clipaste service.

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
