{ haskellPackages, spec, writeTextFile }: let

  cabalExe = writeTextFile {
    name = spec.name;
    text = ''
    '';
  };

  cabalLib = writeTextFile {
    name = spec.name;
    text = ''
    name: ${spec.name}
    version: ${spec.version}
    '';
  };
  
in

haskellPackages.mkDerivation {
}
