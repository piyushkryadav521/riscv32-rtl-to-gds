# Day 34 — Synthesis Optimization & Final RTL-to-Netlist Review

## Objective

Perform the final review of the optimized RV32I synthesized netlist before
moving to Static Timing Analysis (STA).

## 1. Optimized Netlist

The optimized netlist generated during Day 32 is:

`synthesis/day32/netlist/riscv32_optimized.v`

Netlist size:

Approximately 1.8 MB.

## 2. Final Netlist Statistics

The optimized netlist was re-read using Yosys 0.33.

| Metric | Value |
|---|---:|
| Wires | 22,453 |
| Wire bits | 31,854 |
| Public wires | 14,133 |
| Public wire bits | 23,410 |
| Processes | 7,108 |
| Explicit combinational cells | 8,060 |

### Combinational cells

| Cell Type | Count |
|---|---:|
| MUX | 6,846 |
| AND | 524 |
| OR | 449 |
| XOR | 119 |
| NOT | 122 |

The optimized design contains no unused modules according to the Yosys
hierarchy check.

## 3. Optimization Comparison

The technology-independent synthesized cell count changed from:

**Day 30:** 19,990 cells

to

**Day 32:** 15,164 cells

Cell reduction:

**4,826 cells**

Approximate reduction:

**24.1%**

This demonstrates that the synthesis optimization flow reduced the reported
technology-independent cell count.

## 4. Important Interpretation

The Day 34 re-read report contains:

- 8,060 explicit combinational cells
- 7,108 processes

These values should not be added together to represent physical hardware
area.

The proper synthesis optimization comparison remains:

`19,990 → 15,164`

## 5. Netlist Simulation

The optimized netlist was compiled and simulated using Icarus Verilog.

Simulation result:

```text
========================================
DAY 32 OPTIMIZED NETLIST TEST
========================================
PC          = 0000005c
Instruction = 00000003
OPTIMIZED NETLIST SIMULATION COMPLETE
========================================