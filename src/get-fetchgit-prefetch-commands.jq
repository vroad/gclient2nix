to_entries[]
| select((.key|contains(":")|not) and .value.rev)
| {key, url:.value.url, name:.key|gsub("[^\\da-zA-Z+-._?=]";"-"), rev: .value.rev}
| "DEP_PATH=\(.key) URL=\(.url) NAME=\($name_prefix + .name) REV=\(.rev) SHA256=`nix-prefetch fetchgit --url $URL --name $NAME --rev $REV` && echo \"fetchgit $DEP_PATH $NAME $URL $REV $SHA256\""
