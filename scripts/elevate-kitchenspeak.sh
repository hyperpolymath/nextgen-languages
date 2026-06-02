#!/usr/bin/env bash
# SPDX-License-Identifier: MPL-2.0
# Copyright (c) 2026 Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
#
# Elevate KitchenSpeak from an in-tree directory of nextgen-languages to a
# standalone canonical repository wired back in as a git submodule, matching
# every sibling language (affinescript, ephapax, betlang, ...).
#
# WHY THIS IS A SCRIPT AND NOT ALREADY DONE
# -----------------------------------------
# The content side of the elevation (standalone README/LICENSE/ROADMAP, the
# proof build harness, and the PoachedEgg proof that commences Phase 1) is
# already committed under kitchenspeak/. The remaining mechanical step —
# creating the GitHub repo and converting the directory into a submodule —
# needs (a) network access to github.com and (b) a credential allowed to
# create repositories. The automated session that prepared this branch had
# neither (repo creation returned HTTP 403 "Resource not accessible by
# integration"). Run this once locally, or from any environment that does.
#
# REQUIREMENTS
#   - gh CLI, authenticated as (or able to push to) hyperpolymath
#   - git with network access to github.com
#   - run from the nextgen-languages repo root
#
# IDEMPOTENCY
#   - Skips repo creation if hyperpolymath/kitchenspeak already exists.
#   - Refuses to run if kitchenspeak/ is already a submodule.

set -euo pipefail

OWNER="hyperpolymath"
NAME="kitchenspeak"
REMOTE_SSH="git@github.com:${OWNER}/${NAME}.git"
SUBDIR="kitchenspeak"

# --- sanity checks ----------------------------------------------------------
if [[ ! -d "${SUBDIR}" ]]; then
  echo "error: run from the nextgen-languages repo root (no ${SUBDIR}/)." >&2
  exit 1
fi
if git config --file .gitmodules --get "submodule.${SUBDIR}.url" >/dev/null 2>&1; then
  echo "error: ${SUBDIR} is already a submodule. Nothing to do." >&2
  exit 1
fi
command -v gh  >/dev/null || { echo "error: gh CLI not found." >&2; exit 1; }

# --- 1. create the standalone repo (skip if it exists) ----------------------
if gh repo view "${OWNER}/${NAME}" >/dev/null 2>&1; then
  echo "==> ${OWNER}/${NAME} already exists; skipping creation."
else
  echo "==> creating ${OWNER}/${NAME} ..."
  gh repo create "${OWNER}/${NAME}" \
    --public \
    --description "A formally-verified, hardware-agnostic orchestration DSL for the domestic kitchen. Agda-proven; member of the nextgen-languages family."
fi

# --- 2. split kitchenspeak/ into its own history and push -------------------
echo "==> splitting ${SUBDIR}/ history ..."
SPLIT_BRANCH="ks-split-$$"
git subtree split --prefix="${SUBDIR}" -b "${SPLIT_BRANCH}"

echo "==> pushing split history to ${REMOTE_SSH} main ..."
git push "${REMOTE_SSH}" "${SPLIT_BRANCH}:main"
git branch -D "${SPLIT_BRANCH}"

# --- 3. convert the directory into a submodule ------------------------------
echo "==> converting ${SUBDIR}/ into a submodule ..."
git rm -r --cached "${SUBDIR}"
rm -rf "${SUBDIR}"
git submodule add "${REMOTE_SSH}" "${SUBDIR}"
git submodule update --init "${SUBDIR}"

# --- 4. commit ---------------------------------------------------------------
git add .gitmodules "${SUBDIR}"
git commit -m "Elevate KitchenSpeak to standalone repo + wire as submodule (ADR 0002)"

echo "==> done. ${OWNER}/${NAME} created, history preserved, ${SUBDIR}/ is now a submodule."
echo "    Review with: git submodule status ${SUBDIR}"
