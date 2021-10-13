# forked from https://github.com/NixOS/nixpkgs/blob/nixos-21.05/pkgs/development/compilers/jetbrains-jdk/default.nix#L14
# see the following links for more documentation:
# - https://github.com/NixOS/nixpkgs/blob/nixos-21.05/pkgs/development/compilers/zulu/8.nix#L101
# - https://nix-tutorial.gitlabpages.inria.fr/nix-tutorial/first-package.html
# - https://nixos.wiki/wiki/Nixpkgs/Create_and_debug_packages
# - https://discourse.nixos.org/t/how-to-install-github-released-binary/1328/6
# - https://github.com/samdroid-apps/nix-articles/blob/master/04-proper-mkderivation.md
{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation rec {
  pname = "s6-overlay";
  version = "2.2.0.3";

  src = pkgs.fetchurl {
    url = "https://github.com/just-containers/s6-overlay/releases/download/v${version}/s6-overlay-amd64.tar.gz";
    sha256 = "a7076cf205b331e9f8479bbb09d9df77dbb5cd8f7d12e9b74920902e0c16dd98";
  };

  phases = ["unpackPhase" "installPhase" "patchPhase"];
  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/bin
    echo "LISTING SRC FILES >>>>"
    ls -alt $src

    echo "LISTING PWD FILES >>>>"
    ls -alt .

    cp -R . $out/
    mv $out/init /$out/bin/init
    chmod +x $out/bin/*
  '';
}

