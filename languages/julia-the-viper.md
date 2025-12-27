# julia-the-viper

> Systems programming with Harvard Architecture separation.

## Invariant

**Data and code occupy strictly separate memory spaces—no self-modifying code.**

## Example

```rust
// Data segment - immutable at runtime
data {
  lookup_table: [u8; 256] = precomputed_values()
}

// Code segment - no data writes
code {
  fn transform(input: u8) -> u8 {
    lookup_table[input]
  }
}
```

## Run

```bash
cargo run
```

## Status

🟡 TO VERIFY - Check sync with GitLab
