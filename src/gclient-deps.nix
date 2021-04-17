{ callPackage }:
let
  sourcesFile = builtins.fromJSON (builtins.readFile ./gclient-deps.json);
  fetchcipd = callPackage ./fetchcipd.nix { };
  fetchgit = callPackage ./fetchgit.nix { };
  mkSource = inSrc:
    let
      src =
        if inSrc.type == "fetchcipd" then {
          fetcher = fetchcipd;
          args = removeAttrs inSrc [ "rev" "type" ];
        }
        else if inSrc.type == "fetchgit" then {
          fetcher = fetchgit;
          args = removeAttrs inSrc [ "type" ];
        }
        else
          abort "ERROR: gclient source ${inSrc.name} has unknown type ${builtins.toJSON inSrc.type}";
    in
    src.fetcher src.args;
in
builtins.map mkSource sourcesFile
