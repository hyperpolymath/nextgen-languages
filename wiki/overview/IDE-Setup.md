# IDE Setup

> Configure your editor for NextGen Languages

**Status:** 📝 Placeholder - contributions welcome

## Recommended Editors

| Editor | Support Level | Extensions |
|--------|---------------|------------|
| VS Code | Full | NextGen Languages Pack |
| Neovim | Good | Tree-sitter grammars |
| Emacs | Good | Major modes available |
| Helix | Basic | Syntax highlighting |

## VS Code Setup

### Install Extensions

1. **NextGen Languages Pack** - Syntax highlighting for all languages
2. **Rust Analyzer** - For Rust-based language implementations
3. **Error Lens** - Inline error display

### Settings

```json
{
  "editor.formatOnSave": true,
  "nextgen.defaultLanguage": "solo",
  "nextgen.playground.autoOpen": true
}
```

## Neovim Setup

### Tree-sitter Grammars

```lua
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "solo",
    "duet",
    "ensemble",
    "phronesis",
  },
}
```

### LSP Configuration

```lua
require('lspconfig').nextgen_ls.setup {
  filetypes = { "solo", "duet", "ensemble" },
}
```

## Emacs Setup

```elisp
(use-package nextgen-mode
  :mode (("\\.solo\\'" . solo-mode)
         ("\\.duet\\'" . duet-mode)
         ("\\.ensemble\\'" . ensemble-mode)))
```

## Syntax Highlighting

Each language has its own file extension:

| Language | Extension |
|----------|-----------|
| Solo | `.solo` |
| Duet | `.duet` |
| Ensemble | `.ensemble` |
| Phronesis | `.phro` |
| Eclexia | `.ecl` |
| Oblíbený | `.obl` |
| Anvomidav | `.anv` |
| WokeLang | `.woke` |

## See Also

- [[Installation]]
- [[Your First Program]]
- [[REPL Guide]]
