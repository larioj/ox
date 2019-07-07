{
  src = ./.;
  name = "ox-core";
  version = "0.0.1";
  executable = {
    main = "Main.hs";
  };
  dependencies = [
    "base"
    "regex-pcre"
    "containers"
    "directory"
    "bytestring"
    "cryptohash"
    "base16-bytestring"
    "filepath"
    "oxlib"
  ];
  cabalVersion = ">=1.10";
}
