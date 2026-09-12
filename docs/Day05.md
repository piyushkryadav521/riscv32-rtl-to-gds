# Day 5 – Control Unit and Control Signals

## Objective

The objective of Day 5 was to understand the Control Unit of a single-cycle RV32I processor and implement the main control signals required to control the datapath.

The Control Unit receives the instruction opcode and generates control signals that determine how the Register File, ALU, Data Memory, and writeback path operate.

---

## 1. Role of the Control Unit

The Control Unit is responsible for generating control signals based on the instruction opcode.

Basic flow:

```text
Instruction
     |
     v
  Opcode
     |
     v
+-------------+
| Control Unit|
+------+------+
       |
       v
Control Signals
       |
       +----------------+
       |                |
       v                v
   Datapath         Data Memory