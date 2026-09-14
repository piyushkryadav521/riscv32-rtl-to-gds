# Day 11 – Immediate Generator Deep Verification

## Objective

Perform comprehensive functional verification of the Immediate Generator for the RV32I processor.

The Immediate Generator converts instruction-encoded immediate fields into a 32-bit immediate value that can be used by the processor datapath.

## Immediate Formats Verified

The following RISC-V immediate formats were verified:

- I-Type
- S-Type
- B-Type
- U-Type
- J-Type

Both positive and negative immediate values were tested.

## Immediate Generator Flow

```text
             ┌────────────────────────┐
Instruction ─►                        │
             │  Immediate Generator  │────► 32-bit Immediate
             │                        │
             └────────────────────────┘