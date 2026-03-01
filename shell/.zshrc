#################################################################
### SSH Key
#################################################################

#import ssh keys in keychain
ssh-add -K ~/.ssh/puffrate-droplet 2>/dev/null
ssh-add -K ~/.ssh/qx-cjohnson-Bitbucket 2>/dev/null
ssh-add -K ~/.ssh/rebz-GitHub 2>/dev/null


#################################################################
### NativeScript Build
#################################################################

export LANG=en_US.UTF-8
export SWIFT_VERSION=4


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
plugins=(git zsh-nvm)

# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh



#################################################################
### Custom
#################################################################

# Allow to use home and end in terminal
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/bin/brew:$PATH"
export PATH="/usr/local/Homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

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

PATH="/usr/local/bin:$PATH"
PATH="/usr/local/sbin:$PATH"
PATH="$PATH:$HOME/.composer/vendor/bin"

export ANDROID_HOME=/usr/local/share/android-sdk



#################################################################
### PHP
#################################################################

# setup xdebug
export XDEBUG_CONFIG="remote_enable=1 remote_mode=req remote_port=9001 remote_host=127.0.0.1 remote_connect_back=0"



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



#################################################################
### Qumulex
#################################################################

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/cjohnson/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/cjohnson/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/cjohnson/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/cjohnson/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<


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
export PATH="$PATH:/Users/cjohnson/.local/bin"

export PATH="/usr/local/bin/brew:$PATH"
export PATH="/usr/local/Homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# used for pg_dump, verify db script for puffrate.com
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/usr/local/opt/postgresql@17/bin:$PATH"

export QX_NPM_TOKEN="1tj0nRo6MZQ6dLP0/Qw/lqRI13Tidi2gjJ5xk3uxWHaCoaXolKElrBpEAinF9nzWE8Y7mbeCjOmIFD498Nd+dw=="
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

export DISABLE_AUTO_TITLE="true"