#!/usr/bin/env bash
# SPDX-License-Identifier: MPL-2.0
# Pre-commit / CI hook: enforce the pure-coordinator boundary.
#
# nextgen-languages is a COORDINATOR. Language implementations, specs, grammars,
# proofs, and per-language deep docs belong in each language's own
# hyperpolymath/<lang> repo — never here. This check fails the build when
# language-implementation content leaks back into the coordinator, which is how
# the monorepo->coordinator pivot kept regressing.
#
# See 0-AI-MANIFEST.a2ml "COORDINATOR BOUNDARY" and EXTRACTION-MANIFEST.md.
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

ERRORS=0

# Committed + staged-but-untracked files (so this catches leaks pre-commit too),
# minus anything git ignores. .git/ is excluded by construction.
mapfile -t FILES < <(
  { git ls-files; git ls-files --others --exclude-standard; } | sort -u
)

# Allowlist: the staging area for content awaiting resite to its sibling repo.
ALLOW_PREFIX="extraction-queue/"

# 1) Proof / grammar / DSL source extensions are language-implementation by
#    definition and must never appear in the coordinator.
LANG_EXT_RE='\.(agda|lean|idr|ebnf|bnf|g4|ks)$'

# 2) General compiler-source extensions only count as a leak when they sit inside
#    an implementation-shaped directory (a lone helper script at root is fine).
IMPL_EXT_RE='\.(rs|ml|mli|res|resi|v)$'
IMPL_DIR_RE='(^|/)(src|lib|crates|grammar|parser|compiler|typechecker)/'

for f in "${FILES[@]}"; do
  case "$f" in "$ALLOW_PREFIX"*) continue ;; esac
  if [[ "$f" =~ $LANG_EXT_RE ]]; then
    echo "ERROR: language-implementation source in coordinator: $f"
    echo "  -> belongs in that language's own hyperpolymath/<lang> repo (see EXTRACTION-MANIFEST.md)"
    ERRORS=$((ERRORS + 1))
  elif [[ "$f" =~ $IMPL_EXT_RE ]] && [[ "$f" =~ $IMPL_DIR_RE ]]; then
    echo "ERROR: compiler/implementation source tree in coordinator: $f"
    echo "  -> language toolchains live in hyperpolymath/<lang>, not in this hub"
    ERRORS=$((ERRORS + 1))
  fi
done

# 3) A directory named after one of the family languages must not reappear at the
#    coordinator root — that is how a whole language gets re-vendored in-tree.
LANGS="affinescript anvomidav betlang eclexia ephapax error-lang jtv my-lang oblibeny phronesis tangle wokelang kitchenspeak"
for lang in $LANGS; do
  if [ -d "$lang" ]; then
    echo "ERROR: language directory re-vendored at coordinator root: $lang/"
    echo "  -> the language lives at hyperpolymath/$lang; reference it, do not embed it"
    ERRORS=$((ERRORS + 1))
  fi
done

if [ "$ERRORS" -gt 0 ]; then
  echo ""
  echo "Coordinator-boundary check FAILED ($ERRORS violation(s))."
  echo "nextgen-languages coordinates the language family; it does not contain it."
  exit 1
fi

echo "coordinator-boundary: OK (no language-implementation content in-tree)"
exit 0
