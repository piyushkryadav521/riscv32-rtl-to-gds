# Day 13 – Data Memory Implementation and Verification

## Objective

The objective of Day 13 was to implement and verify the Data Memory module for the 32-bit RISC-V RV32I processor.

Data Memory is required for load and store instructions:

- LW – Load Word
- SW – Store Word

---

## Data Memory Architecture

The Data Memory contains:

- 256 memory locations
- Each location stores 32 bits
- Total capacity = 256 × 32 bits
- Word-aligned addressing

The memory is accessed using:

```text
address[9:2]