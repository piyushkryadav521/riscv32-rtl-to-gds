# Day 29 — Debugging, Waveform Analysis & RTL Review

## Objective

The objective of Day 29 was to perform a debugging and waveform-based review of the integrated RV32I processor.

The CPU was tested using the branch and jump verification program developed on Day 28.

---

## 1. Verification Environment

The complete RTL design was compiled using Icarus Verilog.

### Compilation

```bash
iverilog -o sim/riscv_cpu_day29_sim rtl/*.v tb/riscv_cpu_day28_tb.v