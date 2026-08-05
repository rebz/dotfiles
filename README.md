# dotfiles

Personal macOS setup. Clone on a fresh MacBook, run once, and get shell config, git config, CLI tooling, and apps installed.

## Install

```sh
git clone git@github.com:rebz/dotfiles.git ~/.dotfiles
~/.dotfiles/bootstrap
```

`bootstrap` asks for confirmation, then runs `installscript`, which:

1. Installs Xcode Command Line Tools (waits for the dialog)
2. Symlinks git config (`.gitconfig`, `.gitignore_global`)
3. Installs oh-my-zsh + zsh-autosuggestions and symlinks `.zshrc`
4. Installs Homebrew, then everything in the `Brewfile` via `brew bundle`
5. Installs the iTerm2 dynamic profile (Maple Mono NF font + current theme) and sets it as default
6. Points Alfred's preferences sync at `alfred/` (workflows, themes, ⌘Space hotkey)
7. Symlinks shared VS Code/Cursor settings from `vscode/`
8. Links `~/.config/rclone/rclone.conf` to the (gitignored) `rclone/rclone.conf` if present
9. Installs NVM + Node 24.19.0 (system default), plus npm-only CLIs (Grok Build, Ionic)

After it finishes, optionally run:

```sh
~/.dotfiles/osx/set-defaults.sh   # Finder/Dock/screenshot defaults
```

## What gets installed

Everything brew-managed is declared in the [`Brewfile`](Brewfile) — that file is the source of truth. Highlights:

**Core CLI:** bash 4+, wget, gh, git-delta, jq, tmux, yarn, pnpm, libpq (psql/pg_dump), rclone, doctl, cocoapods

**AI CLIs:** Claude Code, Codex, Gemini CLI (Nano Banana image gen lives inside Gemini), CodexBar; Grok Build via npm

**Apps (casks):** iTerm2, Docker Desktop, VS Code, Cursor, Alfred, Google Chrome, Sketch, Spotify, Flux, Tailscale, ngrok

**App Store (via `mas`):** Bear, Fantastical — requires being signed in to the App Store before running the install

**Fonts:** Maple Mono NF (terminal font, wired into the iTerm2 profile)

**Shell:** oh-my-zsh (`robbyrussell` theme), zsh-autosuggestions, zsh-nvm with `.nvmrc` auto-switching

The libpq/rclone/doctl/cocoapods/Docker picks exist to support puffrate.com's infrastructure (Docker Compose stack, DigitalOcean droplet + DOCR, Cloudflare R2 backups, `puff` CLI, iOS app).

## Repo layout

```
bootstrap              # entry point — confirm, then run installscript
installscript          # main provisioning script (brew bundle, zsh, node)
Brewfile               # declarative package list (brew bundle)
osx/set-defaults.sh    # macOS defaults (Finder, Dock, screenshots, Spotlight off ⌘Space)
iterm2/                # iTerm2 dynamic profile (Maple Mono NF + theme)
alfred/                # Alfred preferences snapshot (Alfred syncs to this dir)
vscode/                # shared settings/keybindings for VS Code AND Cursor
rclone/                # rclone.conf.example; real conf is gitignored
scripts/               # helper scripts (link-editor-settings.sh)
shell/
  .zshrc               # symlinked to ~/.zshrc
  .aliases             # git, navigation, network helpers
  .functions           # mkd, port/kport, mobile (tmux+tailscale), etc.
  .exports             # EDITOR, history, locale
  .gitconfig           # symlinked to ~/.gitconfig
  .gitignore_global    # symlinked to ~/.gitignore_global
.env.example           # template for machine-local secrets
```

## Customization & secrets

- **Machine-local shell config:** create `~/.dotfiles-custom/shell/.{exports,aliases,functions,zshrc}` — anything there is sourced by `.zshrc` but never committed.
- **Secrets:** copy `.env.example` to `.env` and fill in values. `.env` is git-ignored and sourced by `.zshrc`. Never put real values anywhere else in this repo.
- **rclone:** the real `rclone/rclone.conf` (R2 credentials) is git-ignored — carry it between machines manually like `.env`, or recreate it from `rclone/rclone.conf.example` with `rclone config`.
- **Editors:** `vscode/settings.json` + `keybindings.json` are the single source for both VS Code and Cursor (symlinked by `scripts/link-editor-settings.sh`). Extensions are per-app and not synced here.

## Notable helpers

- `mobile` — toggle remote access to this Mac from a phone (Tailscale + SSH + a `mobile` tmux session)
- `port <n>` / `kport <n>` — inspect / kill whatever is listening on a port
- `nah`, `gst`, `gl`, `stash`, `pop` — git shortcuts (see `shell/.aliases`)
- `tt "Title"` — set the terminal tab title
- `claudey` — `claude --dangerously-skip-permissions`

## Post-install checklist (new machine)

- [ ] Generate/copy SSH keys, update the `ssh-add` lines at the top of `shell/.zshrc` to match the key filenames on this machine
- [ ] `cp .env.example .env` and fill in secrets
- [ ] Copy `rclone/rclone.conf` over from the old machine (gitignored, like `.env`)
- [ ] Enter Alfred Powerpack license; confirm ⌘Space opens Alfred (logout may be needed for Spotlight to release it)
- [ ] Install editor extensions in VS Code and Cursor (settings are shared, extensions are not)
- [ ] Sign in to the App Store BEFORE running bootstrap (needed for `mas` installs: Bear, Fantastical)
- [ ] Sign in: Tailscale, Spotify, VS Code sync, Docker Desktop
- [ ] Auth the AI CLIs: `claude`, `codex`, `gemini`, `grok`
- [ ] `gh auth login` (required by `puff build`)
- [ ] rclone remote config for puffrate R2 backups (`rclone config`)
- [ ] puff CLI: `cd ~/Code/github/puffrate.com/cli && npm i && npm run build && npm link`
- [ ] iTerm2 → confirm the "Dotfiles" dynamic profile is default (Maple Mono NF)

## Credits

- Original base: https://github.com/freekmurze/dotfiles
- Ideas from: https://github.com/lukepolo/dotfiles and https://github.com/mathiasbynens/dotfiles
