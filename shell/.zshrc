#################################################################
### SSH Key
#################################################################

#import ssh keys in keychain
ssh-add --apple-use-keychain ~/.ssh/puffrate-droplet 2>/dev/null
ssh-add --apple-use-keychain ~/.ssh/qx-cjohnson-Bitbucket 2>/dev/null
ssh-add --apple-use-keychain ~/.ssh/rebz-GitHub 2>/dev/null


#################################################################
### ZSH Settings
#################################################################
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="spaceship" # todo - not working
# ZSH_THEME="miloshadzic" # todo - not working
ZSH_THEME="robbyrussell"

# Hide username in prompt
DEFAULT_USER=`whoami`



#################################################################
### Plugins
#################################################################

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# zsh-syntax-highlighting must stay last (its sourcing requirement)
plugins=(git zsh-nvm zsh-autosuggestions zsh-syntax-highlighting)



#################################################################
### Custom
#################################################################

# Allow to use home and end in terminal
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line

#################################################################
### Load Aliases functions exports
#################################################################

# Load the shell dotfiles, and then some:
# * ~/.extra can be used for other settings you don’t want to commit.

for file in ~/.dotfiles/shell/.{exports,aliases,functions,secrets}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done

for file in ~/.dotfiles-custom/shell/.{exports,aliases,functions,zshrc}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file



#################################################################
### PATHS
#################################################################

# Apple Silicon brew first, Intel-era /usr/local kept for the old machine
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/local/sbin:$PATH"



#################################################################
### NVM Autoloader Options
#################################################################

## You can only select one of these :-(
#export NVM_LAZY_LOAD=true
export NVM_AUTO_USE=true


#################################################################
### Load ZSH
#################################################################

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# place this after nvm initialization!
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc



# pnpm
export PNPM_HOME="/Users/cjohnson/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/cjohnson/Code/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/cjohnson/Code/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/cjohnson/Code/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/cjohnson/Code/google-cloud-sdk/completion.zsh.inc'; fi

# Created by `pipx` on 2024-11-24 22:25:06
export PATH="$PATH:$HOME/.local/bin"

# used for pg_dump, verify db script for puffrate.com
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/usr/local/opt/postgresql@17/bin:$PATH"

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

export DISABLE_AUTO_TITLE="true"
export CLAUDE_TITLE_PREFIX="🤖"

# Machine-local secrets (see .env.example)
if [ -f "$HOME/.dotfiles/.env" ]; then
  source "$HOME/.dotfiles/.env"
  export PUFFRATE_MCP_TOKEN_LOCAL
  export QX_NPM_TOKEN
fi


# ============================================================================
# CLAUDE_TERMINAL_TITLE_SETUP - Terminal Title Skill Configuration
# Added by terminal-title skill setup script
# ============================================================================

# Override macOS Terminal.app's update_terminal_cwd to preserve Claude titles
update_terminal_cwd() {
    local title_file="${HOME}/.claude/terminal_title"

    if [ -f "$title_file" ]; then
        local claude_title=$(cat "$title_file" 2>/dev/null)

        if [ -n "$claude_title" ]; then
            # Check if this shell session has already claimed a title
            if [ -n "$CLAUDE_TITLE_CLAIMED" ]; then
                # This session has claimed a title - use it indefinitely
                printf '\033]0;%s\007' "$claude_title"
                return
            else
                # New shell session - check if title is fresh (< 5 minutes)
                local current_time=$(date +%s)
                local file_time
                
                # Detect OS and use appropriate stat command
                if [[ "$OSTYPE" == "darwin"* ]]; then
                    file_time=$(stat -f %m "$title_file" 2>/dev/null)
                elif [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "linux"* ]]; then
                    file_time=$(stat -c %Y "$title_file" 2>/dev/null)
                else
                    # Fallback: use find for modification time
                    file_time=$(find "$title_file" -printf '%T@' 2>/dev/null | cut -d. -f1)
                    if [[ -z "$file_time" ]]; then
                        # Last resort: try ls -T (BSD) or ls --time-style (GNU)
                        file_time=$(ls -T "$title_file" 2>/dev/null | awk '{print $6" "$7" "$8}' | xargs -I {} date -j -f "%b %d %H:%M:%S" "{}" +%s 2>/dev/null || \
                                   ls -l --time-style=+%s "$title_file" 2>/dev/null | awk '{print $6}' 2>/dev/null)
                    fi
                fi
                
                # If we can't get file time, assume it's stale and skip
                if [[ -z "$file_time" ]] || ! [[ "$file_time" =~ ^[0-9]+$ ]]; then
                    # Fallback: show current directory
                    printf '\033]0;%s\007' "${PWD/#$HOME/~}"
                    return
                fi
                
                local age=$((current_time - file_time))

                if [ $age -lt 300 ]; then
                    # Title is fresh - claim it for this shell session
                    export CLAUDE_TITLE_CLAIMED=1
                    printf '\033]0;%s\007' "$claude_title"
                    return
                fi
            fi
        fi
    fi

    # Fallback: show current directory
    printf '\033]0;%s\007' "${PWD/#$HOME/~}"
}

# Make sure our override is called
if [[ ! "${precmd_functions[(r)update_terminal_cwd]}" == "update_terminal_cwd" ]]; then
    precmd_functions+=(update_terminal_cwd)
fi

# ============================================================================
