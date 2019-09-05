#!/bin/bash

set -e

###
# Constants
OS=$(uname)
declare -a PRGMS=("zsh" "git" "wget" "curl" "ffmpeg" "mplayer" "nvim" "tmux" "tree" "youtube-dl" "pandoc" "pandoc-citeproc")
declare -a DIRS=("p/go/{src,pkg,bin}")
declare -a FILES=("tmux.conf" "vim" "vimrc" "zsh" "zshrc")


###
# Download and install brew if not already installed
if [ $OS == 'Darwin' ] && ! [ $(which brew) ]; then
  echo "brew not installed!"
  echo "installing brew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


###
# Directory Setup
echo -n "making directories..."
for DIR in ${DIRS[@]}; do
  if [ ! -d $HOME/$DIR ]; then
    mkdir -p $HOME/$DIR
    echo -n " $DIR"
  fi
done
echo


###
# Install apps
echo "update base system..."
if [ $OS == 'Darwin' ]; then
  brew update && brew upgrade
  brew install ${PRGMS[@]}
else
  sudo apt-get update && sudo apt-get -y upgrade
  sudo apt-get -y install ${PRGMS[@]}
fi


###
# Grab all git repos
echo "init and update git submodules..."
if [ ! -d $HOME/.dotfiles  ]; then
  git clone git@github.com:funayman/.dotfiles $HOME/.dotfiles
fi
cd $HOME/.dotfiles
git submodule init && git submodule update

###
# Symlink it all together ^^
for FILE in ${FILES[@]}; do
  if [ -f $HOME/$FILE ]; then
    echo "Found $FILE in home directory... moving to $HOME/$FILE.backup"
    mv $HOME/$FILE $HOME/$FILE.backup
  fi
  ln -s $HOME/.dotfiles/$FILE "$HOME/.$FILE"
done;


###
# Change the default shell to ZSH

echo "BOOM! Done baby!~"
