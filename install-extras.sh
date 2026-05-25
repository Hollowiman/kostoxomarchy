#!/bin/bash

set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
timestamp=$(date +%s)

backup_path() {
  local path=$1

  if [[ -e $path || -L $path ]]; then
    mv "$path" "$path.bak.$timestamp"
  fi
}

mkdir -p "$HOME/.config/waybar" "$HOME/.config/waybar/scripts"
mkdir -p "$HOME/.config/omarchy/branding"

backup_path "$HOME/.config/waybar/config.jsonc"
backup_path "$HOME/.config/waybar/style.css"

cp -a "$repo_dir/waybar-theme/config.jsonc" "$HOME/.config/waybar/config.jsonc"
cp -a "$repo_dir/waybar-theme/style.css" "$HOME/.config/waybar/style.css"

if [[ -d $repo_dir/waybar-theme/scripts ]]; then
  cp -a "$repo_dir/waybar-theme/scripts/." "$HOME/.config/waybar/scripts/"
  chmod +x "$HOME/.config/waybar/scripts/"* 2>/dev/null || true
fi

cp -a "$repo_dir/starship.toml" "$HOME/.config/starship.toml"

backup_path "$HOME/.config/omarchy/branding/screensaver.txt"
backup_path "$HOME/.config/omarchy/branding/about.txt"
cp -a "$repo_dir/branding/screensaver.txt" "$HOME/.config/omarchy/branding/screensaver.txt"
cp -a "$repo_dir/branding/about.txt" "$HOME/.config/omarchy/branding/about.txt"

if command -v omarchy >/dev/null 2>&1; then
  bg=$(awk -F'"' '/^background/{print $2}' "$repo_dir/colors.toml")
  text=$(awk -F'"' '/^foreground/{print $2}' "$repo_dir/colors.toml")
  if [[ -n $bg && -n $text && -f $repo_dir/logo.png ]]; then
    omarchy plymouth set "$bg" "$text" "$repo_dir/logo.png"
  fi
elif command -v omarchy-plymouth-set >/dev/null 2>&1; then
  bg=$(awk -F'"' '/^background/{print $2}' "$repo_dir/colors.toml")
  text=$(awk -F'"' '/^foreground/{print $2}' "$repo_dir/colors.toml")
  if [[ -n $bg && -n $text && -f $repo_dir/logo.png ]]; then
    omarchy-plymouth-set "$bg" "$text" "$repo_dir/logo.png"
  fi
fi

if command -v omarchy >/dev/null 2>&1; then
  omarchy restart waybar
elif command -v omarchy-restart-waybar >/dev/null 2>&1; then
  omarchy-restart-waybar
fi

printf 'Kostox Waybar, Starship, branding, login, and boot extras installed. Backups use suffix .bak.%s\n' "$timestamp"
