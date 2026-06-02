# SPDX-License-Identifier: MPL-2.0
# KitchenSpeak proof build harness.
#
# The KitchenSpeak invariant is "Agda-Proven": this Makefile is the
# entry point that discharges it. It type-checks every proof in the
# core library; a green run means zero unsolved goals.
#
# Requirements:
#   - Agda 2.6.4+            (e.g. `nix shell nixpkgs#agda`, or distro pkg)
#   - agda-stdlib 2.3+       (registered in your ~/.agda/libraries)
#   - echo-types + absolute-zero (registered in ~/.agda/libraries) for
#     EchoBridge.agda — see proofs/README.adoc and ../decisions/0003.
#
# Usage:
#   make            # type-check the whole core proof library
#   make dough      # type-check Dough.agda only
#   make poachedegg # type-check PoachedEgg.agda only
#   make echobridge # type-check EchoBridge.agda only (needs echo-types)
#   make clean      # remove Agda interface files

AGDA        ?= agda
AGDA_FLAGS  ?= --library=kitchenspeak
SRC_DIR     := agda

# The core proof library, in dependency-free order. Emulsion and Sear
# are tracked in ../ROADMAP.adoc Phase 1c and join this list as they
# land. EchoBridge wires the @ witness onto hyperpolymath/echo-types.
MODULES := Dough PoachedEgg EchoBridge

.PHONY: all clean $(MODULES)

all: $(MODULES)

# Per-module targets (lower-cased) so `make poachedegg` works.
dough: Dough
poachedegg: PoachedEgg
echobridge: EchoBridge

$(MODULES):
	cd $(SRC_DIR) && $(AGDA) $(AGDA_FLAGS) $@.agda

clean:
	find $(SRC_DIR) -name '*.agdai' -delete
