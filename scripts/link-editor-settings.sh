#!/usr/bin/env bash
# Symlink VS Code and Cursor user settings to the shared copies in this repo.
# Existing real files are backed up alongside as *.bak before linking.

set -e

DOTFILES="$HOME/.dotfiles"

for app in "Code" "Cursor"; do
    user_dir="$HOME/Library/Application Support/$app/User"
    mkdir -p "$user_dir"

    for file in settings.json keybindings.json; do
        target="$user_dir/$file"
        source="$DOTFILES/vscode/$file"

        if [ -f "$target" ] && [ ! -L "$target" ]; then
            mv "$target" "$target.bak"
            echo "  backed up $app/$file -> $file.bak"
        fi

        ln -sfn "$source" "$target"
        echo "  linked $app/$file"
    done
done

echo "VS Code + Cursor now share $DOTFILES/vscode (extensions are per-app)"
