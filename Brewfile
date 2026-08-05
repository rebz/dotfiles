# Brewfile — declarative package list, installed by installscript via:
#   brew bundle --file="$HOME/.dotfiles/Brewfile"
# Refresh from a machine's actual state with: brew bundle dump --force

tap "ngrok/ngrok"
tap "steipete/tap"

#################################################################
### Core CLI
#################################################################

brew "bash"        # macOS ships 3.2; puffrate deploy.sh needs 4+
brew "wget"
brew "gh"          # GitHub CLI (required by `puff build`)
brew "git-delta"   # better git diffs
brew "jq"
brew "tmux"        # used by `mobile` function
brew "yarn"
brew "pnpm"
brew "libpq"       # psql/pg_dump/pg_restore (puffrate db + backup scripts)
brew "rclone"      # Cloudflare R2 backups (puffrate verify-backup.sh)
brew "doctl"       # DigitalOcean registry/droplet ops
brew "cocoapods"   # puffrate native/ iOS builds

#################################################################
### AI / Agentic CLIs
#################################################################

brew "codex"        # OpenAI Codex CLI
brew "gemini-cli"   # Google Gemini (incl. Nano Banana image gen)
cask "claude-code"  # Claude Code
cask "codexbar"     # menu-bar agent usage monitor (M-series only)
# Grok Build has no brew package — installed via npm in installscript

#################################################################
### Apps
#################################################################

cask "iterm2"
cask "docker-desktop"  # puffrate is compose-based (swap for orbstack if preferred)
cask "visual-studio-code"
cask "cursor"
cask "alfred"          # prefs restored from alfred/ (see installscript)
cask "google-chrome"
cask "sourcetree"
cask "sketch"
cask "spotify"
cask "flux"
cask "tailscale-app"   # brew renamed the old "tailscale" cask
cask "ngrok"

#################################################################
### Fonts
#################################################################

cask "font-maple-mono-nf"  # terminal font (see iterm2/ profile)
