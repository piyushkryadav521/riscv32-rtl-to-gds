# Day 31 — Yosys Netlist Analysis

## Objective

Analyze the synthesized gate-level Verilog netlist generated during Day 30 and understand the primitive logic cells produced by Yosys.

## Tools Used

- Yosys 0.33
- Verilog
- Ubuntu 24.04 LTS
- Python 3

## Synthesized Netlist

The synthesized netlist generated during Day 30 is:

``
synthesis/netlist/riscv32_synth.v
``

The netlist contains technology-independent logic cells rather than the original high-level RTL modules.

## Netlist Analysis

The synthesized netlist was analyzed using:

```bash
yosys -p "read_verilog synthesis/netlist/riscv32_synth.v; hierarchy -top top; stat"