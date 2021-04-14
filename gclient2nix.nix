{ stdenv
, lib
, jq
, makeWrapper
}:
stdenv.mkDerivation rec {
  name = "gclient2nix";
  buildInputs = [ jq ];
  nativeBuildInputs = [ makeWrapper ];
  src = ./src;
  unpackPhase = ":";
  installPhase = ''
    mkdir -p $out/bin
    cp -r ${src}/. $out/bin/
    wrapProgram $out/bin/gclient2nix \
      --prefix PATH : ${lib.makeBinPath [ jq ]}
  '';
}
