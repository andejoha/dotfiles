#!/usr/bin/env bash
#
# Sets up this dotfiles repository on macOS: installs required tools via
# Homebrew and symlinks the tracked configuration into place.

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() {
  echo "==> $*"
}

# Installs Homebrew if it is not already available.
install_homebrew() {
  if command -v brew &>/dev/null; then
    log "Homebrew is already installed"
    return
  fi

  log "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

# Installs Oh My Zsh if it is not already available.
install_oh_my_zsh() {
  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    log "Oh My Zsh is already installed"
    return
  fi

  log "Installing Oh My Zsh"
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# Installs a Homebrew formula if it is not already installed.
brew_install() {
  local formula="$1"

  if brew list --formula "$formula" &>/dev/null; then
    log "$formula is already installed"
  else
    log "Installing $formula"
    brew install "$formula"
  fi
}

# Installs a Homebrew cask if it is not already installed.
brew_install_cask() {
  local cask="$1"

  if brew list --cask "$cask" &>/dev/null; then
    log "$cask is already installed"
  else
    log "Installing $cask"
    brew install --cask "$cask"
  fi
}

# Creates a symlink at `target` pointing to `source`. If something already
# exists at `target`, the user is asked whether to replace it.
link() {
  local source="$1"
  local target="$2"

  if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
    log "$target already links to $source"
    return
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    read -r -p "$target already exists. Overwrite it? [y/N] " reply
    if [[ ! "$reply" =~ ^[Yy]$ ]]; then
      log "Skipping $target"
      return
    fi
    rm -rf "$target"
  fi

  mkdir -p "$(dirname "$target")"
  ln -s "$source" "$target"
  log "Linked $target -> $source"
}

install_dependencies() {
  install_homebrew
  install_oh_my_zsh

  brew_install_cask wezterm
  brew_install neovim
  brew_install python
  brew_install node
  brew_install ripgrep
  brew_install powerlevel10k
  brew_install zsh-syntax-highlighting
  brew_install zsh-autosuggestions
  brew_install tree-sitter
}

setup_symlinks() {
  link "$DOTFILES_DIR/wezterm" "$HOME/.config/wezterm"
  link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
  link "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
}

main() {
  install_dependencies
  setup_symlinks
  log "Done"
  log "Open WezTerm to finalize the installation"
}

main "$@"
