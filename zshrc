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

# coreutils
alias grep='grep --color'
alias ls='ls --color -N'
alias ll='ls -l'
alias lls='ls -lah'
alias less='less -r'
alias df='df -h'
alias du='du -h'
alias dus='du -hs'

# git
alias gl='git log --branches --remotes --oneline --graph --decorate'
alias glw='git log --branches --remotes --oneline --graph --decorate --after $(date -v-7d +%Y-%m-%d)'
alias gd='git diff --color=always'
alias gc='git commit'
alias gs='git status'
alias ga='git add'

# macOS-like
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias open='xdg-open'

# networking help (cyber plumber)
alias psg='ps -ef | grep -i $1'
alias ssg='ss -natp | grep -i $1'

##################
# Docker Aliases #
alias fdroid='docker run --rm -u $(id -u):$(id -g) -v $(pwd):/repo registry.gitlab.com/fdroid/docker-executable-fdroidserver:latest'

###########
# Exports #
export LC_ALL=en_US.UTF-8
export LANG="$LC_ALL"

export GOPATH=$HOME/p/go
export GOBIN=$GOPATH/bin

export PATH=$GOBIN:$PATH
export PATH=$HOME/p/scripts:$PATH

export EDITOR=vim

export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/drt/.local/share/flatpak/exports/share

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

###########
# Plugins #
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
# zsh-history-substring-search fix
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
# zsh-completions
fpath=($HOME/.zsh/zsh-completions $fpath)
fpath=($fpath $HOME/.zsh/func)
typeset -U fpath

##########
# Prompt #
source $HOME/.zsh/zsh-drt-prompt/drt-prompt.zsh
