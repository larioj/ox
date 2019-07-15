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
-   cli/ox

## Build
    $ nix-build
    $ nix-env -f default.nix -i
    $ result/bin/ox
    $ rm result*

## Test ox
    $ cli/ox <<EOF
    -- ox export tail
    tail :: [a] -> Maybe [a]
    tail [] = Nothing
    tail (a : rest) = Just rest
    EOF
