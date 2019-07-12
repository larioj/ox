#!/bin/bash

file=$(result/bin/ox-core hs < /dev/stdin)
echo $file
result-2/bin/ox-haskell oxlib "$file"
result-3/bin/ox-haskell-impurity oxlib oxlib
nix-build
if [ $? -eq 0 ]; then
  echo OK
else
  BASE=$(basename $file)
  rm ox/*${BASE}
  rm oxlib/*${BASE}
  result-3/bin/ox-haskell-impurity oxlib oxlib
  nix-build
  echo FAIL
fi
