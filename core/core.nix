{ stdenv, writeTextFile, runCommand, tree, haskellPackages, ghc }: let
  name = "ox-core";
  src = ./.;
  srcWithCabal = runCommand "srcWithCabal" {} ''
    cp --recursive --no-preserve=mode ${src} src
    HOME=$(pwd)
    PATH=$PATH:${ghc}/bin
    (cd src && \
      ${haskellPackages.cabal-install}/bin/cabal --config-file=cabal-config init \
        --non-interactive \
        --minimal \
        --overwrite \
        --author "Jesus E. Larios Murillo" \
        --email=preparedfortherain@gmail.com \
        --version=0.0.1 \
        --license=BSD3 \
        --package-name=${name} \
        --is-executable \
        --dependency=base )
    (cd src &&
      ${haskellPackages.cabal2nix}/bin/cabal2nix . > ${name}.cabal.nix )
    cp --recursive --no-preserve=mode src $out
  '';
in

haskellPackages.callPackage srcWithCabal/name { };

stdenv.mkDerivation {
  inherit name;
  src = srcWithCabal;
  builder = writeTextFile {
    inherit name;
    text = ''
      source $stdenv/setup
      ${tree}/bin/tree ${srcWithCabal}
      ls ${srcWithCabal} > $out
    '';
  };
}
