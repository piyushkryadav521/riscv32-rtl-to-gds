# Day 21 – Branch and Jump Integration

## Objective

The objective of Day 21 was to verify the integration of control-flow instructions in the RV32I single-cycle CPU.

The verification focused on:

- BEQ – Branch if Equal
- BNE – Branch if Not Equal
- JAL – Jump and Link
- Branch target calculation
- Jump target calculation
- PC update
- JAL return-address write-back
- Skipping instructions after taken branches and jumps

---

## Instructions Tested

| Instruction | Purpose | Expected Result |
|---|---|---|
| ADDI x5, x0, 10 | Initialize x5 | x5 = 10 |
| ADDI x6, x0, 10 | Initialize x6 | x6 = 10 |
| BEQ x5, x6, +8 | Equal comparison | Branch taken |
| ADDI x7, x0, 99 | Branch-skipped instruction | Not executed |
| ADDI x7, x0, 77 | Branch target | x7 = 77 |
| BNE x5, x6, +8 | Not-equal comparison | Branch not taken |
| ADDI x8, x0, 55 | Sequential execution | x8 = 55 |
| JAL x9, +8 | Jump and link | x9 = PC + 4 |
| ADDI x10, x0, 99 | Jump-skipped instruction | Not executed |
| ADDI x10, x0, 88 | Jump target | x10 = 88 |

---

## Branch Operation

The Branch Unit compares the two source registers.

For BEQ:

```text
rs1 == rs2
     ↓
BranchTaken = 1
     ↓
PC = PC + immediate