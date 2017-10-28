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
else
  alias ls='ls --color=auto'
fi

alias grep='grep --color=auto'
alias ll='ls -l'

###########
# Exports #
export LC_ALL=en_US.utf-8
export LANG="$LC_ALL"

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

##########
# Prompt #
PROMPT="${BOLD_RED}[${BOLD_GREEN}%n@%M${RESET}:${BOLD_CYAN}%~${BOLD_RED}]${RESET}
> "
