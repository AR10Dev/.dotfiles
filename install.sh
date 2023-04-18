#!/bin/zsh
#==============
# Variables
#==============
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

#==============
# Delete existing dot files and folders
#==============
sudo rm -rf ~/.zshrc > /dev/null 2>&1
sudo rm -rf ~/.config > /dev/null 2>&1

#==============
# Create symlinks in the home folder
#==============
ln -sf $SCRIPTPATH/zsh/zshrc ~/.zshrc
ln -sf $SCRIPTPATH/.config ~/.config

#==============
# Set zsh as the default shell
#==============
sudo chsh -s /bin/zsh
