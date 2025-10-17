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

yc_db_date() {
  file_path="$(git_root_or_pwd)/ycinternal/ycinternal.dump"
  # if [ -e "$file_path" ]; then
  #   # Get modification time in seconds since Epoch
  #   modification_time=$(stat -f "%m" "$file_path")

  #   # Get current time in seconds since Epoch
  #   current_time=$(date +%s)

  #   # Calculate time difference in seconds
  #   time_diff=$((current_time - modification_time))

  #   # Calculate days since modification
  #   days_since=$((time_diff / 86400))  # 86400 seconds in a day

  #   echo " ${days_since}"
  # fi

  stat -f "%Sm" -t " [%m/%d]" "$file_path" 2>/dev/null
}

colorize_string() {
  index=$(echo "$((16#$($1 | shasum | cut -c -8))) % $COLORS_LENGTH" -n | bc)
  adjusted_index=$(echo "$index + 1" | bc)
  echo $PWD_COLORS[$adjusted_index]
}

PROMPT='[%$(colorize_string whoami)F%n%f] ' # username
PROMPT+='%$(colorize_string git_root_or_pwd)F%$((-GITSTATUS_PROMPT_LEN-1))<…<%~%<<%f'   # current working directory
# PROMPT+=$(yc_db_date) # DB date
PROMPT+='${GITSTATUS_PROMPT:+ $GITSTATUS_PROMPT}'      # git status
PROMPT+=$'\n'                                          # new line
PROMPT+='%F{%(?.76.196)}$%f '                          # $; green/red (ok/error)
