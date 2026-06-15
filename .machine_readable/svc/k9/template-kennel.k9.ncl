K9!
# SPDX-License-Identifier: MPL-2.0
# K9 Kennel-level template: Pure data configuration
# Security Level: Kennel (data-only, no execution)
# No signature required — safe for any use.

{
  pedigree = {
    schema_version = "1.0.0",
    component_type = "TODO: describe component type (e.g., 'language-metadata', 'build-config')",
    security = {
      leash = 'Kennel,
      trust_level = "data-only",
      allow_network = false,
      allow_filesystem_write = false,
      allow_subprocess = false,
    },
    metadata = {
      name = "TODO: component-name",
      version = "1.0.0",
      description = "TODO: Brief description of what this component contains",
      author = "Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>",
    },
  },

  # Pure data only. No contracts, no recipes — promote to template-yard
  # (Nickel contracts) or a Hunt component if you need validation/execution.
  config = {
    setting_1 = "value",
    setting_2 = 42,
    setting_3 = true,

    nested = {
      key = "value",
    },

    list = [
      "item1",
      "item2",
    ],
  },

  export = {
    format = "json",   # or "yaml", "toml"
    destination = "output.json",
  },
}

# Usage:
# 1. Fill in TODO items above.
# 2. Replace config = { ... } with your data.
# 3. Validate: nickel typecheck your-file.k9.ncl
# 4. Export:   nickel export your-file.k9.ncl > output.json
