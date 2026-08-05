# Dotfiles repo

Personal macOS dotfiles. Cloned to `~/.dotfiles` on a new Mac and run **once** via `./bootstrap` → `installscript`. Files in `shell/` are symlinked into `$HOME`, so edits here take effect on the live machine immediately — treat every change as live config, not just repo code.

## Layout

- `bootstrap` — entry point; confirms, then sources `installscript`
- `installscript` — one-shot provisioning: macOS defaults, Xcode CLT, git symlinks, oh-my-zsh, Homebrew, brew packages/casks, NVM
- `osx/set-defaults.sh` — extra `pmset` defaults, run manually
- `shell/.zshrc`, `.aliases`, `.functions`, `.exports` — sourced in that order by `.zshrc`; `.zshrc`, `.gitconfig`, `.gitignore_global` are symlinked to `$HOME`
- `.env` (git-ignored, from `.env.example`) — machine-local secrets, sourced by `.zshrc`
- `~/.dotfiles-custom/shell/` — optional uncommitted per-machine overrides, sourced last

## Hard rules

- **Never commit secrets.** Tokens/keys go in `.env` only (see `.env.example`). If you find a hardcoded credential in any shell file, flag it — don't copy the pattern.
- **Never run `bootstrap`/`installscript` on this machine** — they are for fresh Macs and contain destructive steps (`rm -rf ~/.oh-my-zsh`, `sudo rm -rf /usr/local/Cellar`, deleting `~/.zshrc`). Suggest changes; let the human run scripts.
- Target is Apple Silicon: Homebrew lives at `/opt/homebrew`. Don't add new `/usr/local` paths.

## Conventions

- zsh syntax in `shell/*` (sourced by `.zshrc`), bash for standalone scripts (`bootstrap`, `installscript`)
- Aliases in `.aliases`, functions in `.functions`, env vars in `.exports` — keep each in its lane
- Section headers use the `####### / ### Title / #######` banner style — match it
- Old tool configs (PHP/Valet/Homestead) are kept as commented-out blocks rather than deleted; fine to remove when asked to clean up

## Gotchas

- `.gitattributes` line 2 (`whitespace = cr-at-eol`) is invalid and prints a warning on every git command
- `installscript` mixes concerns (defaults + installs) and has known bugs (wrong `core.excludesfile` filename, placeholder git email, Intel-era paths); README's "known issues" and git history have context
- `.zshrc` has accumulated machine-specific blocks at the bottom (pnpm, gcloud, postgres paths) — expect drift between repo and reality
