# Based on https://github.com/NixOS/nixpkgs/blob/a03f318104db1a74791746595829de4c2d53e658/pkgs/build-support/fetchgit/default.nix

{ fetchgit }:

{ name, url, path, ... } @ inArgs:
let
  dirName = name + "-" + (baseNameOf url);
  args = (removeAttrs inArgs [ "path" ]) // {
    fetchSubmodules = false;
  };
in
if path == "." then
  fetchgit args
else
  (fetchgit args).overrideAttrs (x: {
    postFetch =
      ''
        WORK_DIR="$TMPDIR/${dirName}"
        mkdir -p "$WORK_DIR"
        find "$out" -mindepth 1 -maxdepth 1 -exec mv {} "$WORK_DIR" \;

        DEP_PATH="$out/${path}"
        mkdir -p "$(dirname "$DEP_PATH")"
        mv "$WORK_DIR" "$DEP_PATH"
      '';
  })
