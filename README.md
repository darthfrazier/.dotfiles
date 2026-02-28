# dotfiles

Personal dotfiles for karlfrazier. Managed with Git and Git submodules.

## Contents

| File / Directory | Purpose |
|---|---|
| `.gitconfig` | Git user settings and aliases |
| `.spacemacs` | Spacemacs (Emacs) configuration |
| `.emacs.d/` | Spacemacs framework (submodule → [syl20bnr/spacemacs](https://github.com/syl20bnr/spacemacs)) |
| `.zprezto/` | Zsh framework (submodule → [darthfrazier/prezto](https://github.com/darthfrazier/prezto)) |
| `.iterm2_profile/` | iTerm2 terminal preferences |
| `install.sh` | Symlink setup script |

## Setup

### 1. Clone with submodules

```sh
git clone --recurse-submodules https://github.com/darthfrazier/.dotfiles.git ~/.dotfiles
```

If you already cloned without submodules:

```sh
git submodule update --init --recursive
```

### 2. Run the install script

```sh
cd ~/.dotfiles
./install.sh
```

This creates symlinks in `$HOME` pointing to the files in this repo.
Existing files are skipped by default. Use `--force` to back them up and overwrite:

```sh
./install.sh --force
```

### 3. Set Zsh as your default shell (if not already)

```sh
chsh -s /bin/zsh
```

Then start a new shell session.

## Git Aliases

| Alias | Expands to |
|---|---|
| `st` | `status` |
| `co` | `checkout` |
| `br` | `branch` |
| `lg` | `log --oneline --graph --decorate --all` |
| `last` | `log -1 HEAD` |
| `unstage` | `reset HEAD --` |
| `undo` | `reset --soft HEAD~1` |
| `aliases` | List all configured aliases |

## Spacemacs

Configuration lives in `.spacemacs`. Key settings:

- **Editing style:** Vim (Evil mode)
- **Font:** Source Code Pro 13pt
- **Enabled layers:** auto-completion, git, github, go, helm, python, javascript, markdown, yaml, sql, spell-checking
- **Clipboard:** `SPC o y` to copy, `SPC o p` to paste (system clipboard via pbcopy/pbpaste)

## Updating submodules

```sh
git submodule update --remote --merge
```

## Adding new dotfiles

1. Move the file into `~/.dotfiles/`
2. Add a symlink entry to `install.sh`
3. Commit and push
