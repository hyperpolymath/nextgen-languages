# KitchenSpeak

> Formally-verified, hardware-agnostic orchestration for the domestic kitchen.

## Invariant

**Every ingredient is consumed exactly once, every loop terminates on a wall-clock bound, and every physical step is witnessed by a local sensor.**

## Example

```kitchenspeak
sync(Delia_Hob) proving @white_set {
    Delia_Hob.Poach(Egg, acidulant: Vinegar, depth: 4cm)
        until @white_set == true
        max_duration 4min
        on_fail RECOVER;
}
```

The `Egg` is a linear resource consumed by this call; `@white_set` is a
postulated visual witness; `max_duration` is the termination measure;
`on_fail RECOVER` is the total failure handler.

## Run

```bash
# Specification-only at v1.0. See kitchenspeak/README.adoc for scope.
```

## Status

CLASS PROJECT — experimental, specification at v1.0.
