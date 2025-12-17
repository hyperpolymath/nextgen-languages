# NextGen Languages Ecosystem Roadmap

## Vision
A family of educational and specialized programming languages designed to grow with learners from age 8 through professional practice, unified by shared tooling, consistent design philosophy, and progressive complexity.

---

## Phase 0: Foundation (Current)
**Status: In Progress**

### 0.1 Repository Consolidation
- [ ] Complete GitLab → GitHub migration
- [ ] Establish hub-and-spoke architecture
- [ ] Set up mirroring to GitLab/Codeberg/Bitbucket
- [ ] Standardize repo structure across all languages

### 0.2 Documentation Infrastructure
- [ ] Complete wiki structure
- [ ] Language specification templates
- [ ] Contribution guidelines
- [ ] CI/CD pipelines for docs

### 0.3 Shared Tooling Foundation
- [ ] Common AST representation format
- [ ] Shared error message framework
- [ ] Universal test harness
- [ ] Cross-language interop protocol

---

## Phase 1: Core Language Implementation

### 1.1 Lexer Development

| Language | Target | Technology | Status |
|----------|--------|------------|--------|
| Me | Tokenizer | Rust | Planning |
| Solo | Tokenizer | Rust | Planning |
| Duet | Tokenizer | Rust | Planning |
| Ensemble | Full Lexer | Rust | Planning |
| betlang | Probabilistic Lexer | Racket | Partial |
| julia-the-viper | Harvard Lexer | Rust | Partial |
| Phronesis | Wisdom Lexer | Elixir | Planning |
| Eclexia | Creative Lexer | Rust | In Progress |
| Oblíbený | Preference Lexer | TBD | Planning |
| Anvomidav | Real-time Lexer | Rust | Planning |
| WokeLang | Context Lexer | Rust | Planning |

**Lexer Milestones:**
1. Token specification for each language
2. Lexer generator evaluation (logos, nom, hand-rolled)
3. Error recovery and reporting
4. Source location tracking
5. Unicode support
6. Incremental lexing for IDE support

### 1.2 Parser Development

| Language | Grammar Type | Parser Type | Status |
|----------|--------------|-------------|--------|
| Me | LL(1) | Recursive Descent | Planning |
| Solo | LL(1) | Recursive Descent | Planning |
| Duet | LL(k) | Pratt Parser | Planning |
| Ensemble | GLR | Tree-sitter | Planning |
| betlang | PEG | Packrat | Partial |
| julia-the-viper | LALR | Generated | Partial |
| Phronesis | LL(*) | ANTLR | Planning |
| Eclexia | PEG | Custom | In Progress |
| Oblíbený | LL(1) | Recursive Descent | Planning |
| Anvomidav | LL(1) | Zero-copy | Planning |
| WokeLang | Context-sensitive | Earley | Planning |

**Parser Milestones:**
1. Formal grammar specification (EBNF/PEG)
2. AST node definitions
3. Parser implementation
4. Error recovery strategies
5. Incremental parsing
6. CST preservation for formatting

### 1.3 Semantic Analysis

**Shared Components:**
- Type inference engine
- Symbol table management
- Scope resolution
- Name binding
- Control flow analysis
- Data flow analysis

**Per-Language Specifics:**

| Language | Type System | Special Analysis |
|----------|-------------|------------------|
| Me | Dynamic | Simplicity checker |
| Solo | Gradual | Age-appropriate validator |
| Duet | Gradual + inference | Collaboration checker |
| Ensemble | Full static | Complexity analyzer |
| betlang | Probabilistic types | Distribution checker |
| julia-the-viper | Linear types | Memory safety prover |
| Phronesis | Dependent types | Wisdom validator |
| Eclexia | Creative types | Novelty detector |
| Oblíbený | Preference types | Consistency checker |
| Anvomidav | Real-time types | Timing analyzer |
| WokeLang | Social types | Impact analyzer |

---

## Phase 2: Execution Engines

### 2.1 Interpreter Development

**Architecture Options:**
1. **Tree-walking interpreter** (Me, Solo) - simplest, best for beginners
2. **Bytecode interpreter** (Duet, Ensemble) - better performance
3. **JIT compilation** (specialized languages) - production performance

| Language | Interpreter Type | Runtime | Status |
|----------|------------------|---------|--------|
| Me | Tree-walking | Embedded | Planning |
| Solo | Tree-walking | Standalone | Planning |
| Duet | Bytecode VM | Custom VM | Planning |
| Ensemble | Bytecode VM | Custom VM | Planning |
| betlang | Racket runtime | Racket | Exists |
| julia-the-viper | Native | LLVM | Partial |
| Phronesis | BEAM VM | Elixir | Planning |
| Eclexia | Native | LLVM | In Progress |
| Oblíbený | Tree-walking | Custom | Planning |
| Anvomidav | Real-time VM | Custom RT | Planning |
| WokeLang | Bytecode VM | Custom | Planning |

**Interpreter Milestones:**
1. Value representation
2. Environment/scope implementation
3. Function calling convention
4. Built-in functions
5. Module system
6. Garbage collection strategy
7. Debugging support
8. Profiling hooks

### 2.2 Compiler Development

**Compilation Targets:**

```
Source Code
    │
    ▼
┌─────────────────┐
│   Frontend      │  (Lexer → Parser → Semantic Analysis)
│   (per-language)│
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Shared IR     │  (NextGen Intermediate Representation)
│                 │
└────────┬────────┘
         │
    ┌────┴────┬─────────┬──────────┐
    ▼         ▼         ▼          ▼
┌───────┐ ┌───────┐ ┌───────┐ ┌────────┐
│ LLVM  │ │ WASM  │ │  JVM  │ │ Native │
│Backend│ │Backend│ │Backend│ │Interp. │
└───────┘ └───────┘ └───────┘ └────────┘
```

**Compiler Phases:**
1. **Frontend** - Language-specific parsing to AST
2. **Middle-end** - Optimization on shared IR
3. **Backend** - Target-specific code generation

| Language | Primary Target | Secondary Targets | Status |
|----------|----------------|-------------------|--------|
| Me | Interpreter | WASM (playground) | Planning |
| Solo | Interpreter | WASM | Planning |
| Duet | Bytecode | WASM | Planning |
| Ensemble | LLVM | WASM, JVM | Planning |
| betlang | Racket | - | Exists |
| julia-the-viper | LLVM | Native | Partial |
| Phronesis | BEAM | - | Planning |
| Eclexia | LLVM | WASM | In Progress |
| Oblíbený | Interpreter | WASM | Planning |
| Anvomidav | LLVM (RT) | Native | Planning |
| WokeLang | Bytecode | WASM | Planning |

### 2.3 REPL Development

**REPL Features by Complexity Level:**

**Basic (Me, Solo):**
- Simple read-eval-print loop
- Colored output
- Basic history
- Help command

**Intermediate (Duet, Oblíbený):**
- Multi-line input
- Tab completion
- Syntax highlighting
- Variable inspection
- Save/load sessions

**Advanced (Ensemble, Specialized Languages):**
- Full debugger integration
- Hot reload
- Time-travel debugging
- Performance profiling
- Network REPL (for collaboration)
- Notebook integration

**REPL Architecture:**
```
┌─────────────────────────────────────────┐
│              REPL Shell                 │
├─────────────────────────────────────────┤
│  Input Handler  │  Output Formatter     │
├─────────────────┼───────────────────────┤
│  History Mgr    │  Completion Engine    │
├─────────────────┴───────────────────────┤
│           Evaluation Engine             │
├─────────────────────────────────────────┤
│        Language Runtime/Interpreter     │
└─────────────────────────────────────────┘
```

---

## Phase 3: Developer Tooling

### 3.1 Language Server Protocol (LSP)

**Shared LSP Features:**
- Go to definition
- Find references
- Hover documentation
- Diagnostics
- Code completion
- Signature help
- Document symbols
- Workspace symbols
- Rename refactoring
- Code actions

**Implementation Strategy:**
1. Shared LSP framework in Rust
2. Per-language analysis backends
3. VSCode extension (primary)
4. Neovim plugin
5. Emacs mode
6. JetBrains plugin

### 3.2 Formatter & Linter

**Formatter (nextgen-fmt):**
- Opinionated formatting per language
- Configuration options
- IDE integration
- Pre-commit hooks
- CI integration

**Linter (nextgen-lint):**
- Language-specific rules
- Educational suggestions (for Me/Solo/Duet)
- Performance hints
- Security checks
- Style enforcement
- Custom rule API

### 3.3 Package Manager

**Package Manager (nextgen-pkg):**
```
nextgen-pkg init          # Create new project
nextgen-pkg add <dep>     # Add dependency
nextgen-pkg remove <dep>  # Remove dependency
nextgen-pkg install       # Install all dependencies
nextgen-pkg publish       # Publish to registry
nextgen-pkg search <q>    # Search packages
```

**Registry Architecture:**
- Central registry (packages.nextgen-languages.dev)
- GitLab/GitHub as package sources
- Semantic versioning
- Dependency resolution
- Security scanning
- License compliance

### 3.4 Build System

**Build Tool (nextgen-build):**
```
nextgen-build             # Build project
nextgen-build test        # Run tests
nextgen-build bench       # Run benchmarks
nextgen-build doc         # Generate documentation
nextgen-build release     # Create release build
```

**Features:**
- Incremental compilation
- Parallel builds
- Cross-compilation
- WASM output
- Native binaries
- Docker image generation

### 3.5 Testing Framework

**Test Runner (nextgen-test):**
- Unit tests
- Integration tests
- Property-based testing
- Snapshot testing
- Coverage reporting
- Mutation testing
- Benchmark suite

**Educational Testing (Me/Solo/Duet):**
- Guided test creation
- Visual test results
- Progress tracking
- Achievement system

---

## Phase 4: Frameworks & Libraries

### 4.1 Standard Library

**Core Modules (all languages):**
```
std/
├── core/           # Fundamental types and operations
├── collections/    # Lists, maps, sets, etc.
├── io/             # Input/output operations
├── text/           # String manipulation
├── math/           # Mathematical operations
├── time/           # Date and time
├── fs/             # File system operations
├── net/            # Networking
├── json/           # JSON parsing/generation
├── testing/        # Test utilities
└── debug/          # Debugging utilities
```

**Age-Appropriate Libraries:**

| Module | Me | Solo | Duet | Ensemble |
|--------|----|----- |------|----------|
| core | ✓ (simple) | ✓ | ✓ | ✓ (full) |
| turtle | ✓ | ✓ | - | - |
| games | ✓ | ✓ | ✓ | - |
| music | ✓ | ✓ | ✓ | ✓ |
| art | ✓ | ✓ | ✓ | ✓ |
| web | - | ✓ (simple) | ✓ | ✓ |
| data | - | - | ✓ | ✓ |
| ml | - | - | - | ✓ |

### 4.2 Web Framework

**nextgen-web:**
- Server-side rendering
- API development
- WebSocket support
- Template engine
- Static site generation
- WASM client-side

**Endpoints:**
```
# Example: Ensemble web app
web.route("/", fn(req) ->
  web.html("<h1>Hello, World!</h1>")
)

web.route("/api/users", fn(req) ->
  web.json(users.all())
)

web.start(port: 8080)
```

### 4.3 GUI Framework

**nextgen-ui:**
- Cross-platform (Windows, macOS, Linux)
- Web target (WASM)
- Mobile (via web)
- Declarative syntax
- Reactive state management

**UI Syntax:**
```
# Example: Solo GUI app
window "My App" {
  column {
    text "Hello!"
    button "Click me" -> on_click
  }
}
```

### 4.4 Game Framework

**nextgen-game:**
- 2D game engine
- Sprite management
- Physics (simple)
- Audio
- Input handling
- Scene management

**Targets:** Desktop, Web (WASM), Mobile (web wrapper)

### 4.5 Data Science Libraries

**For Ensemble and specialized languages:**
- DataFrame operations
- Statistical functions
- Visualization
- ML model integration
- Data import/export

---

## Phase 5: IDE & Editor Support

### 5.1 VSCode Extension

**Features:**
- Syntax highlighting (TextMate grammars)
- LSP integration
- Debugger integration
- Snippet support
- Project templates
- Integrated REPL
- Notebook support

### 5.2 Web Playground

**playground.nextgen-languages.dev:**
- In-browser editor
- WASM-based execution
- Shareable links
- Example gallery
- Tutorial integration
- Multi-language support

### 5.3 Educational IDE

**NextGen Studio (for Me/Solo/Duet):**
- Simplified interface
- Visual programming blocks
- Step-by-step execution
- Built-in tutorials
- Progress tracking
- Parent/teacher dashboard

---

## Phase 6: Ecosystem & Community

### 6.1 Documentation Site

**docs.nextgen-languages.dev:**
- Language guides
- API reference
- Tutorials
- Examples
- Blog
- Community showcase

### 6.2 Package Registry

**packages.nextgen-languages.dev:**
- Package search
- Documentation hosting
- Download statistics
- Security advisories
- Featured packages

### 6.3 Learning Platform

**learn.nextgen-languages.dev:**
- Interactive courses
- Exercises
- Projects
- Certificates
- Progress tracking
- Classroom features

---

## Timeline (Milestones, Not Dates)

```
M1: Foundation Complete
    - All repos consolidated on GitHub
    - Wiki structure complete
    - Basic tooling templates

M2: First Language Complete
    - One language fully implemented (recommend: Solo)
    - Lexer, parser, interpreter, REPL
    - Basic LSP support
    - Initial standard library

M3: My-Language Family Complete
    - Me, Solo, Duet, Ensemble all functional
    - Progressive complexity working
    - Educational features implemented

M4: Specialized Languages
    - betlang, julia-the-viper stable
    - Phronesis, Eclexia initial release
    - Oblíbený, Anvomidav, WokeLang planned

M5: Tooling Ecosystem
    - Full LSP for all languages
    - Package manager operational
    - Build system stable
    - Web playground live

M6: Production Ready
    - All languages stable
    - Documentation complete
    - Community established
    - Real-world usage

```

---

## Success Metrics

| Metric | Target |
|--------|--------|
| Languages with working interpreter | 8/8 |
| Languages with REPL | 8/8 |
| Languages with LSP | 8/8 |
| Test coverage | >80% |
| Documentation coverage | 100% |
| Package registry packages | 100+ |
| Community contributors | 50+ |
| Educational users | 1000+ |

---

## Contributing

See `CONTRIBUTING.md` for how to get involved with language development.

See `CLAUDE-INSTRUCTIONS.md` for AI assistant guidelines.
