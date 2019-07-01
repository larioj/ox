let
  pkgs = import <nixpkgs> { };
in
  { ox-core = pkgs.haskellPackages.callPackage ./core/ox-core.cabal.nix { };
  }
