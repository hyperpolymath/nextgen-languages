<!--
SPDX-License-Identifier: MPL-2.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->
# AffineScript

> Affine types and dependent types for WebAssembly.

## Invariant

**Every resource is used at most once—no accidental aliasing or double-free.**

## Example

```ocaml
let file : File = open("data.txt")
let contents = read(file)   (* file consumed here *)
(* file cannot be used again *)
close(contents.handle)
```

## Run

```bash
dune build
dune exec affinescript
```

## Status

🟡 TO VERIFY - Check sync with GitLab
