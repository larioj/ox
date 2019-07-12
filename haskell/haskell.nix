{
  src = ./.;
  name = "ox-haskell";
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
    "split"
  ];
  cabalVersion = ">=1.10";
}
