# Day 15 — RTL Integration Preparation

## Objective

The objective of Day 15 was to prepare all completed RTL modules for integration into a 32-bit RISC-V RV32I single-cycle processor.

Before creating the top-level CPU module, all RTL module interfaces, signal directions, and datapath relationships were reviewed.

## Completed RTL Modules

The following modules are currently available:

1. Program Counter
2. Instruction Memory
3. Instruction Decoder
4. Register File
5. Immediate Generator
6. Control Unit
7. ALU Control
8. ALU
9. Data Memory
10. Branch Unit

## RTL Integration Architecture

The planned processor datapath is:

```text
                    ┌──────────────────┐
                    │ Program Counter  │
                    │       PC         │
                    └────────┬─────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │ Instruction      │
                    │ Memory           │
                    └────────┬─────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │ Instruction      │
                    │ Decoder          │
                    └────────┬─────────┘
                             │
              ┌──────────────┼──────────────┐
              │              │              │
              ▼              ▼              ▼
       ┌────────────┐ ┌────────────┐ ┌────────────┐
       │ Register   │ │ Immediate  │ │ Control    │
       │ File       │ │ Generator  │ │ Unit       │
       └─────┬──────┘ └─────┬──────┘ └─────┬──────┘
             │              │              │
             └──────────────┼──────────────┘
                            ▼
                     ┌────────────┐
                     │    ALU     │
                     └─────┬──────┘
                           │
                    ┌──────┴──────┐
                    ▼             ▼
             ┌────────────┐   ALU Result
             │   Data     │
             │   Memory   │
             └─────┬──────┘
                   │
                   ▼
               Writeback
                   │
                   ▼
              Register File
```

## Module Interface Review

### Program Counter

Inputs:

* `clk`
* `reset`
* `next_pc`

Output:

* `pc`

The PC stores the address of the current instruction.

### Instruction Memory

Input:

* `address`

Output:

* `instruction`

The PC is used as the instruction memory address.

### Instruction Decoder

Input:

* `instruction`

Outputs:

* `opcode`
* `rd`
* `funct3`
* `rs1`
* `rs2`
* `funct7`

These fields are used by the control and execution units.

### Register File

Inputs:

* `clk`
* `reset`
* `rs1`
* `rs2`
* `rd`
* `write_data`
* `reg_write`

Outputs:

* `read_data1`
* `read_data2`

The register file provides source operands and receives the final writeback value.

### Immediate Generator

Input:

* `instruction`

Output:

* `immediate`

The immediate generator creates sign-extended or formatted immediate values according to the instruction type.

### Control Unit

Input:

* `opcode`

Outputs:

* `reg_write`
* `mem_read`
* `mem_write`
* `alu_src`
* `mem_to_reg`
* `branch`
* `jump`

These signals control the major datapath operations.

### ALU Control

Inputs:

* `opcode`
* `funct3`
* `funct7`

Output:

* `alu_control`

This determines which ALU operation is performed.

### ALU

Inputs:

* operand A
* operand B
* `alu_control`

Outputs:

* `result`
* `zero`

The ALU performs arithmetic and logical operations.

### Data Memory

Inputs:

* `clk`
* `mem_read`
* `mem_write`
* `addr
