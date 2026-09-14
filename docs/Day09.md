# Day 9 – Register File Verification

## Objective

Verify the Register File module for integration into the RV32I processor.

## Register File Overview

The Register File contains:

- 32 general-purpose registers
- Each register is 32 bits wide
- Two read ports
- One write port
- Register x0 is permanently zero

### Register File Structure

```text
             ┌─────────────────────┐
 rs1 ───────►│                     │──────► read_data1
             │    Register File    │
 rs2 ───────►│      32 × 32        │──────► read_data2
             │                     │
 rd ────────►│                     │
 write_data ►│                     │
 reg_write ─►│                     │
             └──────────┬──────────┘
                        │
                       clk
