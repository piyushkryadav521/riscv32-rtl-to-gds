# Day 19 – Immediate Generator + Control Unit Integration

## Objective

The objective of Day 19 was to verify the integration of the Immediate Generator and Control Unit with the complete RV32I CPU datapath.

The verification covered:

- I-Type arithmetic instructions
- Immediate generation
- Load instruction (LW)
- Store instruction (SW)
- Conditional branches (BEQ and BNE)
- Control signal generation
- ALU interaction
- Memory interaction
- Branch decision and PC update
- Write-back operation

---

## Instructions Tested

| Instruction | Purpose | Expected Result |
|------------|---------|-----------------|
| ADDI x5, x0, 25 | Immediate ALU operation | x5 = 25 |
| ADDI x6, x0, 15 | Immediate ALU operation | x6 = 15 |
| ANDI x7, x5, 15 | Immediate AND | x7 = 9 |
| ORI x8, x6, 16 | Immediate OR | x8 = 31 |
| SW x8, 0(x0) | Store to memory | Memory[0] = 31 |
| LW x9, 0(x0) | Load from memory | x9 = 31 |
| BEQ x9, x8, +8 | Conditional branch | Branch taken |
| ADDI x10, x0, 77 | Branch target instruction | x10 = 77 |
| BNE x5, x6, +8 | Conditional branch | Branch taken |
| ADDI x11, x0, 66 | Branch target instruction | x11 = 66 |

---

## Integration Flow

The instruction execution flow verified on Day 19 was:

```text
Instruction Memory
        |
        v
Instruction Decoder
        |
        +--------------------+
        |                    |
        v                    v
Immediate Generator     Control Unit
        |                    |
        +---------+----------+
                  |
                  v
             ALU / Memory
                  |
                  v
              Write Back

For Branch:
Register File → Branch Unit → Next PC