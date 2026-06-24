<!--
SPDX-License-Identifier: CC-BY-SA-4.0
Copyright (c) Jonathan D.A. Jewell <j.d.a.jewell@open.ac.uk>
-->
# Compiler Pipeline

The NextGen Languages share a common compiler architecture with language-specific frontends and multiple backend targets.

## Architecture Overview

```
                    ┌─────────────────────────────────────┐
                    │         LANGUAGE FRONTENDS          │
                    ├─────┬─────┬─────┬─────┬─────┬──────┤
                    │ Me  │Solo │Duet │Ens. │bet  │ JtV  │
                    │     │     │     │     │lang │      │
                    └──┬──┴──┬──┴──┬──┴──┬──┴──┬──┴──┬───┘
                       │     │     │     │     │     │
                       ▼     ▼     ▼     ▼     ▼     ▼
                    ┌─────────────────────────────────────┐
                    │              NEXTGEN IR             │
                    │     (Shared Intermediate Repr.)     │
                    └─────────────────┬───────────────────┘
                                      │
                    ┌─────────────────┼───────────────────┐
                    │                 │                   │
                    ▼                 ▼                   ▼
            ┌───────────┐     ┌───────────┐       ┌───────────┐
            │   LLVM    │     │   WASM    │       │  Interp.  │
            │  Backend  │     │  Backend  │       │  Backend  │
            └─────┬─────┘     └─────┬─────┘       └─────┬─────┘
                  │                 │                   │
                  ▼                 ▼                   ▼
            ┌───────────┐     ┌───────────┐       ┌───────────┐
            │  Native   │     │  Browser  │       │   REPL    │
            │  Binary   │     │   / WASI  │       │           │
            └───────────┘     └───────────┘       └───────────┘
```

## Compilation Phases

### Phase 1: Frontend (Per-Language)

```
Source Code
     │
     ├──► Lexer ──► Token Stream
     │
     ├──► Parser ──► AST
     │
     ├──► Name Resolution ──► Bound AST
     │
     ├──► Type Inference ──► Typed AST
     │
     └──► Desugaring ──► Core AST
```

### Phase 2: Middle-End (Shared)

```
Core AST
     │
     ├──► IR Generation ──► NextGen IR
     │
     ├──► Optimization Passes
     │    ├── Constant folding
     │    ├── Dead code elimination
     │    ├── Inlining
     │    ├── Common subexpression elimination
     │    └── Loop optimization
     │
     └──► Verification (Echidna)
          ├── Type soundness check
          ├── Memory safety check
          └── Termination check (where applicable)
```

### Phase 3: Backend (Target-Specific)

```
Optimized IR
     │
     ├──► LLVM Backend
     │    ├── LLVM IR generation
     │    ├── LLVM optimization passes
     │    └── Native code generation
     │
     ├──► WASM Backend
     │    ├── WASM instruction selection
     │    ├── Linear memory layout
     │    └── .wasm binary generation
     │
     └──► Interpreter Backend
          └── Direct execution
```

## NextGen IR

### IR Design

```rust
// NextGen Intermediate Representation
pub enum Instruction {
    // Constants
    Const(Value),

    // Variables
    Load(VarId),
    Store(VarId, Box<Instruction>),

    // Arithmetic
    Add(Box<Instruction>, Box<Instruction>),
    Sub(Box<Instruction>, Box<Instruction>),
    Mul(Box<Instruction>, Box<Instruction>),
    Div(Box<Instruction>, Box<Instruction>),

    // Comparison
    Eq(Box<Instruction>, Box<Instruction>),
    Lt(Box<Instruction>, Box<Instruction>),

    // Control Flow
    If {
        cond: Box<Instruction>,
        then_block: BlockId,
        else_block: BlockId,
    },
    Jump(BlockId),
    Return(Option<Box<Instruction>>),

    // Functions
    Call {
        func: FuncId,
        args: Vec<Instruction>,
    },

    // Memory
    Alloc(TypeId),
    Free(Box<Instruction>),
    Read(Box<Instruction>),
    Write(Box<Instruction>, Box<Instruction>),

    // Effects (for effect-aware languages)
    Perform {
        effect: EffectId,
        args: Vec<Instruction>,
    },
    Handle {
        body: BlockId,
        handlers: Vec<(EffectId, BlockId)>,
    },
}

pub struct Function {
    name: String,
    params: Vec<(VarId, TypeId)>,
    return_type: TypeId,
    blocks: Vec<Block>,
    effects: Vec<EffectId>,
}

pub struct Block {
    id: BlockId,
    instructions: Vec<Instruction>,
    terminator: Terminator,
}
```

### Type Information in IR

```rust
pub enum IRType {
    // Primitives
    I8, I16, I32, I64,
    U8, U16, U32, U64,
    F32, F64,
    Bool,
    Unit,

    // Compound
    Ptr(Box<IRType>),
    Array(Box<IRType>, usize),
    Struct(Vec<(String, IRType)>),
    Function {
        params: Vec<IRType>,
        returns: Box<IRType>,
        effects: Vec<EffectId>,
    },

    // Linear types (for AffineScript, Ephapax)
    Linear(Box<IRType>),
    Affine(Box<IRType>),
}
```

## Optimization Passes

### Constant Folding

```rust
fn fold_constants(ir: &mut Instruction) {
    match ir {
        Instruction::Add(l, r) => {
            if let (Instruction::Const(Value::Int(a)),
                    Instruction::Const(Value::Int(b))) = (l.as_ref(), r.as_ref()) {
                *ir = Instruction::Const(Value::Int(a + b));
            }
        }
        // ... other operations
    }
}

// Before: Add(Const(2), Const(3))
// After:  Const(5)
```

### Dead Code Elimination

```rust
fn eliminate_dead_code(func: &mut Function) {
    let live = compute_live_instructions(func);
    for block in &mut func.blocks {
        block.instructions.retain(|inst| live.contains(&inst.id));
    }
}
```

### Inlining

```rust
fn should_inline(callee: &Function) -> bool {
    callee.blocks.len() == 1
        && callee.blocks[0].instructions.len() < INLINE_THRESHOLD
        && !callee.is_recursive()
}

fn inline_call(caller: &mut Function, call_site: InstrId, callee: &Function) {
    // Replace call with inlined body
    // Rename variables to avoid conflicts
    // Handle return value
}
```

## Backend: LLVM

### LLVM IR Generation

```rust
impl LLVMBackend {
    fn compile_function(&mut self, func: &Function) -> LLVMValueRef {
        let llvm_func = self.declare_function(func);
        let entry = self.append_basic_block(llvm_func, "entry");
        self.builder.position_at_end(entry);

        for block in &func.blocks {
            self.compile_block(block);
        }

        llvm_func
    }

    fn compile_instruction(&mut self, inst: &Instruction) -> LLVMValueRef {
        match inst {
            Instruction::Const(Value::Int(n)) =>
                self.const_int(self.i64_type(), *n as u64, true),

            Instruction::Add(l, r) => {
                let lhs = self.compile_instruction(l);
                let rhs = self.compile_instruction(r);
                self.builder.build_add(lhs, rhs, "add")
            }

            Instruction::Call { func, args } => {
                let callee = self.get_function(*func);
                let args: Vec<_> = args.iter()
                    .map(|a| self.compile_instruction(a))
                    .collect();
                self.builder.build_call(callee, &args, "call")
            }

            // ... more cases
        }
    }
}
```

### LLVM Optimization

```rust
fn optimize_module(&self, module: LLVMModuleRef) {
    let pm = LLVMCreatePassManager();

    // Add optimization passes
    LLVMAddPromoteMemoryToRegisterPass(pm);
    LLVMAddInstructionCombiningPass(pm);
    LLVMAddReassociatePass(pm);
    LLVMAddGVNPass(pm);
    LLVMAddCFGSimplificationPass(pm);
    LLVMAddTailCallEliminationPass(pm);

    LLVMRunPassManager(pm, module);
}
```

## Backend: WebAssembly

### WASM Code Generation

```rust
impl WASMBackend {
    fn compile_function(&mut self, func: &Function) -> wasm::Function {
        let mut wasm_func = wasm::Function::new(
            self.convert_type(&func.return_type),
            func.params.iter()
                .map(|(_, ty)| self.convert_type(ty))
                .collect(),
        );

        for block in &func.blocks {
            self.compile_block(&mut wasm_func, block);
        }

        wasm_func
    }

    fn compile_instruction(&mut self, func: &mut wasm::Function, inst: &Instruction) {
        match inst {
            Instruction::Const(Value::Int(n)) => {
                func.emit(wasm::I64_CONST(*n));
            }

            Instruction::Add(l, r) => {
                self.compile_instruction(func, l);
                self.compile_instruction(func, r);
                func.emit(wasm::I64_ADD);
            }

            Instruction::If { cond, then_block, else_block } => {
                self.compile_instruction(func, cond);
                func.emit(wasm::IF(wasm::BlockType::Empty));
                self.compile_block(func, then_block);
                func.emit(wasm::ELSE);
                self.compile_block(func, else_block);
                func.emit(wasm::END);
            }

            // ... more cases
        }
    }
}
```

### WASM Linear Memory

```rust
fn layout_memory(&mut self, program: &Program) -> MemoryLayout {
    let mut layout = MemoryLayout::new();

    // Stack grows down from high address
    layout.stack_pointer = MEMORY_SIZE - STACK_SIZE;

    // Heap grows up from low address
    layout.heap_start = DATA_SECTION_END;
    layout.heap_pointer = layout.heap_start;

    // Static data at fixed addresses
    for global in &program.globals {
        layout.globals.insert(global.name.clone(), layout.data_pointer);
        layout.data_pointer += global.ty.size();
    }

    layout
}
```

## Backend: Interpreter

### Tree-Walking Interpreter

```rust
impl Interpreter {
    fn eval(&mut self, expr: &Expr) -> Value {
        match expr {
            Expr::Int(n) => Value::Int(*n),
            Expr::Bool(b) => Value::Bool(*b),

            Expr::Var(name) => self.env.get(name).clone(),

            Expr::Binary { op, left, right } => {
                let l = self.eval(left);
                let r = self.eval(right);
                self.eval_binary(*op, l, r)
            }

            Expr::If { cond, then_branch, else_branch } => {
                if self.eval(cond).as_bool() {
                    self.eval(then_branch)
                } else if let Some(else_) = else_branch {
                    self.eval(else_)
                } else {
                    Value::Unit
                }
            }

            Expr::Call { callee, args } => {
                let func = self.eval(callee).as_function();
                let args: Vec<_> = args.iter().map(|a| self.eval(a)).collect();
                self.call_function(func, args)
            }
        }
    }
}
```

### Bytecode Interpreter

```rust
enum OpCode {
    CONST(u16),     // Push constant from pool
    LOAD(u16),      // Load local variable
    STORE(u16),     // Store local variable
    ADD, SUB, MUL, DIV,
    EQ, LT, GT,
    JUMP(u16),      // Unconditional jump
    JUMP_IF(u16),   // Jump if top of stack is true
    CALL(u16),      // Call function
    RET,            // Return from function
}

impl VM {
    fn execute(&mut self, code: &[OpCode]) -> Value {
        loop {
            let op = &code[self.ip];
            self.ip += 1;

            match op {
                OpCode::CONST(idx) => {
                    self.stack.push(self.constants[*idx as usize].clone());
                }
                OpCode::ADD => {
                    let b = self.stack.pop().as_int();
                    let a = self.stack.pop().as_int();
                    self.stack.push(Value::Int(a + b));
                }
                OpCode::JUMP(addr) => {
                    self.ip = *addr as usize;
                }
                OpCode::RET => {
                    return self.stack.pop();
                }
                // ... more opcodes
            }
        }
    }
}
```

## Per-Language Targets

| Language | Primary Target | Secondary |
|----------|----------------|-----------|
| Me | Interpreter | WASM (playground) |
| Solo | Interpreter | WASM |
| Duet | Bytecode VM | WASM |
| Ensemble | LLVM | WASM, JVM |
| betlang | Racket | - |
| jtv | LLVM | Native |
| Phronesis | BEAM VM | - |
| Eclexia | LLVM | WASM |
| Oblíbený | LLVM | Native |
| Anvomidav | LLVM (RT) | Native |
| WokeLang | Bytecode | WASM |
| AffineScript | WASM | - |
| Ephapax | Interpreter | - |

## Build Commands

```bash
# Compile to native binary
nextgen build --target native src/main.ng

# Compile to WebAssembly
nextgen build --target wasm src/main.ng

# Compile with optimizations
nextgen build --release src/main.ng

# Emit LLVM IR
nextgen build --emit llvm-ir src/main.ng

# Emit NextGen IR
nextgen build --emit ir src/main.ng

# Cross-compile
nextgen build --target aarch64-linux src/main.ng
```

## Echidna Verification Integration

```
Typed AST
     │
     ├──► Extract specifications
     │
     ├──► Generate proof obligations
     │
     ├──► Send to Echidna
     │    ├── Type soundness ──► Agda/Coq
     │    ├── Memory safety ──► Z3/CVC5
     │    └── Termination ──► ACL2
     │
     └──► Verify certificates
          └── Embed proofs in binary (optional)
```

## Related Pages

- [[Lexer Design]]
- [[Parser Architecture]]
- [[Testing Framework]]
- [[LLVM Backend]]
- [[WASM Backend]]
