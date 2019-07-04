let
  config = {
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = haskellPackagesNew: haskellPackagesOld: rec {
          ox-lib = haskellPackagesNew.callPackage ./lib/ox-lib.cabal.nix { };
        };
      };
    };
  };
  pkgs = import <nixpkgs> { inherit config; };
in { 
    ox-core = pkgs.haskellPackages.callPackage ./core/ox-core.cabal.nix { };
    ox-haskell = pkgs.haskellPackages.callPackage ./haskell/ox-haskell.cabal.nix { };
}
