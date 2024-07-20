#!/usr/bin/env bash

read -r -p "This script will install/update Homebrew and some nessecary applications to your system. Do you wish to continue? [y/N] " response
response=${response,,}
if [[ ! $REPLY =~ ^[Yy]$ ]] then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

# check if brew is installed and install if not, otherwise make sure it is up to date
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    . <"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    brew update
fi

brew install gum

gum confirm "Would you like to setup developer tools?" &&  ./dev.sh

gum confirm "Will this system be used for gaming?" && ./gaming.sh

