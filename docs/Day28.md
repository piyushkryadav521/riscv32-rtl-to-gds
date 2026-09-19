# Day 28 — Branch and Jump Verification

## Objective

The objective of Day 28 was to verify control-flow instructions at the CPU level.

The following instructions were tested:

- BEQ
- BNE
- JAL
- Branch taken
- Branch not taken
- Jump target calculation
- JAL return-address write-back
- Skipped instructions
- PC control

---

## Test Program

| PC | Instruction | Expected Behavior |
|----|-------------|-------------------|
| 0x00 | ADDI x5, x0, 10 | x5 = 10 |
| 0x04 | ADDI x6, x0, 10 | x6 = 10 |
| 0x08 | BEQ x5, x6, +8 | Branch taken |
| 0x0C | ADDI x7, x0, 99 | Skipped |
| 0x10 | ADDI x7, x0, 77 | x7 = 77 |
| 0x14 | ADDI x8, x0, 20 | x8 = 20 |
| 0x18 | BNE x5, x6, +8 | Not taken |
| 0x1C | ADDI x9, x0, 55 | x9 = 55 |
| 0x20 | ADDI x10, x0, 25 | x10 = 25 |
| 0x24 | ADDI x11, x0, 30 | x11 = 30 |
| 0x28 | BNE x5, x8, +8 | Branch taken |
| 0x2C | ADDI x12, x0, 99 | Skipped |
| 0x30 | ADDI x12, x0, 66 | x12 = 66 |
| 0x34 | JAL x13, +8 | Jump to 0x3C |
| 0x38 | ADDI x14, x0, 99 | Skipped |
| 0x3C | ADDI x14, x0, 88 | x14 = 88 |
| 0x40 | NOP | No register change |

---

## BEQ Verification

At PC `0x08`:

```text
BEQ x5, x6, +8