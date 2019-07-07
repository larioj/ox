{ haskellPackages, lib, stdenv, spec }: let

dependencies = builtins.concatStringsSep ", " spec.dependencies;
exposedModules = builtins.concatStringsSep ", " spec.library.exposedModules;

exeCabal = ''
  name: ${spec.name}
  version: ${spec.version}
  build-type: Simple
  cabal-version: ${spec.cabalVersion}
  executable ${spec.name}
    main-is: ${spec.executable.main}
    build-depends: ${dependencies}
'';

libCabal = ''
  name: ${spec.name}
  version: ${spec.version}
  build-type: Simple
  cabal-version: ${spec.cabalVersion}
  library
    exposed-modules: ${exposedModules}
    build-depends: ${dependencies}
'';

cabal = if lib.hasAttr "executable" spec then exeCabal else libCabal;

in haskellPackages.mkDerivation {
  inherit (spec) src;
  pname = spec.name;
  isExecutable = lib.hasAttr "executable" spec;
  isLibrary = lib.hasAttr "library" spec;
  version = spec.version;
  license = stdenv.lib.licenses.bsd3;
  executableHaskellDepends = map (d: haskellPackages.${d}) spec.dependencies;
  preConfigure = ''
    cat <<'EOF' > ${spec.name}.cabal
    ${cabal}
    EOF
    cat ${spec.name}.cabal
  '';
}
