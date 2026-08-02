#!/usr/bin/env bash
# Bash port of install.py. Symlinks dotfiles into $HOME.
set -euo pipefail
shopt -s nullglob dotglob

excludes=(
  "readme.md"
  "install.py"
  "install.sh"
  ".git"
  ".gitignore"
  ".gitmodules"
  "sublime"
  "zsh"
  "vscode"
  "Brewfile"
  "CLAUDE.md"
  "agent"
)

# container directory. don't symlink directly, symlink the contents instead
containers=(".config")

pwd_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
home_dir="$HOME"

is_in() {
  local needle="$1"; shift
  local item
  for item in "$@"; do
    [[ "$item" == "$needle" ]] && return 0
  done
  return 1
}

iterate_and_install() {
  local directory="$1"
  local target_dir="$2"
  local path f destination

  for path in "$directory"/*; do
    f="$(basename "$path")"
    is_in "$f" "${excludes[@]}" && continue

    if [[ -d "$path" && ! -L "$path" ]] && is_in "$f" "${containers[@]}"; then
      mkdir -p "$target_dir/$f"
      iterate_and_install "$path" "$target_dir/$f"
    else
      destination="$target_dir/$f"
      if [[ -e "$destination" || -L "$destination" ]]; then
        echo "${destination} exists. skipping ${f}"
      else
        echo "linking ${f} to ${destination}"
        ln -s "$path" "$destination"
      fi
    fi
  done
}

install_sublime() {
  local source="$1"
  local target="$2"

  [[ -L "$target" ]] && return

  if [[ -d "$target" ]]; then
    rm -rf "$target"
  fi

  mkdir -p "$(dirname "$target")"
  ln -s "$source" "$target"
}

install_vscode() {
  local source="$1"
  local target="$2"
  local path f destination

  mkdir -p "$target"

  for path in "$source"/*; do
    f="$(basename "$path")"
    destination="$target/$f"

    if [[ -e "$destination" && ! -L "$destination" ]]; then
      rm -f "$destination"
    fi
    ln -sf "$path" "$destination"
  done
}

iterate_and_install "$pwd_dir" "$home_dir"

install_sublime \
  "$pwd_dir/sublime/User" \
  "$home_dir/Library/Application Support/Sublime Text/Packages/User"

install_vscode \
  "$pwd_dir/vscode" \
  "$home_dir/Library/Application Support/Code/User"
