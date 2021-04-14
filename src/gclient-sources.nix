let
  pkgs = import <nixpkgs> { };
  sourcesFile = builtins.fromJSON (builtins.readFile ./gclient-sources.json);
  mkSource = inSrc:
    let src =
      if inSrc.type == "fetchurl" then
        pkgs.fetchurl { inherit (inSrc) name url sha256; }
      else if inSrc.type == "fetchgit" then
        pkgs.fetchgit { inherit (inSrc) name url rev sha256; }
      else
        abort "ERROR: gclient source ${inSrc.name} has unknown type ${builtins.toJSON inSrc.type}";
    in
    {
      inherit src;
      path = inSrc.path;
    };
in
builtins.map mkSource sourcesFile
