# cat foo.md | ghmd > foo.html

ghmd() {
  local HTML

  HTML=$(</dev/stdin)
  echo "<html><head><link type='text/css' rel='stylesheet' href='https://gist.github.com/andyferra/2554919/raw/2e66cabdafe1c9a7f354aa2ebf5bc38265e638e5/github.css'></head><body>$HTML</body></html>"
}
