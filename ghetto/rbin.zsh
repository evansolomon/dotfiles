function rbin {
 http post requestb.in/api/v1/bins | \
   jq .name | \
   xargs -I {} echo "http://requestb.in/{}?inspect" | \
   xargs open
}
