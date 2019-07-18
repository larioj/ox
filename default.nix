let
  coreSpec = import core/cabal.nix;
  haskellSpec = import hs/cabal.nix;
  oxlibSpec = import oxlib/oxlib.nix;
  config = {
    packageOverrides = pkgs: rec {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = haskellPackagesNew: haskellPackagesOld: rec {
          oxlib = pkgs.callPackage ./simple.nix { spec = oxlibSpec; };
          ox-core = pkgs.callPackage ./simple.nix { spec = coreSpec; };
          ox-haskell = pkgs.callPackage ./simple.nix { spec = haskellSpec; };
        };
      };
    };
  };
  src = ./.;
  pkgs = import <nixpkgs> { inherit config; };
  ox = pkgs.runCommand "ox" { } ''
    mkdir -p $out/bin
    cp ${src}/cli/ox $out/bin/ox
    cp ${pkgs.haskellPackages.ox-core}/bin/ox-core $out/bin/ox-core
    cp ${pkgs.haskellPackages.ox-haskell}/bin/ox-haskell $out/bin/ox-haskell
  '';
in {
  ox = ox;
}
