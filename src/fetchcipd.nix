# Based on https://github.com/NixOS/nixpkgs/blob/a03f318104db1a74791746595829de4c2d53e658/pkgs/build-support/fetchzip/default.nix

{ fetchzip }:

{ name, url, path, ... } @ inArgs:
let
  fileName = name + "-" + (baseNameOf url);
  args = removeAttrs inArgs [ "path" ];
in
(fetchzip args).overrideAttrs (x: {
  postFetch =
    ''
      unpackDir="$TMPDIR/unpack"
      mkdir "$unpackDir"
      cd "$unpackDir"

      renamed="$TMPDIR/${fileName}"
      mv "$downloadedFile" "$renamed"
      unzip "$renamed" -x '.cipdpkg/*'
      mkdir -p "$(dirname "$out/${path}")"
      mv "$unpackDir" "$out/${path}"
      chmod 755 "$out"
    '';
})
