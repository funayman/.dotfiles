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

  local PDISPLAY=''
  ##
  # Git Stuff
  is_dirty() {
    test -n "$(git status --porcelain --ignore-submodules)"
  }

  ref="$vcs_info_msg_0_"
  if [[ -n "$ref" ]]; then
    if is_dirty; then
      color=yellow
      ref="${ref} $PLUSMINUS"
    else
      color=green
      ref="${ref} "
    fi
    if [[ "${ref/.../}" == "$ref" ]]; then
      ref="$BRANCH $ref"
    else
      ref="$DETACHED ${ref/.../}"
    fi
    PDISPLAY="$PDISPLAY $SEGMENT_SEPARATOR ${ref}"
  fi

  ##
  # Current Dir (truncate if necessary)
  PDISPLAY="$PDISPLAY $SEGMENT_SEPARATOR %~ "

  print -n "${PDISPLAY}"
}

function prompt_precmd() {
PROMPT="╭─${BOLD_RED}[${BOLD_GREEN}%n${BOLD_WHITE}@${BOLD_GREEN}%m${BOLD_RED}] ${BOLD_CYAN}$(prompt_build)${BOLD_WHITE}
╰─>${RESET} "
}
