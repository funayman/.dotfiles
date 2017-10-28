#!/bin/bash

###
# Constants
OS=$(uname) 
declare -a PRGMS=("zsh" "git" "wget" "curl" "ffmpeg" "mplayer" "vim" "tmux" "tree")
declare -a DIRS=(".vimundo" "p/go")
declare -a FILES=(".tmux.conf" ".vim" ".vimrc" ".zsh" ".zshrc")


###
# Download and install brew if not already installed
if [ $OS == 'Darwin' ] && ! [ $(which brew) ]; then
  echo "brew not installed!"
  echo "installing brew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


###
# Directory Setup
for DIR in ${DIRS[@]}; do
  if [ ! -d $HOME/$DIR ]; then
    mkdir -p $HOME/$DIR
  fi
done


###
# Install apps
if [ $OS == 'Darwin' ]; then
  brew update && brew upgrade
  brew install ${PRGMS[@]}
else
  apt-get update && apt-get -y upgrade
  apt-get -y install ${PRGMS[@]}
fi


###
# Grab all git repos
git clone git@github.com:funayman/dotfiles $HOME/.dotfiles

###
# Symlink it all together ^^
for FILE in ${FILES[@]}; do
  ln -s $HOME/.dotfiles/$FILE $HOME/$FILE
done;


###
# Change the default shell to ZSH


echo "BOOM! Done baby!~"
