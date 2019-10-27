#!/usr/bin/env zsh

source $DOTFILES/ignored-repos/gitstatus/gitstatus.prompt.zsh

PWD_COLORS=(
  39 # Blue
  63 # Purple
  117 # Light blue
  127 # Magenta
  148 # Yellow
  169 # Pink
  184 # Yellow
  214 # Orange
  231 # White
)
COLORS_LENGTH=$#PWD_COLORS

git_root_or_pwd() {
  echo $(git rev-parse --show-toplevel 2>/dev/null || pwd)
}

colorize_string() {
  index=$(echo "$((16#$($1 | shasum | cut -c -8))) % $COLORS_LENGTH" -n | bc)
  adjusted_index=$(echo "$index + 1" | bc)
  echo $PWD_COLORS[$adjusted_index]
}

PROMPT='[%$(colorize_string hostname)F%m%f] ' # hostname
PROMPT+='%$(colorize_string git_root_or_pwd)F%$((-GITSTATUS_PROMPT_LEN-1))<…<%~%<<%f'   # current working directory
PROMPT+='${GITSTATUS_PROMPT:+ $GITSTATUS_PROMPT}'      # git status
PROMPT+=$'\n'                                          # new line
PROMPT+='%F{%(?.76.196)}$%f '                          # $; green/red (ok/error)
