#!/bin/bash

file=$(result/bin/ox-core < /dev/stdin)
result-2/bin/ox-haskell oxlib "$file"
result-3/bin/ox-haskell-impurity oxlib oxlib
nix-build --attr oxlib
if [ $? -eq 0 ]; then
  echo OK
else
  rm ox/*.${hash}.hs
  rm ox/${hash}.hs
  result-3/bin/ox-haskell-impurity oxlib oxlib
  echo FAIL
fi
