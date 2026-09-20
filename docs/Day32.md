# Day 32 — Complete CPU Synthesis & Netlist Analysis

## Objective

Perform a complete synthesis of the RV32I processor using Yosys and analyze the resulting synthesized netlist.

## Tools

- Ubuntu 24.04 LTS
- Yosys 0.33
- Verilog
- Git/GitHub

## Synthesis Flow

The complete RTL design was synthesized using Yosys.

The synthesis flow included:

1. RTL file reading
2. Design hierarchy analysis
3. Process conversion
4. RTL optimization
5. FSM processing
6. Memory processing
7. Technology-independent optimization
8. Technology mapping
9. Hierarchy flattening
10. Final optimization
11. Netlist generation
12. Statistical analysis

## RTL Modules Synthesized

The following RTL modules were included:

- program_counter
- instruction_memory
- instruction_decoder
- register_file
- immediate_generator
- ALU
- ALU control
- control unit
- data memory
- branch unit
- RISC-V CPU
- top-level module

## Synthesis Output

The generated Day 32 files are stored in:

```text
synthesis/synthesis/