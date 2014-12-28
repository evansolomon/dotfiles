source "${DOTFILES}/helpers/colors" >/dev/null

dock () {
  if [ $1 ]; then
    case $1 in
      start) __dock_start                         ;;
      env)   __dock_env                           ;;
      *)     fail "'$1' is not a valid command"   ;;
    esac
  else
    info "No command, defaulting to \`dock start\`"
    dock start
  fi
}

__dock_start () {
  section "Booting Docker VM"
  boot2docker start >/dev/null 2>&1 && success "Started Docker VM"

  __dock_env
}

__dock_env () {
  section "Setting up Docker environment variables"

  FILE="/tmp/docker.env"
  info "Creating Docker environment variable file at ${FILE}"
  boot2docker shellinit >${FILE} 2>/dev/null && success "Created ${FILE}"

  info "Sourcing Docker environment variables"
  source ${FILE} && success "Sourced environment variables"

  info "Removing ${FILE}"
  rm ${FILE} && success "Removed ${FILE}"
}
