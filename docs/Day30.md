# Day 30 — RTL Synthesis Using Yosys

## Objective

The objective of Day 30 was to begin the synthesis phase of the RV32I RTL-to-GDSII project.

The verified RV32I processor RTL was synthesized using Yosys 0.33 to generate a technology-independent gate-level Verilog netlist.

---

## 1. Synthesis Flow

The synthesis flow used on Day 30 was:

```text
Verilog RTL
     ↓
Yosys Verilog Frontend
     ↓
RTL Processing
     ↓
Optimization
     ↓
Technology Mapping
     ↓
Flattening
     ↓
Gate-Level Netlist