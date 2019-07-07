# General Documentation

## Configuration
-   .gitignore
-   simple.nix
-   default.nix

## Sources
-   core/Main.hs
-   core/core.nix
-   haskell/Main.hs
-   haskell/haskell.nix
-   haskell-impurity/Main.hs
-   haskell-impurity/haskell-impurity.nix
-   lib/Util.hs
-   ox.sh

## Build
    $ nix-build

## Impurities
    $ tree .
    $ result-3/bin/ox-haskell-impurity oxlib oxlib

## Test
    $ tree .
    $ result/bin/ox-core hs <<EOF
    -- ox export head
    head :: [a] -> Maybe a
    head [] = Nothing
    head (a : rest) = Just a
    EOF
    $ result-2/bin/ox-haskell oxlib \
        ox/head.23519fe8a95c0a57286224ed219db813cbe08a2be70be7813ebf471018948947.hs
