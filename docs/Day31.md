# Day 31 — Yosys Netlist Analysis

## Objective

Analyze the synthesized gate-level netlist generated during Day 30 and understand the hardware structure of the RV32I processor.

---

## 1. Synthesized Netlist

The synthesized netlist was generated using Yosys 0.33.

File:

`synthesis/netlist/riscv32_synth.v`

Netlist size:

Approximately 1.7 MB

The synthesized design contains the top-level module:

`top`

---

## 2. Day 30 Synthesis Statistics

The original technology-independent synthesis produced:

| Cell Type | Count |
|---|---:|
| MUX | 8,652 |
| DFFE with enable | 8,192 |
| AND | 1,505 |
| DFFE with enable/reset | 482 |
| DFF with reset | 30 |
| OR | 790 |
| XOR | 229 |
| NOT | 110 |
| **Total** | **19,990** |

The large number of multiplexers is mainly due to the many datapath selection operations in the single-cycle CPU.

---

## 3. Netlist Re-analysis

The synthesized Verilog netlist was read back into Yosys using:

```bash
yosys -p "read_verilog synthesis/netlist/riscv32_synth.v; hierarchy -top top; stat"