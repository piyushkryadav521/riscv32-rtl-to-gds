# Day 33 — Synthesis Reports & Design Analysis

## Objective

Analyze the final synthesized RV32I processor netlist using Yosys and verify its structural consistency.

## Input Netlist

`synthesis/netlist/riscv32_cpu_final.v`

Netlist size: approximately 1.7 MB.

## Synthesis Analysis Report

`synthesis/reports/day33_synthesis_report.log`

## Structural Statistics

| Metric | Value |
|---|---:|
| Wires | 21,749 |
| Wire bits | 44,040 |
| Public wires | 1,755 |
| Public wire bits | 23,922 |
| Processes | 8,708 |
| Reported cells | 11,286 |

### Combinational Cell Breakdown

| Cell | Count |
|---|---:|
| `$mux` | 8,652 |
| `$and` | 1,505 |
| `$or` | 790 |
| `$xor` | 229 |
| `$not` | 110 |

## Structural Verification

Yosys hierarchy analysis identified `top` as the top-level module.

The CHECK pass reported:

```text
```text
Found and reported 0 problems.
```
