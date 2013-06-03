git_find_source() {
  git bisect start
  git bisect bad
  git bisect good $(git log --pretty=format:%H | tail -1) # Start from the first commit
  git bisect run $DOTFILES/ghetto/scripts/regex-does-not-exist.sh $1
  git bisect reset
}
