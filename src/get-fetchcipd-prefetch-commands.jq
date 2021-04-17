to_entries[]
| select(.key|contains(":"))
| {key: .key|split(":")|last|sub("\\${platform}";"linux-amd64"), rev:.value.rev, path: .key|split(":")|first}
| {key, url: "https://chrome-infra-packages.appspot.com/dl/\(.key)/+/\(.rev)", name:.key|gsub("[^\\da-zA-Z+-._?=]";"-"), path, rev}
| "DEP_PATH=\(.path) NAME=\($name_prefix + .name) URL=\(.url) REV=\(.rev) SHA256=`nix-prefetch -f $SCRIPT_DIR/fetchcipd.nix --url $URL --name $NAME --path $DEP_PATH` && echo \"fetchcipd $DEP_PATH $NAME $URL $REV $SHA256\""
