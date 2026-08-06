#!/usr/bin/env bash
# Restore the machine-local files bundled by scripts/backup-env.sh on the
# old Mac. Expects macbook-env-backup.zip at the repo root (AirDrop/USB it
# over, then move it here).
#
# Installs: ~/.ssh (with permissions), .env, rclone/rclone.conf, TablePlus
# connections, .ovpn profiles -> ~/Documents, and Cura/Creality profiles if
# the zip has them. Importing .ovpn files into OpenVPN Connect stays manual.
#
# Nothing is deleted: an existing destination file that differs is kept
# alongside as *.pre-restore before being overwritten.

set -e

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
ZIP="$DOTFILES/macbook-env-backup.zip"

if [ ! -f "$ZIP" ]; then
    echo "No backup found at $ZIP"
    echo "Run scripts/backup-env.sh on the old Mac, AirDrop/USB the zip over,"
    echo "and move it into $DOTFILES/ before running this."
    exit 1
fi

STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT
unzip -q "$ZIP" -d "$STAGE"

install_file() { # install_file <source> <dest>
    local src="$1" dest="$2"
    if [ -f "$dest" ] && ! cmp -s "$src" "$dest"; then
        cp "$dest" "$dest.pre-restore"
        echo "  kept existing $(basename "$dest") -> $(basename "$dest").pre-restore"
    fi
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    echo "  installed $dest"
}

install_tree() { # install_tree <label> <stage subdir> <dest dir>
    if [ -d "$STAGE/$2" ]; then
        echo "$1:"
        while IFS= read -r -d '' src; do
            install_file "$src" "$3/${src#"$STAGE/$2/"}"
        done < <(find "$STAGE/$2" -type f -print0)
    else
        echo "$1: not in zip, skipped"
    fi
}

install_tree "SSH" "ssh" "$HOME/.ssh"
if [ -d "$HOME/.ssh" ]; then
    chmod 700 "$HOME/.ssh"
    find "$HOME/.ssh" -type f -exec chmod 600 {} +
    find "$HOME/.ssh" -type f -name '*.pub' -exec chmod 644 {} +
fi

if [ -f "$STAGE/dotfiles/.env" ]; then
    echo "Secrets:"
    install_file "$STAGE/dotfiles/.env" "$DOTFILES/.env"
else
    echo "Secrets: .env not in zip, skipped"
fi
[ -f "$STAGE/dotfiles/rclone/rclone.conf" ] && install_file "$STAGE/dotfiles/rclone/rclone.conf" "$DOTFILES/rclone/rclone.conf"

install_tree "TablePlus" "tableplus" "$HOME/Library/Application Support/com.tinyapp.TablePlus/Data"
install_tree "OpenVPN profiles" "openvpn" "$HOME/Documents"
install_tree "Cura profiles" "printing/cura" "$HOME/Library/Application Support/cura"
install_tree "Creality Slicer profiles" "printing/creality-slicer" "$HOME/Library/Application Support/Creality Slicer"

echo
echo "Done. Still manual:"
echo "  - Import the .ovpn files in ~/Documents into OpenVPN Connect; sign in to PrivateVPN."
echo "  - TablePlus: enter the license key (connections are already in place)."
echo "  - Delete $ZIP once everything checks out."
