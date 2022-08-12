###############
# Local Stuff #
local OS=$(uname)

###########
# History #
HISTFILE=$HOME/.histfile
HISTSIZE=20000
SAVEHIST=20000

############
# Autoload #
autoload -U compinit && compinit
autoload colors && colors

###############
# ZSH Options #
setopt SHORT_LOOPS  # short forms of for, repeat, select, if, and function constructs
setopt CORRECT      # try to correct the spelling of commands
unsetopt BEEP       # get rid of that annoying sound

############
# Bindings #
bindkey -v

###########
# Aliases #
if [[ $OS == 'Darwin' ]]; then
  alias ls='ls -G'
  alias vlc='/Volumes/Macintosh\ HD/Applications/VLC.app/Contents/MacOS/VLC --extraintf=http:logger --verbose=2 --file-logging --logfile=vlc-log.txt'
else
  alias ls='ls --color -N'
fi

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

alias grep='grep --color'
alias ll='ls -l'
alias lls='ls -lah'
alias less='less -r'

alias df='df -h'

alias gl='git log --branches --remotes --oneline --graph --decorate'
alias glw='git log --branches --remotes --oneline --graph --decorate --after $(date -v-7d +%Y-%m-%d)'
alias gd='git diff --color=always'
alias gc='git commit'
alias gs='git status'
alias ga='git add'

##################
# Docker Aliases #
alias fdroid='docker run --rm -u $(id -u):$(id -g) -v $(pwd):/repo registry.gitlab.com/fdroid/docker-executable-fdroidserver:latest'

###########
# Exports #
export LC_ALL=en_US.UTF-8
export LANG="$LC_ALL"

export GOHOME=/usr/lib/go-1.18
export GOPATH=$HOME/p/go
export GOBIN=$GOPATH/bin

export PATH=/opt/firefox:$PATH
export PATH=$PATH:$GOBIN:$GOHOME/bin
export PATH=$PATH:$HOME/p/scripts
export PATH=$PATH:$HOME/.npm/packages/bin

if [[ $OS == 'Darwin' ]]; then
  # export PATH=$PATH:$HOME/Library/Python/2.7/bin
fi

##########
# Colors #
# https://stackoverflow.com/a/6159885
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
    eval $COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
    eval BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done
eval RESET='%{$reset_color%}'

#############
# Functions #
function update {
  if [[ $OS == 'Darwin' ]]; then
    brew update && brew upgrade
  else
    sudo apt-get update && sudo apt-get upgrade
  fi
}

###########
# Plugins #
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
  # zsh-history-substring-search fix
  if [[ `uname` == 'Darwin' ]]; then
     bindkey '^[[A' history-substring-search-up
     bindkey '^[[B' history-substring-search-down
  else
     bindkey "$terminfo[kcuu1]" history-substring-search-up
     bindkey "$terminfo[kcud1]" history-substring-search-down
  fi
# zsh-completions
fpath=($HOME/.zsh/zsh-completions $fpath)
fpath=($fpath $HOME/.zsh/func)
typeset -U fpath

# kubernetes autocomplete
[[ /usr/bin/kubectl ]] && source <(kubectl completion zsh)

##########
# Prompt #
source $HOME/.zsh/zsh-drt-prompt/drt-prompt.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
