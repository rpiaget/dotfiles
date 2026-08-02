# Portable interactive Zsh configuration.

[[ -o interactive ]] || return 0

# Homebrew
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Paths
typeset -U path PATH
path=("$HOME/.local/bin" "$HOME/bin" $path)

export GOPATH="$HOME/go"
path=("$GOPATH/bin" $path)

if [[ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]]; then
  path=("/Applications/Visual Studio Code.app/Contents/Resources/app/bin" $path)
fi

# Prompt and Git branch
autoload -Uz add-zsh-hook vcs_info
zstyle ':vcs_info:git:*' formats '%b'
add-zsh-hook precmd vcs_info
setopt PROMPT_SUBST
PROMPT='%F{green}%n%f %F{cyan}@ %~%f %F{226}- [${vcs_info_msg_0_}]%f %F{green}%#%f '

# Completion
fpath=("$HOME/.zsh" $fpath)
autoload -Uz compinit
compinit

# Homebrew-installed interactive plugins
if (( $+commands[brew] )); then
  _brew_prefix="$(brew --prefix)"

  [[ -r "$_brew_prefix/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh" ]] &&
    source "$_brew_prefix/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh"

  [[ -r "$_brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] &&
    source "$_brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

  [[ -r "$_brew_prefix/opt/fzf/shell/completion.zsh" ]] &&
    source "$_brew_prefix/opt/fzf/shell/completion.zsh"
  [[ -r "$_brew_prefix/opt/fzf/shell/key-bindings.zsh" ]] &&
    source "$_brew_prefix/opt/fzf/shell/key-bindings.zsh"

  [[ -r "$_brew_prefix/etc/profile.d/z.sh" ]] &&
    source "$_brew_prefix/etc/profile.d/z.sh"
fi

# Python version management, when installed.
if (( $+commands[pyenv] )); then
  eval "$(pyenv init - zsh)"
fi

# Node version management, when installed through Homebrew.
if (( $+commands[brew] )); then
  _nvm_prefix="$(brew --prefix nvm 2>/dev/null)"
  if [[ -r "$_nvm_prefix/nvm.sh" ]]; then
    export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
    source "$_nvm_prefix/nvm.sh"
  fi
fi

# General aliases
alias ..='cd ..'
alias path="print -r -- \$PATH | tr ':' '\n'"
alias sortedenv='env | sort'
alias se='sortedenv'
alias sc='source ~/.zshrc'

if (( $+commands[eza] )); then
  alias eza='eza -lah --git'
  alias ls='eza -lah --git'
fi

if (( $+commands[bat] )); then
  alias cat='bat'
fi

if (( $+commands[batman] )); then
  alias man='batman'
fi

# Toggle the window-management setup used for development.
devmode() {
  if pgrep -x AeroSpace >/dev/null 2>&1; then
    killall AeroSpace borders sketchybar 2>/dev/null
    print 'Dev Mode disabled'
  else
    open -a AeroSpace
    print 'Dev Mode enabled'
  fi
}

# Select a recent local branch interactively.
gco() {
  local branch
  branch="$(git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)' |
    fzf --height=20% --layout=reverse --border --margin=1)" || return
  [[ -n "$branch" ]] && git switch "$branch"
}

# Select a pull request and open it in the browser.
propen() {
  local pr
  pr="$(gh pr list --state all |
    sed $'s/OPEN/\e[32mOPEN\e[0m/g; s/MERGED/\e[35mMERGED\e[0m/g; s/CLOSED/\e[31mCLOSED\e[0m/g' |
    fzf --height=12 --layout=reverse --border --margin=1 --ansi |
    awk '{print $1}')" || return
  [[ -n "$pr" ]] && gh pr view "$pr" --web
}

# Optional machine-specific layers. These files are intentionally untracked.
for _local_zsh in \
  "$HOME/.config/zsh/local.zsh" \
  "$HOME/.config/zsh/work.zsh" \
  "$HOME/.config/zsh/work-claude.zsh"; do
  [[ -r "$_local_zsh" ]] && source "$_local_zsh"
done

unset _brew_prefix _local_zsh _nvm_prefix
