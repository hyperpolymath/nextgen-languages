# SPDX-License-Identifier: MPL-2.0
# Coordinator task runner. This repository has no language build artifacts.

import? "contractile.just"

default:
    @just --list

# Check portfolio registry consistency.
validate-registry:
    bash hooks/validate-language-registry.sh

# Ensure implementation material stays in canonical language repositories.
validate-boundary:
    bash hooks/validate-coordinator-boundary.sh

# Run the coordinator's substantive validation checks.
validate: validate-registry validate-boundary

test: validate
    git diff --check

lint:
    for f in hooks/*.sh scripts/*.sh; do test ! -f "$$f" || bash -n "$$f"; done
    git diff --check

check: lint test

# A coordinator has no compiler or binary to build.
build:
    @echo "No build target: language implementations are maintained in their canonical repositories."

# Show basic environment information without changing files.
doctor:
    @printf 'Repository: '; git rev-parse --show-toplevel
    @printf 'Branch: '; git branch --show-current
    @command -v bash >/dev/null && echo "Bash: available"
    @command -v git >/dev/null && echo "Git: available"
    @command -v just >/dev/null && echo "Just: available" || true

# Print the current coordinator status entry points.
tour:
    @echo "Start with README.adoc, then EXPLAINME.adoc and docs/ecosystem-map.adoc."
    @echo "Run 'just validate' to check registry and coordinator boundaries."

help-me:
    @echo "https://github.com/hyperpolymath/nextgen-languages/issues/new"
