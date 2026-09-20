# Day 32 — Complete CPU Synthesis & Gate-Level Verification

## Objective

Perform complete synthesis of the RV32I processor and verify that the synthesized gate-level netlist preserves the expected CPU execution behavior.

## Synthesis

The complete RTL design was synthesized using Yosys.

### Synthesis Script

`synthesis/complete_cpu_synthesis.ys`

### Final Netlist

`synthesis/netlist/riscv32_cpu_final.v`

### Netlist Size

Approximately 1.7 MB.

### Synthesis Report

`synthesis/reports/complete_cpu_synthesis.log`

## Synthesis Statistics

| Cell Type | Count |
|---|---:|
| AND | 1,505 |
| DFFE | 482 |
| DFFE | 8,192 |
| DFF | 30 |
| MUX | 8,652 |
| NOT | 110 |
| OR | 790 |
| XOR | 229 |
| **Total Cells** | **19,990** |

## Gate-Level Simulation

The synthesized netlist was simulated using Icarus Verilog.

### Testbench

`tb/gate_level_tb.v`

### Waveform

`sim/gate_level/riscv32_gate_level.vcd`

## Verification Result

The synthesized CPU successfully executed the initialized branch and jump verification program.

| PC | Instruction | Verification |
|---:|---|---|
| 0x00 | ADDI | PASS |
| 0x04 | ADDI | PASS |
| 0x08 | BEQ | PASS |
| 0x10 | ADDI | PASS |
| 0x18 | BNE | PASS |
| 0x1C | ADDI | PASS |
| 0x28 | BNE | PASS |
| 0x30 | ADDI | PASS |
| 0x34 | JAL | PASS |
| 0x3C | ADDI | PASS |
| 0x40 | NOP | PASS |

### Observed PC Flow

```text
0x00 → 0x04 → 0x08 → 0x10 → 0x14 → 0x18
     → 0x1C → 0x20 → 0x24 → 0x28 → 0x30
     → 0x34 → 0x3C → 0x40