let
  coreSpec = import core/core.nix;
  haskellSpec = import haskell/haskell.nix;
  oxlibSpec = import oxlib/oxlib.nix;
  config = {
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = haskellPackagesNew: haskellPackagesOld: rec {
          oxlib = pkgs.callPackage ./simple.nix { spec = oxlibSpec; };
        };
      };
    };
  };
  pkgs = import <nixpkgs> { inherit config; };
in { 
    oxlib = pkgs.haskellPackages.oxlib;
    ox-core = pkgs.callPackage ./simple.nix { spec = coreSpec; };
    ox-haskell = pkgs.callPackage ./simple.nix { spec = haskellSpec; };
}
