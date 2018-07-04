# Load required functions.
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes false
zstyle ':vcs_info:git*' formats '%b'
zstyle ':vcs_info:git*' actionformats '%b (%a)'

add-zsh-hook precmd prompt_precmd

# Characters
SEGMENT_SEPARATOR="\ue0b2"
PLUSMINUS="\u00b1"
BRANCH="\ue0a0"
DETACHED="\u27a6"
CROSS="\u2718"
LIGHTNING="\u26a1"
GEAR="\u2699"

prompt_build() {
  vcs_info
  local TERMWIDTH
  (( TERMWIDTH = ${COLUMNS} - 1 ))

  local GIT_DISPLAY
  ##
  # Git Stuff
  is_dirty() {
    test -n "$(git status --porcelain --ignore-submodules)"
  }

  ref="$vcs_info_msg_0_"
  if [[ -n "$ref" ]]; then
    if is_dirty; then
      color=yellow
      ref="$PLUSMINUS ${ref}"
    else
      color=green
      ref=" ${ref}"
    fi
    if [[ "${ref/.../}" == "$ref" ]]; then
      ref="$ref $BRANCH"
    else
      ref="${ref/.../} $DETACHED"
    fi
    local git_expand="$(print $SEGMENT_SEPARATOR${ref})"
    GIT_DISPLAY="%f%F{$color}$SEGMENT_SEPARATOR%f%F{black}%k%K{$color}${ref}"
  fi

  ##
  # Current Dir (truncate if necessary)
  local FILLBAR=""
  local PWDLEN=""
  local SPACE=" "

  local promptsize=${#${(%):--[%n@%m]--$git_expand--}}
  local pwdsize=${#${(%):-%~---}}

  if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
    ((PWDLEN=$TERMWIDTH - $promptsize - 4)) else
    FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize) - 1))..${SPACE}.)}"
  fi

  PDISPLAY="${(e)FILLBAR}$GIT_DISPLAY %f%F{blue}$SEGMENT_SEPARATOR%f${BOLD_WHITE}%k%K{blue} %$PWDLEN<...<%~%<< "

  print -n "${PDISPLAY}"
}

function prompt_precmd() {
PROMPT="${BOLD_WHITE}╭─${BOLD_RED}[${BOLD_GREEN}%n${BOLD_WHITE}@${BOLD_GREEN}%m${BOLD_RED}] ${RESET}$(prompt_build)${RESET}${BOLD_WHITE}─╮
╰─>${RESET}%k%f"
RPROMPT="${BOLD_WHITE}%D{%a,%b%d} @ %D{%H:%m} ─╯"
}
