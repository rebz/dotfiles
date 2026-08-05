# Brewfile — declarative package list, installed by installscript via:
#   brew bundle --file="$HOME/.dotfiles/Brewfile"
# Refresh from a machine's actual state with: brew bundle dump --force

tap "ngrok/ngrok"
tap "steipete/tap"

#################################################################
### Core CLI
#################################################################

brew "bash"        # macOS ships 3.2; puffrate deploy.sh needs 4+
brew "mas"         # Mac App Store CLI — lets brew bundle install MAS apps
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
cask "sketch"
cask "spotify"
cask "flux-app"        # f.lux (brew renamed the old "flux" cask)
cask "tailscale-app"   # brew renamed the old "tailscale" cask
cask "ngrok"

#################################################################
### Mac App Store (requires being signed in to the App Store)
#################################################################

mas "Bear", id: 1091189122          # App Store only — no cask exists
mas "Fantastical", id: 975937182    # cask exists, but license/sub is via App Store
mas "GIPHY Capture", id: 668208984  # App Store only — no cask exists

#################################################################
### Fonts
#################################################################

cask "font-maple-mono-nf"  # terminal font (see iterm2/ profile)
