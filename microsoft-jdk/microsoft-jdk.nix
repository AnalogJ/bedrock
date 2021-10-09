# forked from https://github.com/NixOS/nixpkgs/blob/nixos-21.05/pkgs/development/compilers/jetbrains-jdk/default.nix#L14
# see the following links for more documentation:
# - https://github.com/NixOS/nixpkgs/blob/nixos-21.05/pkgs/development/compilers/zulu/8.nix#L101
# - https://nix-tutorial.gitlabpages.inria.fr/nix-tutorial/first-package.html
# - https://nixos.wiki/wiki/Nixpkgs/Create_and_debug_packages

with import <nixpkgs> {};

adoptopenjdk-bin.overrideAttrs (oldAttrs: rec {
  pname = "microsoft-jdk";
  version = "11.0.12.7.1";
  src = pkgs.fetchurl {
    url = "https://aka.ms/download-jdk/microsoft-jdk-${version}-linux-x64.tar.gz";
    sha256 = "9520bb8a603f9859dc760fde3fecff1de06ecf1f1b7808f270f4e42ac4766a0e";
  };

  patches = [];
  meta = with lib; {
    description = " The Microsoft Build of OpenJDK is a new no-cost long-term supported distribution.";
    longDescription = ''
     The Microsoft Build of OpenJDK is a no-cost distribution of OpenJDK that's open source and available for free for anyone to deploy anywhere. It includes Long-Term Support (LTS) binaries for Java 11 and Java 17 on x64 server and desktop environments on macOS, Linux, and Windows, and AArch64/ARM64 on Linux and Windows. Microsoft also publishes Java 16 binaries for all three major Operating Systems and both x64 and AArch64 (M1/ARM64) architecture
    '';
    homepage = "https://www.microsoft.com/openjdk";
    platforms = [ "x86_64-linux"  ];
  };
  passthru = oldAttrs.passthru // {
    home = "${microsoft-jdk.jdk}/lib/openjdk";
  };
})

