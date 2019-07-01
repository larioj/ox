# Core

## Sources
-   core/ox-core.cabal
-   core/ox-core.cabal.nix
-   core/Main.hs

## Build
    $ make

## Test
    $ result/bin/ox-core hs <<EOF
    # ox export bar
    foo = putStrLn "hello"
    EOF
    $ tree ox
