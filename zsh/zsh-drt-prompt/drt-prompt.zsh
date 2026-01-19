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

# Days of Week Kanji
DAY_KANJI=('月' '火' '水' '木' '金' '土' '日')
KANJI_COLOR=(${BOLD_WHITE} ${BOLD_RED} ${BOLD_BLUE} ${BOLD_GREEN} ${BOLD_YELLOW} ${BOLD_CYAN} ${BOLD_MAGENTA})

# Display when connected to SSH
SSH_PROMPT_RAW="SSH:"
SSH_PROMPT="${RESET}${BOLD_WHITE}${SSH_PROMPT_RAW}${RESET}"

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
    local git_expand="$(print ${SEGMENT_SEPARATOR}${ref})"
    GIT_DISPLAY="%f%F{$color}${SEGMENT_SEPARATOR}%f%F{black}%k%K{$color}${ref}"
  fi

  ##
  # Current Dir (truncate if necessary)
  local FILLBAR=""
  local PWDLEN=""
  local SPACE=" "

  local promptsize=${#${(%):--[%n@%m]--$git_expand--}}
  if [[ -n "$SSH_CONNECTION" ]]; then
    # accounts for SSH_PROMPT
    (( promptsize = promptsize + ${#SSH_PROMPT_RAW} ))
  fi
  # local pwdsize=${#${(%):-%~---}}
  local pwdsize=$(echo -n ${${(%):-%~---}} | wc -L)

  if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
    ((PWDLEN=$TERMWIDTH - $promptsize - 4)) else
    FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize) - 1))..${SPACE}.)}"
  fi

  PDISPLAY="${(e)FILLBAR}$GIT_DISPLAY %f%F{blue}${SEGMENT_SEPARATOR}%f${BOLD_WHITE}%k%K{blue} %$PWDLEN<...<%~%<< "

  print -n "${PDISPLAY}"
}

function prompt_precmd() {
  USER_CONN="${BOLD_GREEN}%n${BOLD_WHITE}@${BOLD_GREEN}%m${BOLD_RED}"
  if [[ -n "$SSH_CONNECTION" ]]; then
    USER_CONN="${SSH_PROMPT}${USER_CONN}"
  fi
  INDEX=$(date "+%u")
  PROMPT="${BOLD_WHITE}╭─${BOLD_RED}[${USER_CONN}] ${RESET}$(prompt_build)${RESET}${BOLD_WHITE}─╮
╰─%% ${RESET}%k%f"

  RPROMPT="${WHITE}%D{%Y}年%D{%m}月%D{%d}日（$KANJI_COLOR[$INDEX]$DAY_KANJI[$INDEX]${WHITE}）${RED}%D{%T}${BOLD_WHITE} ─╯${RESET}"
}
