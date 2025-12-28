# Anvomidav

> Maximalist formal verification for hard real-time systems.

## Invariant

**Every resource is tracked, every deadline is statically guaranteed.**

## Example

```anvomidav
task @sched(EDF) @deadline(10ms) @wcet(5ms)
fn control_loop(sensor: Linear<Sensor>) -> ControlOutput {
  let reading = sensor.read()  // Linear: consumed here
  compute_response(reading)
}
```

## Run

```bash
cd anvomidav && git submodule update --init
cargo run
```

## Status

🟢 ACTIVE
