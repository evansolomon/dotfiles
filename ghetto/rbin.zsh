function rbin {
  # Create bin and parse its name
  name="$(http post requestb.in/api/v1/bins | jq --raw-output .name)"

  # Form a URL
  url="http://requestb.in/${name}?inspect"

  # Copy the URL
  echo "${url}" | pbcopy

  # Open the URL in a browser
  open "${url}"

  # Print the URL to stdout
  echo "${url}"
}
