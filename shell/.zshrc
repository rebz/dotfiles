# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="spaceship"
# ZSH_THEME="miloshadzic"

# Hide username in prompt
DEFAULT_USER=`whoami`



#################################################################
### Plugins
#################################################################

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git zsh-nvm laravel5 composer vagrant)

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh



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
### SSH Key
#################################################################

#import ssh keys in keychain
ssh-add -A 2>/dev/null
ssh-add -K ~/.ssh/id_rsa 2>/dev/null



#################################################################
### PATHS
#################################################################

PATH="/usr/local/bin:$PATH"
PATH="/usr/local/sbin:$PATH"
PATH="$PATH:$HOME/.composer/vendor/bin"



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