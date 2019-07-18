{
  src = ./.;
  name = "ox-core";
  version = "0.0.1";
  executable = {
    main = "Main.hs";
  };
  dependencies = [
    "base"
    "containers"
    "directory"
    "filepath"
    "oxlib"
    "optparse-applicative"
  ];
  cabalVersion = ">=1.10";
}
