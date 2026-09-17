# Day 23 — Basic Program Execution

## Objective

Execute a complete RV32I instruction sequence on the integrated single-cycle CPU and verify the complete instruction execution flow from fetch to write-back.

## Work Completed

Updated:

- `rtl/instruction_memory.v`

Created:

- `tb/riscv_cpu_day23_tb.v`

A dedicated Day 23 program was loaded into instruction memory.

## Program Instructions

The program verifies:

- ADDI
- ADD
- SUB
- AND
- OR
- SW
- LW
- BEQ
- JAL
- NOP

## Execution Flow

```text
Instruction Memory
        |
        v
Instruction Decode
        |
        v
Register File
        |
        +------> Immediate Generator
        |
        v
Control Unit
        |
        v
ALU / Memory
        |
        v
Write Back
        |
        v
Program Counter Update