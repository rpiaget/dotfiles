# macOS settings and shortcuts

`defaults.zsh` applies the stable, portable preferences audited from the old Mac. Run it after the main dotfiles installer:

```sh
~/.dotfiles/macos/defaults.zsh
```

It configures:

- Dark Mode and visible file extensions
- fast key repeat
- automatic capitalization, double-space periods, and spelling correction off
- global Strikethrough menu shortcut: Control-Shift-Command-S
- Dock autohide and magnification
- fixed Space ordering and grouped Mission Control windows
- top-right hot corner: put display to sleep
- bottom-right hot corner: Quick Note
- Finder list view and desktop-volume visibility
- screenshot thumbnail previews off
- clock showing weekday and AM/PM, without the date

The script intentionally does not copy the entire preferences database. Display arrangements, device identifiers, managed Cisco settings, trackpad defaults, and opaque macOS symbolic-hotkey records are machine or OS-version specific.

## App configuration

Dotbot links these reviewed configurations into `~/.config`:

- AeroSpace: manual `devmode`, with `start-at-login = false`
- Ghostty: custom Catppuccin Mocha theme and Command-V terminal paste binding
- SketchyBar: the active shell configuration and five referenced plugins

The unused SketchyBar Lua demo tree and its compiled ARM helper binaries are excluded.

## Raycast

Use Raycast as the launcher and window-command tool. Enable Launch at Login after installation. Do not restore Alfred or Divvy.

Before wiping the old Mac, run **Export Settings & Data** in Raycast and save the encrypted `.rayconfig` file in the Cisco OneDrive migration folder. The export includes settings, aliases, hotkeys, extensions, snippets, and window-management layouts. Store the export passphrase in 1Password; do not put it beside the export.

On the new Mac, use Raycast’s **Import Settings & Data** command and select the desired categories.

## Shottr

Install Shottr, enable Launch at Login, and recreate these global shortcuts:

- Fullscreen capture: Shift-Command-1
- Area capture: Control-Shift-2
- OCR: Control-Option-Command-O

Keep its editor-first area-capture behavior and screenshot-thumbnail workflow. Choose a new save folder deliberately; do not restore the old Dropbox bookmark or copy Shottr’s full preferences plist.

## Text replacements

`text-replacements.json` is a human-readable reference snapshot. Prefer iCloud synchronization or Apple’s supported Text Replacements export/import UI instead of writing the global preferences plist directly.

## Login items

Expected user-controlled login items:

- Raycast
- Shottr
- Dropbox, only if still wanted after the cloud-storage audit

Cisco Secure Client, Microsoft SharePoint, and DisplayLink Manager are managed or hardware-specific and should be installed/configured through their supported flows. AeroSpace, Alfred, and Divvy should not be login items.

## Intentionally omitted

- Karabiner: installed but its selected profile contains no mappings
- Alfred: superseded by Raycast; the old workflow bundle is not a clean migration source
- Divvy: superseded by Raycast and AeroSpace
- display placement/scaling and BetterDisplay state: monitor-specific
- raw `com.apple.symbolichotkeys` import: opaque and macOS-version-specific
