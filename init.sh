#!/bin/bash
set -e

###
# Constants
OS=$(uname)
declare -a PRGMS=("zsh" "git" "wget" "curl" "ffmpeg" "mplayer" "vim" "tmux" "tree" "youtube-dl")
declare -a DIRS=("p/go/{src,pkg,bin}" "p/scripts")
declare -a FILES=("tmux.conf" "vim" "vimrc" "zsh" "zshrc")

###
# Directory Setup
echo -n "making directories..."
for DIR in ${DIRS[@]}; do
  eval mkdir -p $HOME/$DIR
  echo -n " $DIR"
done
echo

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
  if [ -f $HOME/.$FILE ]; then
    echo "Found .$FILE in home directory... moving to $HOME/.$FILE.backup"
    mv -v $HOME/.$FILE $HOME/.$FILE.backup
  fi
  ln -s $HOME/.dotfiles/$FILE "$HOME/.$FILE"
done
# Link Config dirs
for C_DIR in $(ls -d $HOME/.dotfiles/config/*/); do
  F_DIR = ${C_DIR%/}
  B_DIR = $(basename $(dirname "${C_DIR}"))
  ln -s "${F_DIR}" "${HOME}/.config/${B_DIR}"
done
# Add Fonts
ln -s $HOME/.dotfiles/.fonts $HOME/.fonts

###
# Make ZSH the default shell
if [[ $(basename $SHELL) != 'zsh' ]]; then
  sudo chsh -s $(command -V zsh) $USER
fi

###
# Change the default shell to ZSH
echo "BOOM! Done baby!~"
