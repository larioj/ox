# General Documentation

## Configuration
-   .gitignore
-   default.nix
-   Makefile

## Sources
-   lib/Util.hs
-   core/Main.hs
-   haskell/Main.hs

## Use Nix To Generate Cabal Files
-   core/default.nix
-   core/core.nix

- simple.nix

## Build
    $ make nix
    $ nix-build
    $ make clean
    $ tree .
    $ git diff

    $ nix-build core/default.nix
