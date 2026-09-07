<!-- SPDX-License-Identifier: CC-BY-SA-4.0 -->
# Language toolchain evidence atlas — 2026-09-07

[Open the evidence browser](atlas.html), [whole-grid PNG](atlas.png), or
[lossless SVG](atlas.svg). The image is intentionally large; SVG remains sharp
when zoomed. Smaller panels: [languages](languages.png),
[faces and foundations](foundations.png), [augmentation tools](augmentations.png).

The dataset contains **67 rows × 28 component questions**. These are selected
languages, version lineages, faces, foundations and augmentation tools, not a
count of independent languages or the whole GitHub estate. Detailed findings
and the initial observation denominators are in the
[audit](../2026-09-07-language-portfolio.md) and
[checkout horizon](../2026-09-07-checkout-horizon.md).

| Symbol | Evidence meaning |
|---|---|
| T | An actual test passed for the slice stated in the cell note. |
| P | An actual proof tool checked the stated model/control. This does not prove the runtime. |
| I | Relevant implementation was inspected; execution is not implied. |
| D | Reviewed design/specification; implementation is not established for that cell. |
| ! | Specific partial implementation, stub, failed check or conditional guarantee. |
| F | Related candidate filename only. Source existence is not implementation evidence. |
| ? | Not assessed with sufficient evidence; not an absence claim. |
| R | Refer to the named canonical core; no independent inherited guarantee. |
| H | Host-language component or outside this foundation/augmentation's role. |
| X | Private implementation details withheld from the public atlas. |

Every grid cell links to a note in the HTML browser. The browser uses ordinary
links, scrolling, sticky headings and hover text; it needs no scripts, external
assets, network connection or telemetry. It is an audit artifact, not language
implementation vendored into this coordinator.

The raw [CSV](atlas.csv) and [JSON](atlas.json) preserve the classifications,
qualifications and source navigation. Source links use the enumerated commit
where available; local edits and untracked files can differ from that commit.
Rows and repair-PR links identify this distinction. A GitHub navigation link
alone is not a reproducible snapshot of a dirty working tree.

The Phronesis judgement/evidence graph is a real implementation, but its
compiler/proof/benchmark evidence extractors remain incomplete. Ephapax's
coprocessor shim is a stub; JtV's generated Zig kernels include placeholders;
AffineScript's emitter checks do not establish hardware execution. These are
separate cells because flattening them into “has coprocessor support” would lose
the most important information.

Firmboot was found after the initial inventory through a concurrent coordinator
update. Its 43-test Elixir result is from the local working tree, including the
uncommitted water-leak extension. Its published baseline is separately recorded;
fresh Agda/Lean runs were not performed for this atlas.

The augmentation rows refer to adapters and generated workloads. Their native
host parser/type system is marked H; the adapter's manifest parsing and
generation have their own source notes. Several inspected build/run entry points
only print instructions and return success. A green generator test would not
establish that those target toolchains ran.

These are evidence classifications, not TRG/CRG/FRG grades, readiness scores,
completion percentages or a security certification. The atlas exposes both
known implementation gaps and the remaining audit coverage.

All files in this atlas are licensed CC-BY-SA-4.0.
