###############
# Local Stuff #
local OS=$(uname)

###########
# History #
HISTFILE=$HOME/.histfile
HISTSIZE=2000
SAVEHIST=2000

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
  alias ls='ls --color'
fi

alias grep='grep --color'
alias ll='ls -l'
alias lls='ls -lah'
alias less='less -r'

alias df='df -h'
alias du='du -u'
alias dus='du -us'

alias gl='git log --branches --remotes --oneline --graph --decorate'
alias gd='git diff --color=always'
alias gc='git commit'
alias gs='git status'
alias ga='git add'

###########
# Exports #
export LC_ALL=en_US.UTF-8
export LANG="$LC_ALL"

export GOPATH=$HOME/p/go
export GOBIN=$GOPATH/bin

export PATH=$PATH:$GOBIN
export PATH=$PATH:$HOME/p/scripts

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
    apt-get update && apt-get upgrade
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


##########
# Prompt #
PROMPT="╭─${BOLD_RED}[${BOLD_GREEN}%n@%M${RESET}:${BOLD_CYAN}%~${BOLD_RED}]${RESET}
╰─> "
# RPROMPT="%~"
#

source $HOME/.zsh/zsh-drt-prompt/drt-prompt.zsh
