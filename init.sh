#!/bin/bash
set -e

###
# Constants
OS=$(uname)
declare -a PRGMS=("zsh" "git" "wget" "curl" "ffmpeg" "mpv" "neovim" "tmux" "tree" "yt-dlp")
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
# Install pkgs
source /etc/os-release
case $ID in
  debian|ubuntu|mint)
    PKG_MGR="sudo apt install"
    ;;

  endeavouros|arch)
    PKG_MGR="sudo pacman -Syy"
    if command -v yay 1>&2 > /dev/null; then
      PKG_MGR="yay -Syy"
    fi
    ;;

  fedora)
    PKG_MGR="sudo dnf install"
    ;;

  rhel|centos)
    PKG_MGR="sudo yum install"
    ;;

  *)
    echo "unable to find a sutible package manager... skipping"
    ;;
esac

if [[ ! -z $PKG_MGR ]]; then
  echo "${PKG_MGR} ${PRGMS[@]}"
  echo "installing packages..."
  eval "${PKG_MGR} ${PRGMS[@]}"
fi

###
# Symlink it all together ^^
for FILE in ${FILES[@]}; do
  if [ -f $HOME/.$FILE ]; then
    echo "Found .$FILE in home directory... moving to $HOME/.$FILE.backup"
    mv -v $HOME/.$FILE $HOME/.$FILE.backup
  fi
  ln -s $HOME/.dotfiles/$FILE "$HOME/.$FILE"
done;

# neovim uses non-home location
mkdir -p $HOME/.config 2>&1 > /dev/null || true
ln -s $HOME/.dotfiles/nvim "$HOME/.config/nvim"

###
# Make ZSH the default shell
if [[ $(basename $SHELL) != 'zsh' ]]; then
  sudo chsh -s $(which zsh) $USER
fi

###
# Change the default shell to ZSH
echo "BOOM! Done baby!~"
