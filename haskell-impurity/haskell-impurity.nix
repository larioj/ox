{
  src = ./.;
  name = "ox-haskell-impurity";
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
  ];
  cabalVersion = ">=1.10";
}
