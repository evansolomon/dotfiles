alias reload="source ~/.zshrc"
alias s="sparkfile --location ~/Dropbox/Sparkfile"
alias serve="python3 -m http.server 8000"
alias beam="open -a Beamer"
alias docker-compost="echo You meant docker-compose!! && echo && docker-compose"
alias ack=rg
alias lg=ligradle
alias lnkd-ssh="ssh esolomon@esolomon-ld2"

function docker-down() {
    CONTAINER_NAME="dev-container"
    docker compose -p "$CONTAINER_NAME" down
}
