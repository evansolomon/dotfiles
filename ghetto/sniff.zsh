# Sniff network traffic.
# https://twitter.com/rem/statuses/263585276075593728

sniff() {
  sudo ngrep -W byline -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'
}
