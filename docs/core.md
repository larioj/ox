# Core

## Sources
-   core/ox-core.cabal
-   core/Main.hs

## Build
    $ make
    $ make clean

## Test
    $ result/bin/ox-core hs <<EOF
    # ox export bar
    foo = putStrLn "hello"
    EOF
