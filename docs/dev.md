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
-   oxlib/oxlib.nix
-   ox.sh
-   autoload/plum/ox.vim

## Build
    $ nix-build
    $ rm result*

## Flow Test
    $ ./ox.sh <<EOF
    -- ox export tail
    tail :: [a] -> Maybe [a]
    tail [] = Nothing
    tail (a : rest) = Just rest
    EOF
