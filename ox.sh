#!/bin/bash

store () {
  ox-core "$1" < /dev/stdin
}

haskell () {
  case "$1" in
    store)
      shift
      store_haskell
    ;;
    *)
      ox-haskell "$@"
  esac
}

store_haskell () {
  NODE=$(ox-core hs < /dev/stdin)
  BASE="$(basename $file)"
  HASH="${BASE%.*}"
  ox-haskell build node "$HASKELL_DIR" "$NODE" 1>&2 &&
    ox-haskell build impurities "$HASKELL_DIR" "$HASKELL_NIX" 1>&2 &&
    nix-build 1>&2
  if [ $? -eq 0 ]; then
    echo OK 1>&2
    echo "import Ox${HASH} ($NAME)"
  else
    BASE=$(basename $file)
    rm ox/*${HASH}.hs
    rm oxlib/*${HASH}.hs
    result-3/bin/ox-haskell-impurity oxlib oxlib 1>&2
    nix-build 1>&2
    echo FAIL 1>&2
  fi
}

# Defaults
OX_DIR=ox
HASKELL_DIR=oxlib
HASKELL_NIX=oxlib

POS=()
for a in "$@"; do
  case $a in
    -q|--quiet)
      QUIET=true
    ;;
    --checked)
      CHECKED=true
    ;;
    --ox-dir)
      shift
      OX_DIR="$1"
    ;;
    --haskell-dir)
      shift
      HASKELL_DIR="$1"
    ;;
    *)
      POS+=($1)
    ;;
  esac
  shift
done

case ${POS[0]} in
  store)
    store "${POS[@]:1}"
  ;;
  haskell)
    haskell "${POS[@]:1}"
  ;;
  *)
    echo 'usage: ox [store|haskell]'
    exit 1
  ;;
esac


