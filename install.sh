#!/usr/bin/env bash
# install.sh — Set up dotfile symlinks from $HOME to this repo.
# Usage: ./install.sh [--force]

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
FORCE=false

if [[ "${1:-}" == "--force" ]]; then
  FORCE=true
fi

# Files/directories to symlink into $HOME
TARGETS=(
  .gitconfig
  .spacemacs
  .emacs.d
  .zprezto
  .iterm2_profile
)

link_file() {
  local src="$1"
  local dest="$2"

  if [[ -e "$dest" || -L "$dest" ]]; then
    if [[ "$FORCE" == true ]]; then
      mkdir -p "$BACKUP_DIR"
      mv "$dest" "$BACKUP_DIR/"
      echo "  Backed up existing $dest → $BACKUP_DIR/"
    else
      echo "  Skipping $dest (already exists; use --force to overwrite)"
      return
    fi
  fi

  ln -s "$src" "$dest"
  echo "  Linked $dest → $src"
}

echo "==> Installing dotfiles from $DOTFILES_DIR"
echo ""

for target in "${TARGETS[@]}"; do
  src="$DOTFILES_DIR/$target"
  dest="$HOME/$target"

  if [[ ! -e "$src" ]]; then
    echo "  Warning: $src does not exist, skipping."
    continue
  fi

  link_file "$src" "$dest"
done

echo ""
echo "==> Installing zprezto shell configuration"

ZPREZTO_RUNCOMS=(
  zlogin
  zlogout
  zpreztorc
  zprofile
  zshenv
  zshrc
)

if [[ -d "$HOME/.zprezto/runcoms" ]]; then
  for rcfile in "${ZPREZTO_RUNCOMS[@]}"; do
    src="$HOME/.zprezto/runcoms/z${rcfile#z}"
    dest="$HOME/.${rcfile}"
    # Use the prezto runcom path
    src="$HOME/.zprezto/runcoms/$rcfile"
    if [[ -e "$src" ]]; then
      link_file "$src" "$HOME/.$rcfile"
    fi
  done
else
  echo "  .zprezto not initialized — run: git submodule update --init --recursive"
fi

echo ""
echo "==> Done!"
if [[ -d "$BACKUP_DIR" ]]; then
  echo "    Backups saved to $BACKUP_DIR"
fi
