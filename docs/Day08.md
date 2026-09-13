# Day 8 – Instruction Memory

## Objective

The objective of Day 8 was to design and verify the **Instruction Memory** for the 32-bit RV32I processor.

Instruction Memory stores the processor instructions and provides the instruction corresponding to the current Program Counter (PC) address.

---

## 1. Instruction Memory

The basic instruction fetch path is:

```text
Program Counter
       │
       ▼
Instruction Memory
       │
       ▼
32-bit Instruction
       │
       ▼
Instruction Decoder