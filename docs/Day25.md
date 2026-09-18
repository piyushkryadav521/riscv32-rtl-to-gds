# Day 25 — CPU-Level Verification & Regression Testing

## Objective

The objective of Day 25 was to verify the complete RV32I CPU at the system level.

Unlike previous module-level verification, Day 25 tested the interaction between the processor's datapath, control logic, register file, ALU, memory, branch unit, and program counter.

---

## Verification Scope

The following CPU functionality was verified:

- Immediate arithmetic
- R-Type arithmetic
- Logical operations
- Load/store operations
- Conditional branch
- Jump and link
- Register write-back
- Data memory access
- x0 protection
- Program counter progression

---

## CPU Regression Program

The test program executed the following instructions:

| Step | Instruction | Purpose |
|------|-------------|---------|
| 1 | ADDI x5, x0, 10 | Initialize x5 |
| 2 | ADDI x6, x0, 20 | Initialize x6 |
| 3 | ADD x7, x5, x6 | Arithmetic |
| 4 | SUB x8, x7, x5 | Arithmetic |
| 5 | AND x9, x7, x6 | Logical AND |
| 6 | OR x10, x5, x6 | Logical OR |
| 7 | SW x7, 0(x0) | Store result |
| 8 | LW x11, 0(x0) | Load result |
| 9 | BEQ x11, x7, +8 | Conditional branch |
| 10 | ADDI x12, x0, 99 | Skipped |
| 11 | ADDI x12, x0, 55 | Branch target |
| 12 | JAL x13, +8 | Jump and link |
| 13 | ADDI x14, x0, 99 | Skipped |
| 14 | ADDI x14, x0, 88 | Jump target |
| 15 | NOP | End of program |

---

## Register Verification

The final register values were checked automatically.

| Register | Expected | Result |
|----------|---------:|--------|
| x5 | 10 | PASS |
| x6 | 20 | PASS |
| x7 | 30 | PASS |
| x8 | 20 | PASS |
| x9 | 20 | PASS |
| x10 | 30 | PASS |
| x11 | 30 | PASS |
| x12 | 55 | PASS |
| x13 | 48 | PASS |
| x14 | 88 | PASS |

---

## Memory Verification

The store/load path was verified.

```text
Memory[0] = 30