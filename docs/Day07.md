# Day 7 – Program Counter (PC)

## Objective

The objective of Day 7 was to design and verify the **Program Counter (PC)** for the 32-bit RISC-V processor.

The Program Counter stores the address of the instruction currently being executed.

---

## 1. What is the Program Counter?

The Program Counter (PC) is a 32-bit register that stores the address of the current instruction.

For a normal sequential instruction flow:

```text
PC_next = PC + 4