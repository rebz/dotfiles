#################################################################
### SSH Key
#################################################################

#import ssh keys in keychain
ssh-add -K ~/.ssh/esreborn-Bitbucket 2>/dev/null
ssh-add -K ~/.ssh/force_cjohnson-Bitbucket 2>/dev/null



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
plugins=(git zsh-nvm laravel5 composer vagrant)

#source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh



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
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
