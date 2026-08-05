# dotfiles

Personal macOS setup. Clone on a fresh MacBook, run once, and get shell config, git config, CLI tooling, and apps installed.

## Install

```sh
git clone git@github.com:rebz/dotfiles.git ~/.dotfiles
~/.dotfiles/bootstrap
```

`bootstrap` asks for confirmation, then runs `installscript`, which:

1. Applies a handful of macOS defaults (Finder, Dock, screenshots)
2. Installs Xcode Command Line Tools
3. Symlinks git config (`.gitconfig`, `.gitignore_global`)
4. Installs oh-my-zsh + zsh-autosuggestions and symlinks `.zshrc`
5. Installs Homebrew, then CLI tools and apps (see below)
6. Installs NVM + Node

After it finishes, optionally run:

```sh
~/.dotfiles/osx/set-defaults.sh   # power/hibernation defaults (sudo)
```

## What gets installed

**CLI:** wget, dos2unix, yarn, tmux, ngrok, nvm (+ zsh-nvm plugin)

**Apps (casks):** iTerm2, VS Code, Sourcetree, Sketch, Spotify, Flux, Tailscale

**Fonts:** Fira Code (terminal); Ubuntu Mono Powerline variants live in `fonts/`

**Shell:** oh-my-zsh (`robbyrussell` theme), zsh-autosuggestions, zsh-nvm with `.nvmrc` auto-switching

## Repo layout

```
bootstrap              # entry point — confirm, then run installscript
installscript          # main provisioning script (brew, zsh, node, apps)
osx/set-defaults.sh    # extra macOS defaults (pmset/hibernation)
shell/
  .zshrc               # symlinked to ~/.zshrc
  .aliases             # git, navigation, network helpers
  .functions           # mkd, port/kport, mobile (tmux+tailscale), etc.
  .exports             # EDITOR, history, locale
  .gitconfig           # symlinked to ~/.gitconfig
  .gitignore_global    # symlinked to ~/.gitignore_global
fonts/                 # Ubuntu Mono Powerline fonts
.env.example           # template for machine-local secrets
```

## Customization & secrets

- **Machine-local shell config:** create `~/.dotfiles-custom/shell/.{exports,aliases,functions,zshrc}` — anything there is sourced by `.zshrc` but never committed.
- **Secrets:** copy `.env.example` to `.env` and fill in values. `.env` is git-ignored and sourced by `.zshrc`. Never put real values anywhere else in this repo.

## Notable helpers

- `mobile` — toggle remote access to this Mac from a phone (Tailscale + SSH + a `mobile` tmux session)
- `port <n>` / `kport <n>` — inspect / kill whatever is listening on a port
- `nah`, `gst`, `gl`, `stash`, `pop` — git shortcuts (see `shell/.aliases`)
- `tt "Title"` — set the terminal tab title
- `claudey` — `claude --dangerously-skip-permissions`

## Post-install checklist (new machine)

- [ ] Generate/copy SSH keys, update the `ssh-add` lines at the top of `shell/.zshrc` to match the key filenames on this machine
- [ ] `cp .env.example .env` and fill in secrets
- [ ] Sign in: Tailscale, Spotify, Sourcetree, VS Code sync
- [ ] `nvm install --lts` and `nvm alias default` the version you want
- [ ] Set iTerm2 font to Fira Code

## Credits

- Original base: https://github.com/freekmurze/dotfiles
- Ideas from: https://github.com/lukepolo/dotfiles and https://github.com/mathiasbynens/dotfiles
