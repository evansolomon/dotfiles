alias gpr="git pull --rebase"
alias gitpull="git pull && git submodule update --init --recursive && git submodule foreach git pull origin master"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset %Cblue[%an]%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)%Creset' --abbrev-commit"
