# Interpreter Implementation

Interpreters provide direct execution of source code, essential for REPLs, scripting, and educational environments.

## Interpreter Types

### Tree-Walking Interpreter

Directly traverses and evaluates the AST:

```
Source → Parse → AST → Walk & Evaluate → Result
```

**Pros:** Simple, easy to debug, good error messages
**Cons:** Slower, redundant parsing on loops

**Best for:** Me, Solo, educational contexts

### Bytecode Interpreter

Compiles to bytecode, then executes:

```
Source → Parse → AST → Compile → Bytecode → VM Execute → Result
```

**Pros:** Faster, portable bytecode
**Cons:** More complex, separate compilation step

**Best for:** Duet, Ensemble, WokeLang

### JIT Compilation

Compiles hot paths to native code:

```
Source → Parse → AST → Bytecode → Interpret/JIT → Result
```

**Pros:** Near-native performance
**Cons:** Complex, longer startup

**Best for:** Production Ensemble, long-running programs

## Tree-Walking Implementation

### Core Evaluator

```rust
pub struct Interpreter {
    env: Environment,
    globals: Environment,
}

impl Interpreter {
    pub fn new() -> Self {
        let mut globals = Environment::new();
        // Register built-in functions
        globals.define("print", Value::BuiltinFn(builtin_print));
        globals.define("len", Value::BuiltinFn(builtin_len));
        globals.define("type", Value::BuiltinFn(builtin_type));

        Self {
            env: globals.clone(),
            globals,
        }
    }

    pub fn eval(&mut self, expr: &Expr) -> Result<Value, RuntimeError> {
        match expr {
            // Literals
            Expr::Int(n) => Ok(Value::Int(*n)),
            Expr::Float(f) => Ok(Value::Float(*f)),
            Expr::String(s) => Ok(Value::String(s.clone())),
            Expr::Bool(b) => Ok(Value::Bool(*b)),
            Expr::Nil => Ok(Value::Nil),

            // Variables
            Expr::Var(name) => self.env.get(name)
                .ok_or_else(|| RuntimeError::UndefinedVariable(name.clone())),

            // Binary operations
            Expr::Binary { op, left, right } => {
                let l = self.eval(left)?;
                let r = self.eval(right)?;
                self.eval_binary(*op, l, r)
            }

            // Unary operations
            Expr::Unary { op, operand } => {
                let v = self.eval(operand)?;
                self.eval_unary(*op, v)
            }

            // Control flow
            Expr::If { condition, then_branch, else_branch } => {
                let cond = self.eval(condition)?;
                if cond.is_truthy() {
                    self.eval(then_branch)
                } else if let Some(else_) = else_branch {
                    self.eval(else_)
                } else {
                    Ok(Value::Nil)
                }
            }

            // Blocks
            Expr::Block(stmts) => {
                self.env.push_scope();
                let mut result = Value::Nil;
                for stmt in stmts {
                    result = self.exec(stmt)?;
                }
                self.env.pop_scope();
                Ok(result)
            }

            // Functions
            Expr::Lambda { params, body } => {
                Ok(Value::Function {
                    params: params.clone(),
                    body: body.clone(),
                    closure: self.env.clone(),
                })
            }

            Expr::Call { callee, args } => {
                let func = self.eval(callee)?;
                let args: Vec<Value> = args.iter()
                    .map(|a| self.eval(a))
                    .collect::<Result<_, _>>()?;
                self.call(func, args)
            }
        }
    }

    fn eval_binary(&self, op: BinaryOp, left: Value, right: Value) -> Result<Value, RuntimeError> {
        use BinaryOp::*;
        use Value::*;

        match (op, left, right) {
            // Arithmetic
            (Add, Int(a), Int(b)) => Ok(Int(a + b)),
            (Add, Float(a), Float(b)) => Ok(Float(a + b)),
            (Add, String(a), String(b)) => Ok(String(a + &b)),

            (Sub, Int(a), Int(b)) => Ok(Int(a - b)),
            (Sub, Float(a), Float(b)) => Ok(Float(a - b)),

            (Mul, Int(a), Int(b)) => Ok(Int(a * b)),
            (Mul, Float(a), Float(b)) => Ok(Float(a * b)),

            (Div, Int(a), Int(b)) if b != 0 => Ok(Int(a / b)),
            (Div, _, Int(0)) => Err(RuntimeError::DivisionByZero),
            (Div, Float(a), Float(b)) => Ok(Float(a / b)),

            // Comparison
            (Eq, a, b) => Ok(Bool(a == b)),
            (Ne, a, b) => Ok(Bool(a != b)),
            (Lt, Int(a), Int(b)) => Ok(Bool(a < b)),
            (Le, Int(a), Int(b)) => Ok(Bool(a <= b)),
            (Gt, Int(a), Int(b)) => Ok(Bool(a > b)),
            (Ge, Int(a), Int(b)) => Ok(Bool(a >= b)),

            // Logical
            (And, Bool(a), Bool(b)) => Ok(Bool(a && b)),
            (Or, Bool(a), Bool(b)) => Ok(Bool(a || b)),

            // Type mismatch
            (op, l, r) => Err(RuntimeError::TypeMismatch {
                op,
                left: l.type_name(),
                right: r.type_name(),
            }),
        }
    }

    fn call(&mut self, callee: Value, args: Vec<Value>) -> Result<Value, RuntimeError> {
        match callee {
            Value::Function { params, body, closure } => {
                if params.len() != args.len() {
                    return Err(RuntimeError::ArityMismatch {
                        expected: params.len(),
                        got: args.len(),
                    });
                }

                // Create new environment with closure as parent
                let mut call_env = closure.clone();
                call_env.push_scope();

                // Bind parameters
                for (param, arg) in params.iter().zip(args) {
                    call_env.define(&param.name, arg);
                }

                // Save current environment, execute body, restore
                let prev_env = std::mem::replace(&mut self.env, call_env);
                let result = self.eval(&body);
                self.env = prev_env;

                result
            }

            Value::BuiltinFn(func) => func(args),

            _ => Err(RuntimeError::NotCallable(callee.type_name())),
        }
    }
}
```

### Environment

```rust
#[derive(Clone)]
pub struct Environment {
    scopes: Vec<HashMap<String, Value>>,
}

impl Environment {
    pub fn new() -> Self {
        Self { scopes: vec![HashMap::new()] }
    }

    pub fn push_scope(&mut self) {
        self.scopes.push(HashMap::new());
    }

    pub fn pop_scope(&mut self) {
        self.scopes.pop();
    }

    pub fn define(&mut self, name: &str, value: Value) {
        if let Some(scope) = self.scopes.last_mut() {
            scope.insert(name.to_string(), value);
        }
    }

    pub fn get(&self, name: &str) -> Option<Value> {
        for scope in self.scopes.iter().rev() {
            if let Some(value) = scope.get(name) {
                return Some(value.clone());
            }
        }
        None
    }

    pub fn set(&mut self, name: &str, value: Value) -> Result<(), RuntimeError> {
        for scope in self.scopes.iter_mut().rev() {
            if scope.contains_key(name) {
                scope.insert(name.to_string(), value);
                return Ok(());
            }
        }
        Err(RuntimeError::UndefinedVariable(name.to_string()))
    }
}
```

## Bytecode Interpreter

### Bytecode Format

```rust
#[repr(u8)]
pub enum OpCode {
    // Stack operations
    Const = 0x00,       // Push constant: CONST <idx:u16>
    Pop = 0x01,         // Pop top of stack
    Dup = 0x02,         // Duplicate top

    // Local variables
    GetLocal = 0x10,    // Push local: GET_LOCAL <slot:u8>
    SetLocal = 0x11,    // Set local: SET_LOCAL <slot:u8>

    // Global variables
    GetGlobal = 0x12,   // Push global: GET_GLOBAL <idx:u16>
    SetGlobal = 0x13,   // Set global: SET_GLOBAL <idx:u16>

    // Arithmetic
    Add = 0x20,
    Sub = 0x21,
    Mul = 0x22,
    Div = 0x23,
    Neg = 0x24,

    // Comparison
    Eq = 0x30,
    Ne = 0x31,
    Lt = 0x32,
    Le = 0x33,
    Gt = 0x34,
    Ge = 0x35,

    // Logical
    Not = 0x40,

    // Control flow
    Jump = 0x50,        // Unconditional: JUMP <offset:i16>
    JumpIfFalse = 0x51, // Conditional: JUMP_IF_FALSE <offset:i16>
    Loop = 0x52,        // Loop back: LOOP <offset:u16>

    // Functions
    Call = 0x60,        // Call function: CALL <arity:u8>
    Return = 0x61,      // Return from function

    // Objects
    GetProperty = 0x70, // GET_PROPERTY <name_idx:u16>
    SetProperty = 0x71, // SET_PROPERTY <name_idx:u16>

    // Arrays
    NewArray = 0x80,    // NEW_ARRAY <size:u16>
    GetIndex = 0x81,    // Get array element
    SetIndex = 0x82,    // Set array element
}
```

### Chunk (Compiled Code)

```rust
pub struct Chunk {
    code: Vec<u8>,
    constants: Vec<Value>,
    lines: Vec<usize>,  // Line number for each byte
}

impl Chunk {
    pub fn new() -> Self {
        Self {
            code: vec![],
            constants: vec![],
            lines: vec![],
        }
    }

    pub fn write(&mut self, byte: u8, line: usize) {
        self.code.push(byte);
        self.lines.push(line);
    }

    pub fn add_constant(&mut self, value: Value) -> u16 {
        self.constants.push(value);
        (self.constants.len() - 1) as u16
    }

    pub fn write_constant(&mut self, value: Value, line: usize) {
        let idx = self.add_constant(value);
        self.write(OpCode::Const as u8, line);
        self.write((idx >> 8) as u8, line);
        self.write((idx & 0xFF) as u8, line);
    }
}
```

### Virtual Machine

```rust
const STACK_MAX: usize = 256;
const FRAMES_MAX: usize = 64;

pub struct VM {
    chunk: Chunk,
    ip: usize,
    stack: Vec<Value>,
    frames: Vec<CallFrame>,
    globals: HashMap<String, Value>,
}

pub struct CallFrame {
    function: Function,
    ip: usize,
    slots_start: usize,
}

impl VM {
    pub fn new(chunk: Chunk) -> Self {
        Self {
            chunk,
            ip: 0,
            stack: Vec::with_capacity(STACK_MAX),
            frames: Vec::with_capacity(FRAMES_MAX),
            globals: HashMap::new(),
        }
    }

    pub fn run(&mut self) -> Result<Value, RuntimeError> {
        loop {
            let instruction = self.read_byte();

            match instruction {
                OpCode::Const => {
                    let idx = self.read_u16();
                    let value = self.chunk.constants[idx as usize].clone();
                    self.push(value);
                }

                OpCode::Add => {
                    let b = self.pop();
                    let a = self.pop();
                    match (a, b) {
                        (Value::Int(x), Value::Int(y)) => self.push(Value::Int(x + y)),
                        (Value::Float(x), Value::Float(y)) => self.push(Value::Float(x + y)),
                        (Value::String(x), Value::String(y)) => self.push(Value::String(x + &y)),
                        _ => return Err(RuntimeError::TypeMismatch),
                    }
                }

                OpCode::Sub => {
                    let b = self.pop();
                    let a = self.pop();
                    match (a, b) {
                        (Value::Int(x), Value::Int(y)) => self.push(Value::Int(x - y)),
                        (Value::Float(x), Value::Float(y)) => self.push(Value::Float(x - y)),
                        _ => return Err(RuntimeError::TypeMismatch),
                    }
                }

                OpCode::Mul => { /* similar */ }
                OpCode::Div => { /* similar, with zero check */ }

                OpCode::Neg => {
                    let v = self.pop();
                    match v {
                        Value::Int(n) => self.push(Value::Int(-n)),
                        Value::Float(f) => self.push(Value::Float(-f)),
                        _ => return Err(RuntimeError::TypeMismatch),
                    }
                }

                OpCode::Eq => {
                    let b = self.pop();
                    let a = self.pop();
                    self.push(Value::Bool(a == b));
                }

                OpCode::Lt => {
                    let b = self.pop();
                    let a = self.pop();
                    match (a, b) {
                        (Value::Int(x), Value::Int(y)) => self.push(Value::Bool(x < y)),
                        (Value::Float(x), Value::Float(y)) => self.push(Value::Bool(x < y)),
                        _ => return Err(RuntimeError::TypeMismatch),
                    }
                }

                OpCode::Not => {
                    let v = self.pop();
                    self.push(Value::Bool(!v.is_truthy()));
                }

                OpCode::Jump => {
                    let offset = self.read_i16();
                    self.ip = (self.ip as isize + offset as isize) as usize;
                }

                OpCode::JumpIfFalse => {
                    let offset = self.read_i16();
                    if !self.peek(0).is_truthy() {
                        self.ip = (self.ip as isize + offset as isize) as usize;
                    }
                }

                OpCode::Loop => {
                    let offset = self.read_u16();
                    self.ip -= offset as usize;
                }

                OpCode::GetLocal => {
                    let slot = self.read_byte() as usize;
                    let frame = self.current_frame();
                    let value = self.stack[frame.slots_start + slot].clone();
                    self.push(value);
                }

                OpCode::SetLocal => {
                    let slot = self.read_byte() as usize;
                    let frame = self.current_frame();
                    self.stack[frame.slots_start + slot] = self.peek(0).clone();
                }

                OpCode::Call => {
                    let arity = self.read_byte() as usize;
                    self.call_value(self.peek(arity).clone(), arity)?;
                }

                OpCode::Return => {
                    let result = self.pop();

                    if self.frames.is_empty() {
                        return Ok(result);
                    }

                    let frame = self.frames.pop().unwrap();
                    self.stack.truncate(frame.slots_start);
                    self.push(result);
                    self.ip = frame.ip;
                }

                OpCode::Pop => {
                    self.pop();
                }

                _ => return Err(RuntimeError::UnknownOpcode(instruction)),
            }
        }
    }

    fn read_byte(&mut self) -> u8 {
        let byte = self.chunk.code[self.ip];
        self.ip += 1;
        byte
    }

    fn read_u16(&mut self) -> u16 {
        let high = self.read_byte() as u16;
        let low = self.read_byte() as u16;
        (high << 8) | low
    }

    fn read_i16(&mut self) -> i16 {
        self.read_u16() as i16
    }

    fn push(&mut self, value: Value) {
        self.stack.push(value);
    }

    fn pop(&mut self) -> Value {
        self.stack.pop().expect("Stack underflow")
    }

    fn peek(&self, distance: usize) -> &Value {
        &self.stack[self.stack.len() - 1 - distance]
    }
}
```

### Compiler (AST to Bytecode)

```rust
pub struct Compiler {
    chunk: Chunk,
    locals: Vec<Local>,
    scope_depth: usize,
}

struct Local {
    name: String,
    depth: usize,
}

impl Compiler {
    pub fn compile(&mut self, expr: &Expr) -> Result<(), CompileError> {
        match expr {
            Expr::Int(n) => {
                self.emit_constant(Value::Int(*n));
            }

            Expr::Binary { op, left, right } => {
                self.compile(left)?;
                self.compile(right)?;
                match op {
                    BinaryOp::Add => self.emit(OpCode::Add),
                    BinaryOp::Sub => self.emit(OpCode::Sub),
                    BinaryOp::Mul => self.emit(OpCode::Mul),
                    BinaryOp::Div => self.emit(OpCode::Div),
                    BinaryOp::Eq => self.emit(OpCode::Eq),
                    BinaryOp::Lt => self.emit(OpCode::Lt),
                    // ... more ops
                }
            }

            Expr::If { condition, then_branch, else_branch } => {
                self.compile(condition)?;

                // Jump over then branch if false
                let then_jump = self.emit_jump(OpCode::JumpIfFalse);
                self.emit(OpCode::Pop);

                self.compile(then_branch)?;

                // Jump over else branch
                let else_jump = self.emit_jump(OpCode::Jump);

                self.patch_jump(then_jump);
                self.emit(OpCode::Pop);

                if let Some(else_) = else_branch {
                    self.compile(else_)?;
                }

                self.patch_jump(else_jump);
            }

            Expr::Var(name) => {
                if let Some(slot) = self.resolve_local(name) {
                    self.emit(OpCode::GetLocal);
                    self.emit_byte(slot as u8);
                } else {
                    let idx = self.chunk.add_constant(Value::String(name.clone()));
                    self.emit(OpCode::GetGlobal);
                    self.emit_u16(idx);
                }
            }

            // ... more cases
        }

        Ok(())
    }

    fn emit(&mut self, op: OpCode) {
        self.chunk.write(op as u8, 0); // Line number tracking omitted
    }

    fn emit_constant(&mut self, value: Value) {
        self.chunk.write_constant(value, 0);
    }

    fn emit_jump(&mut self, op: OpCode) -> usize {
        self.emit(op);
        self.emit_byte(0xFF);
        self.emit_byte(0xFF);
        self.chunk.code.len() - 2
    }

    fn patch_jump(&mut self, offset: usize) {
        let jump = self.chunk.code.len() - offset - 2;
        self.chunk.code[offset] = ((jump >> 8) & 0xFF) as u8;
        self.chunk.code[offset + 1] = (jump & 0xFF) as u8;
    }
}
```

## Language-Specific Considerations

### AffineScript Linearity Tracking

```rust
struct AffineInterpreter {
    env: Environment,
    consumed: HashSet<VarId>,  // Track consumed linear values
}

impl AffineInterpreter {
    fn use_linear(&mut self, var: VarId) -> Result<Value, RuntimeError> {
        if self.consumed.contains(&var) {
            return Err(RuntimeError::LinearValueAlreadyConsumed(var));
        }

        let value = self.env.get(var)?;
        if value.is_linear() {
            self.consumed.insert(var);
        }
        Ok(value)
    }

    fn check_all_consumed(&self) -> Result<(), RuntimeError> {
        for (var, value) in &self.env.linear_values() {
            if !self.consumed.contains(var) {
                return Err(RuntimeError::LinearValueNotConsumed(*var));
            }
        }
        Ok(())
    }
}
```

### Ephapax Once-Only Semantics

```rust
struct EphapaxInterpreter {
    env: Environment,
    ephemeral_used: HashSet<VarId>,
}

impl EphapaxInterpreter {
    fn bind_ephemeral(&mut self, name: &str, value: Value) -> VarId {
        let var = self.env.define_ephemeral(name, value);
        var
    }

    fn use_ephemeral(&mut self, var: VarId) -> Result<Value, RuntimeError> {
        if self.ephemeral_used.contains(&var) {
            return Err(RuntimeError::EphemeralAlreadyUsed(var));
        }

        self.ephemeral_used.insert(var);
        let value = self.env.remove(var)?;  // Remove after use
        Ok(value)
    }
}
```

### betlang Probabilistic Evaluation

```rust
struct BetlangInterpreter {
    rng: StdRng,
    env: Environment,
}

impl BetlangInterpreter {
    fn eval_bet(&mut self, bet: &TernaryBet) -> Value {
        let roll: f64 = self.rng.gen();
        let mut cumulative = 0.0;

        for (prob, outcome) in &bet.outcomes {
            cumulative += prob;
            if roll < cumulative {
                return outcome.clone();
            }
        }

        bet.outcomes.last().unwrap().1.clone()
    }

    fn sample(&mut self, bet: &TernaryBet, n: usize) -> Vec<Value> {
        (0..n).map(|_| self.eval_bet(bet)).collect()
    }
}
```

## Performance Optimization

### Inline Caching

```rust
struct InlineCache {
    cached_class: Option<ClassId>,
    cached_offset: Option<usize>,
}

fn get_property_cached(&mut self, obj: &Object, name: &str, cache: &mut InlineCache) -> Value {
    if Some(obj.class) == cache.cached_class {
        // Cache hit - direct access
        return obj.fields[cache.cached_offset.unwrap()].clone();
    }

    // Cache miss - lookup and update cache
    let offset = obj.class.field_offset(name);
    cache.cached_class = Some(obj.class);
    cache.cached_offset = offset;

    obj.fields[offset.unwrap()].clone()
}
```

### NaN Boxing

```rust
// Pack values into 64 bits using NaN boxing
const QNAN: u64 = 0x7ffc_0000_0000_0000;
const TAG_NIL: u64 = 1;
const TAG_FALSE: u64 = 2;
const TAG_TRUE: u64 = 3;

#[derive(Clone, Copy)]
struct NanBoxedValue(u64);

impl NanBoxedValue {
    fn from_float(f: f64) -> Self {
        Self(f.to_bits())
    }

    fn from_int(n: i32) -> Self {
        Self(QNAN | (n as u64))
    }

    fn nil() -> Self {
        Self(QNAN | TAG_NIL)
    }

    fn is_float(&self) -> bool {
        (self.0 & QNAN) != QNAN
    }
}
```

## Related Pages

- [[REPL Guide]]
- [[Compiler Pipeline]]
- [[Performance Tuning]]
- [[Debugging]]
