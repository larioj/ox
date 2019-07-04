HLIB = lib
HEXE = core haskell
MODULES = $(HEXE) $(HLIB)
DEPS = regex-pcre containers directory bytestring cryptohash base16-bytestring filepath

nix: $(foreach N, $(MODULES), $N/ox-$N.cabal.nix)

%.cabal.nix: %.cabal
	cd $$(dirname $@) && nix-shell --packages cabal2nix --run \
	  'cabal2nix . > $$(basename $@)'

.PHONY: force

$(foreach N, $(HLIB), $N/ox-$N.cabal): force
	nix-shell --packages ghc --run '\
	  cd $$(dirname $@) && \
	  cabal init \
	    --non-interactive \
	    --minimal \
	    --overwrite \
	    --author "Jesus E. Larios Murillo" \
	    --email=preparedfortherain@gmail.com \
	    --version=0.0.1 \
	    --license=BSD3 \
	    --package-name=$$(basename $@ | cut -f 1 -d ".") \
	    --is-library \
	    --dependency=base \
	    $(foreach D, $(DEPS), --dependency=$D) \
	'

$(foreach N, $(HEXE), $N/ox-$N.cabal): force
	nix-shell --packages ghc --run '\
	  cd $$(dirname $@) && \
	  cabal init \
	    --non-interactive \
	    --minimal \
	    --overwrite \
	    --author "Jesus E. Larios Murillo" \
	    --email=preparedfortherain@gmail.com \
	    --version=0.0.1 \
	    --license=BSD3 \
	    --package-name=$$(basename $@ | cut -f 1 -d ".") \
	    --is-executable \
	    --dependency=base \
	    $(foreach D, $(DEPS), --dependency=$D) \
	'

.PHONY: clean

clean:
	rm */*.cabal
	rm */*.cabal.nix
	rm */Setup.hs
	rm */ChangeLog.md
	rm */LICENSE

vpath % $(MODULES)
