# Day 14 – Branch Unit Implementation and Verification

## Objective

The objective of Day 14 was to implement and verify the Branch Unit for the 32-bit RISC-V RV32I processor.

The Branch Unit determines whether a conditional branch should be taken based on the values of two registers and the `funct3` field.

Supported branch instructions:

- BEQ – Branch if Equal
- BNE – Branch if Not Equal

---

## Branch Unit Architecture

The Branch Unit receives:

- `rs1_data`
- `rs2_data`
- `funct3`
- `branch`

and generates:

- `branch_taken`

```text
rs1_data ─────┐
              │
rs2_data ─────┼──► Branch Unit ───► branch_taken
              │
funct3 ───────┤
              │
branch ───────┘