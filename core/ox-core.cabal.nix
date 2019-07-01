{ mkDerivation, base, base64-bytestring, bytestring, containers
, cryptohash, directory, stdenv
}:
mkDerivation {
  pname = "ox-core";
  version = "0.0.1";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base base64-bytestring bytestring containers cryptohash directory
  ];
  doHaddock = false;
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
