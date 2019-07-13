# General Documentation

## Configuration
-   .gitignore
-   simple.nix
-   default.nix

## Vim
-   autoload/plum/ox.vim

## Sources
-   core/Main.hs
-   core/core.nix
-   haskell/Main.hs
-   haskell/haskell.nix
-   oxlib/oxlib.nix
-   ox.sh

## Build
    $ nix-build
    $ rm result*

## Flow Test
    $ ./ox.sh --quiet haskell store foo
    $ result/bin/ox-core hs <<EOF
    -- ox export tail
    tail :: [a] -> Maybe [a]
    tail [] = Nothing
    tail (a : rest) = Just rest
    EOF
