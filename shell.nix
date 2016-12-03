{ fetchzip ? (import <nixpkgs> {}).fetchzip
, ... }:
let
  pkgs = import (fetchzip (import ./channel.nix)) {};

  inherit (pkgs) stdenv;
  inherit (stdenv) mkDerivation;
in mkDerivation {
  name = "seckey-workshop";
  buildInputs = with pkgs; [
    # for yubikey users
    yubikey-neo-manager

    gnupg
    pcsctools
  ];
}
