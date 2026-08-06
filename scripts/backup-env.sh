#!/usr/bin/env bash
# Bundle the machine-local files the setup checklist's "Before leaving the
# old Mac" phase covers into a single git-ignored zip at the repo root:
#
#   ssh/                  ~/.ssh keys, config, known_hosts
#   dotfiles/             .env + rclone/rclone.conf
#   tableplus/            TablePlus connections + settings
#   openvpn/              .ovpn profiles (~/Documents + OpenVPN Connect)
#   printing/             Cura + Creality Slicer profiles (--with-printing)
#
# Alfred prefs travel via the repo, not the zip: this script re-snapshots
# ~/Dropbox/Alfred/Alfred.alfredpreferences into alfred/ for you to commit.
#
# Transfer the zip to the new Mac by AirDrop/USB (not cloud — it holds SSH
# keys and API tokens), then run scripts/restore-env.sh there.

set -e

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
ZIP="$DOTFILES/macbook-env-backup.zip"
WITH_PRINTING=false
[ "${1:-}" = "--with-printing" ] && WITH_PRINTING=true

STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT

copy_dir() { # copy_dir <label> <source dir> <stage subdir>
    if [ -d "$2" ]; then
        mkdir -p "$STAGE/$3"
        rsync -a --exclude '.DS_Store' --exclude '*.old' "$2/" "$STAGE/$3/"
        echo "  + $1"
    else
        echo "  ! skipped $1 — $2 not found"
    fi
}

copy_file() { # copy_file <label> <source file> <stage subdir>
    if [ -f "$2" ]; then
        mkdir -p "$STAGE/$3"
        cp "$2" "$STAGE/$3/"
        echo "  + $1"
    else
        echo "  ! skipped $1 — $2 not found"
    fi
}

echo "Staging backup..."
copy_dir  "SSH (~/.ssh)"  "$HOME/.ssh"                 "ssh"
copy_file ".env"          "$DOTFILES/.env"             "dotfiles"
copy_file "rclone.conf"   "$DOTFILES/rclone/rclone.conf" "dotfiles/rclone"
copy_dir  "TablePlus data" "$HOME/Library/Application Support/com.tinyapp.TablePlus/Data" "tableplus"

for ovpn in "$HOME/Documents"/*.ovpn "$HOME/Library/Application Support/OpenVPN Connect/profiles"/*.ovpn; do
    [ -f "$ovpn" ] || continue
    mkdir -p "$STAGE/openvpn"
    cp "$ovpn" "$STAGE/openvpn/"
    echo "  + openvpn: $(basename "$ovpn")"
done

if $WITH_PRINTING; then
    copy_dir "Cura profiles"            "$HOME/Library/Application Support/cura"            "printing/cura"
    copy_dir "Creality Slicer profiles" "$HOME/Library/Application Support/Creality Slicer" "printing/creality-slicer"
else
    echo "  - printing profiles not included (pass --with-printing for Cura/Creality)"
fi

if [ -f "$ZIP" ]; then
    mv "$ZIP" "$ZIP.bak"
    echo "  moved existing zip -> $(basename "$ZIP").bak"
fi
(cd "$STAGE" && zip -r -q -y "$ZIP" .)
echo "Wrote $ZIP ($(du -h "$ZIP" | cut -f1 | tr -d ' '))"

# Alfred snapshot goes into the repo, not the zip (checklist: "re-snapshot
# Alfred prefs into the repo if changed").
ALFRED_SRC="$HOME/Dropbox/Alfred/Alfred.alfredpreferences"
if [ -d "$ALFRED_SRC" ]; then
    rsync -a --delete --delete-excluded --exclude '.DS_Store' --exclude '*conflicted copy*' \
        "$ALFRED_SRC/" "$DOTFILES/alfred/Alfred.alfredpreferences/"
    if git -C "$DOTFILES" status --porcelain alfred/ | grep -q .; then
        echo "Alfred snapshot updated in alfred/ — commit and push it."
    else
        echo "Alfred snapshot unchanged."
    fi
else
    echo "! skipped Alfred snapshot — $ALFRED_SRC not found"
fi

echo
echo "Next steps:"
echo "  1. AirDrop/USB $(basename "$ZIP") to the new Mac (not cloud — it holds keys)."
echo "  2. Note your PrivateVPN login and TablePlus license key — neither is a file."
