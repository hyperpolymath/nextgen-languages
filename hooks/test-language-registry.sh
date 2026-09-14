#!/usr/bin/env bash
# SPDX-License-Identifier: MPL-2.0
# Copyright (c) 2026 Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
# Exercise the authoritative guard against a consistent fixture and planted faults.
set -euo pipefail
guard="$(git rev-parse --show-toplevel)/hooks/validate-language-registry.sh"
fixture="$(mktemp -d)"
trap 'rm -rf "$fixture"' EXIT
git -C "$fixture" init -q
mkdir -p "$fixture/languages" "$fixture/hooks" "$fixture/.machine_readable/descriptiles"
printf 'Reference to the probe repository\n' > "$fixture/languages/probe.adoc"
printf '[[language]]\nid = "probe"\nstatus = "active"\n' > "$fixture/.machine_readable/LANGUAGES.a2ml"
printf 'LANGS="probe"\n' > "$fixture/hooks/validate-coordinator-boundary.sh"
printf '[language-repos]\nprobe = "probe"\n' > "$fixture/.machine_readable/descriptiles/ECOSYSTEM.a2ml"
printf 'const LANGUAGES = [\n"probe"\n]\n' > "$fixture/language-status-tracker.jl"
cd "$fixture"
bash "$guard"

reject() {
  if bash "$guard" > "$fixture/result.log" 2>&1; then
    cat "$fixture/result.log"
    printf 'ERROR: registry guard accepted planted fault: %s\n' "$1" >&2
    exit 1
  fi
  printf 'Rejected planted fault: %s\n' "$1"
}

mv languages/probe.adoc languages/probe.saved
reject 'empty language pointer set'
mv languages/probe.saved languages/probe.adoc
printf 'unexpected pointer\n' > languages/unregistered.adoc
reject 'unregistered language pointer'
rm languages/unregistered.adoc
mv .machine_readable/LANGUAGES.a2ml .machine_readable/LANGUAGES.saved
reject 'missing registry input'
mv .machine_readable/LANGUAGES.saved .machine_readable/LANGUAGES.a2ml
bash "$guard"
