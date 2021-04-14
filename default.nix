{ pkgs ? import <nixpkgs> { } }:
{
  gclient2nix = pkgs.callPackage ./gclient2nix.nix { };
}
