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

backup_path "$HOME/.config/waybar/config.jsonc"
backup_path "$HOME/.config/waybar/style.css"

cp -a "$repo_dir/waybar-theme/config.jsonc" "$HOME/.config/waybar/config.jsonc"
cp -a "$repo_dir/waybar-theme/style.css" "$HOME/.config/waybar/style.css"

if [[ -d $repo_dir/waybar-theme/scripts ]]; then
  cp -a "$repo_dir/waybar-theme/scripts/." "$HOME/.config/waybar/scripts/"
  chmod +x "$HOME/.config/waybar/scripts/"* 2>/dev/null || true
fi

cp -a "$repo_dir/starship.toml" "$HOME/.config/starship.toml"

if command -v omarchy >/dev/null 2>&1; then
  omarchy restart waybar
elif command -v omarchy-restart-waybar >/dev/null 2>&1; then
  omarchy-restart-waybar
fi

printf 'Kostox Waybar and Starship extras installed. Backups use suffix .bak.%s\n' "$timestamp"
