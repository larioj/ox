# General Documentation

## Configuration
-   .gitignore
-   simple.nix
-   default.nix

## Vim
-   autoload/plum/ox.vim

## Sources
-   core/Main.hs
-   core/cabal.nix
-   hs/Main.hs
-   hs/cabal.nix
-   oxlib/oxlib.nix
-   cli/ox

## Build
    $ nix-build
    $ nix-env -f default.nix -i

## Format
    $ nix-shell --packages stylish-haskell --run \
      'stylish-haskell -i haskell/Main.hs'

## Test ox
    $ ox-haskell build impurities oxlib cabal
    $ cli/ox <<EOF
    -- ox export tail
    tail :: [a] -> Maybe [a]
    tail [] = Nothing
    tail (a : rest) = Just rest
    EOF
