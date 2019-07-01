default: all

all: ox-core

ox-core: ox-core.cabal.nix
	nix-build

ox-core.cabal.nix:
	cd core && nix-shell --packages cabal2nix --run \
	  'cabal2nix . > ox-core.cabal.nix'
