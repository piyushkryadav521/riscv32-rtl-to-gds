# Day 6 – ALU Control Unit

## Objective

The objective of Day 6 was to design and verify the **ALU Control Unit** for the RV32I processor.

The ALU Control Unit generates a 4-bit control signal that tells the ALU which arithmetic or logical operation should be performed.

---

## 1. ALU Control Unit

The ALU Control Unit receives instruction information from the instruction decoder:

- Opcode
- funct3
- funct7

It then generates the appropriate ALU control signal.

### Basic flow

Instruction
↓
Opcode / funct3 / funct7
↓
ALU Control Unit
↓
ALU Control Signal
↓
ALU

---

## 2. ALU Operations

The ALU designed on Day 3 supports the following operations:

| ALU Operation | Control |
|---|---|
| ADD | `0000` |
| SUB | `0001` |
| AND | `0010` |
| OR | `0011` |
| XOR | `0100` |
| SLT | `0101` |

---

## 3. R-Type Instructions

R-Type instructions use opcode:

```text
0110011