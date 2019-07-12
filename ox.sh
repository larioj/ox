#!/bin/bash

file="$(result/bin/ox-core hs < /dev/stdin || exit 1)"
BASE="$(basename $file)"
HASH="${BASE%.*}"
NAME="${HASH%.*}"
HASH="${HASH##*.}"
result-2/bin/ox-haskell oxlib "$file" 1>&2 && \
  result-3/bin/ox-haskell-impurity oxlib oxlib 1>&2 && \
  nix-build 1>&2
if [ $? -eq 0 ]; then
  echo OK 1>&2
  echo "import Ox${HASH} ($NAME)"
else
  BASE=$(basename $file)
  rm ox/*${BASE}
  rm oxlib/*${BASE}
  result-3/bin/ox-haskell-impurity oxlib oxlib 1>&2
  nix-build 1>&2
  echo FAIL 1>&2
fi
