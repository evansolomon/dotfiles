source "${DOTFILES}/helpers/colors" >/dev/null

dock () {
  if [ $1 ]; then
    case $1 in
      start) __dock_start                         ;;
      env)   __dock_env                           ;;
      map)   __dock_map $2                        ;;
      *)     fail "'$1' is not a valid command"   ;;
    esac
  else
    info "No command, defaulting to \`dock start\`"
    dock start
  fi
}

__dock_map () {
  if [ "" -eq "${1}" ]; then
    fail "Must provide a port to forward"
  else
    section "Setting up boot2docker port forwarding"
    info "Forwarding port ${1}"
    boot2docker ssh -N -L "${1}:localhost:${1}"
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
