# http://evansolomon.me/notes/bash-helper-check-how-much-code-youre-adding-removing/

redgreen() {
  ack "^[-|\+]" -oh | sort | uniq -c | ack "[0-9]+" -oh | xargs | awk '{print $1 - $2}'
}

red() {
  ack "^-" -oh | wc -l | xargs
}

green() {
  ack "^\+" -oh | wc -l | xargs
}
