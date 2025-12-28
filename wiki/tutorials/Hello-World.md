# Tutorial: Hello World

> Your first program in each NextGen language

**Status:** 📝 Placeholder - contributions welcome

## Overview

This tutorial shows you how to write "Hello, World!" in each language of the NextGen ecosystem.

## By Language

### Me (Visual)

1. Open the Me playground
2. Drag a "Say" block
3. Type "Hello, World!"
4. Click the green flag

### Solo

```solo
fn main() effect { console } {
  console.println("Hello, World!")
}
```

Run: `cargo run --bin solo examples/hello.solo`

### Duet

```duet
fn main() effect { console } {
  console.println("Hello, World!")
}

// Or let AI help:
@synth
fn greet(name: String) -> String
  intent("return a friendly greeting for the given name")
```

### Ensemble

```ensemble
fn main() -> IO<()> {
  print("Hello, World!")
}

// With AI:
ai_model Greeter { provider: "local" }
fn ai_hello() -> AI<String> {
  Greeter.complete("Say hello creatively")
}
```

### Phronesis

```phronesis
Agent.Greeter
  Values:
    friendliness > formality

  Action greet():
    OUTPUT("Hello, World!")
    AUDIT("Greeted user")
```

### Eclexia

```eclexia
(program hello
  (energy budget 1mJ)
  (print "Hello, World!"))
```

### Oblíbený

```oblibeny
(module hello
  (forbid recursion)
  (define (main)
    (output "Hello, World!")))
```

### Anvomidav

```anvomidav
fn main() -> IO<()> {
  println!("Hello, World!")
}
```

### WokeLang

```wokelang
greet the world warmly
```

## Next Steps

- [[Tutorial: Variables and Types]]
- [[Choosing a Language]]
- [[IDE Setup]]
