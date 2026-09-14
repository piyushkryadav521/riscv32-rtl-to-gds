# Day 10 – ALU Verification

## Objective

Perform complete functional verification of the Arithmetic Logic Unit (ALU) before integrating it into the RV32I processor datapath.

## ALU Overview

The ALU performs arithmetic and logical operations required by the processor.

The current ALU supports:

| Operation | ALU Control |
|-----------|-------------|
| ADD | 0000 |
| SUB | 0001 |
| AND | 0010 |
| OR  | 0011 |
| XOR | 0100 |
| SLT | 0101 |

The ALU also generates a `zero` flag.

## ALU Interface

```text
             ┌───────────────────┐
      a ────►│                   │
      b ────►│       ALU         │────► result
alu_control ─►│                   │────► zero
             └───────────────────┘