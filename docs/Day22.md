# Day 22 — CPU Top-Level Integration

## Objective

Integrate the completed RV32I CPU into a top-level wrapper module and verify that the CPU can be accessed through a clean top-level interface.

## Work Completed

Created:

- `rtl/top.v`
- `tb/top_tb.v`

The `top` module provides the external interface:

- `clk`
- `reset`
- `pc`
- `instruction`

Internally, it instantiates the `riscv_cpu` module.

## Top-Level Architecture

```text
             +----------------------+
clk -------->|                      |
reset ------>|      top.v           |
             |                      |
             |   +--------------+   |
             |   | riscv_cpu    |   |
             |   |              |   |
             |   | RV32I CPU    |   |
             |   +--------------+   |
             |                      |
             +----------+-----------+
                        |
                  +-----+-----+
                  |           |
                  v           v
                 PC      Instruction