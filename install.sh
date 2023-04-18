#!/bin/zsh
#===============================================================================
#
#             NOTES: For this to work you must have cloned the github
#                    repo to your home folder as ~/.dotfiles/
#
#===============================================================================

#==============
# Variables
#==============
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

#==============
# Delete existing dot files and folders
#==============
rm -rf ~/.zshrc > /dev/null 2>&1
rm -rf ~/.config > /dev/null 2>&1

#==============
# Create symlinks in the home folder
#==============
ln -sf $SCRIPTPATH/zsh/zshrc ~/.zshrc
ln -sf $SCRIPTPATH/.config ~/.config

#==============
# Set zsh as the default shell
#==============
chsh -s /bin/zsh