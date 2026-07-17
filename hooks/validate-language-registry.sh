#!/usr/bin/env bash
# SPDX-License-Identifier: MPL-2.0
# Language-registry consistency guard.
#
# nextgen-languages registers its language family across several surfaces. They
# drifted badly before (a language present on one surface, missing on another),
# so this check fails the build when they disagree.
#
# Source of truth: the human-facing pointers in `languages/<id>.md`. Every other
# surface MUST list exactly that same set of ids:
#   - .machine_readable/LANGUAGES.a2ml   ([[language]] stanzas; forward-looking entries with
#                                         status "proposed"/"exploratory" are exempt — they
#                                         are not yet committed and carry no languages/ pointer)
#   - hooks/validate-coordinator-boundary.sh   (the LANGS re-vendoring guard list)
#   - .machine_readable/6a2/ECOSYSTEM.a2ml     ([language-repos] keys)
#   - language-status-tracker.jl               (const LANGUAGES — must be a SUPERSET;
#                                               it also tracks playgrounds/ecosystem/umbrella)
#
# See 0-AI-MANIFEST.a2ml and EXTRACTION-MANIFEST.md.
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

ERRORS=0

# ── Source of truth: languages/<id>.md pointers (excluding README) ────────────
family() {
  for f in languages/*.md; do
    b="$(basename "$f" .md)"
    [[ "$b" == "README" ]] || printf '%s\n' "$b"
  done | sort -u
}

# ── LANGUAGES.a2ml: committed [[language]] ids (status not proposed/exploratory) ──
a2ml_registered() {
  awk '
    /^\[\[language\]\]/ { if (id != "") print id, status; id=""; status="" ; next }
    /^id[ \t]*=/       { line=$0; sub(/^id[ \t]*=[ \t]*"/,"",line); sub(/".*/,"",line); id=line }
    /^status[ \t]*=/   { line=$0; sub(/^status[ \t]*=[ \t]*"/,"",line); sub(/".*/,"",line); status=line }
    END { if (id != "") print id, status }
  ' .machine_readable/LANGUAGES.a2ml \
    | awk '$2 != "proposed" && $2 != "exploratory" { print $1 }' | sort -u
}

# ── boundary-hook LANGS list ──────────────────────────────────────────────────
hook_langs() {
  grep -E '^LANGS=' hooks/validate-coordinator-boundary.sh \
    | sed -E 's/^LANGS="//; s/"[[:space:]]*$//' \
    | tr ' ' '\n' | sed '/^$/d' | sort -u
}

# ── ECOSYSTEM.a2ml [language-repos] keys (excluding the `note` key) ───────────
ecosystem_keys() {
  awk '
    /^\[language-repos\]/ { inblk=1; next }
    /^\[/                 { inblk=0 }
    inblk && /^[^#].*=/ {
      key=$0; sub(/[ \t]*=.*/,"",key); gsub(/["[:space:]]/,"",key)
      if (key != "note" && key != "") print key
    }
  ' .machine_readable/6a2/ECOSYSTEM.a2ml | sort -u
}

# ── tracker const LANGUAGES vector (quoted ids) ───────────────────────────────
tracker_langs() {
  awk '/const LANGUAGES[ \t]*=[ \t]*\[/ { inblk=1; next } inblk && /^\]/ { inblk=0 } inblk' \
    language-status-tracker.jl \
    | grep -oE '"[^"]+"' | tr -d '"' | sort -u
}

FAMILY="$(family)"
COUNT="$(printf '%s\n' "$FAMILY" | wc -l | tr -d ' ')"
printf 'language-registry: source of truth = languages/*.md (%s entries)\n' "$COUNT"

# report_diff <surface-name> <surface-set> <mode: exact|superset>
report_diff() {
  local name="$1" have="$2" mode="$3" missing extra
  missing="$(comm -23 <(printf '%s\n' "$FAMILY") <(printf '%s\n' "$have") || true)"
  if [[ -n "$missing" ]]; then
    printf 'ERROR: %s is MISSING family languages:\n' "$name"
    printf '%s\n' "$missing" | sed 's/^/  - /'
    ERRORS=$((ERRORS + 1))
  fi
  if [[ "$mode" == "exact" ]]; then
    extra="$(comm -13 <(printf '%s\n' "$FAMILY") <(printf '%s\n' "$have") || true)"
    if [[ -n "$extra" ]]; then
      printf 'ERROR: %s lists languages NOT in languages/ (add a pointer, or remove them):\n' "$name"
      printf '%s\n' "$extra" | sed 's/^/  - /'
      ERRORS=$((ERRORS + 1))
    fi
  fi
}

report_diff ".machine_readable/LANGUAGES.a2ml"             "$(a2ml_registered)" exact
report_diff "hooks/validate-coordinator-boundary.sh LANGS" "$(hook_langs)"      exact
report_diff ".machine_readable/6a2/ECOSYSTEM.a2ml"         "$(ecosystem_keys)"  exact
report_diff "language-status-tracker.jl const LANGUAGES"   "$(tracker_langs)"   superset

if [[ "$ERRORS" -gt 0 ]]; then
  printf '\nlanguage-registry check FAILED (%s surface(s) out of sync).\n' "$ERRORS"
  printf 'Every language must appear on all registry surfaces. Update them together —\n'
  printf 'the canonical set is languages/*.md; see .machine_readable/LANGUAGES.a2ml.\n'
  exit 1
fi

printf 'language-registry: OK (all surfaces agree on the %s-language family)\n' "$COUNT"
exit 0
