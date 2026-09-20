# Day 31 — Yosys Netlist Analysis

## Objective

Analyze the synthesized RV32I processor netlist generated using Yosys.

## Synthesized Netlist

Netlist:

`synthesis/netlist/riscv32_synth.v`

Size:

Approximately 1.7 MB.

## Netlist Statistics

| Parameter | Value |
|---|---:|
| Wires | 21,749 |
| Wire bits | 44,040 |
| Public wires | 1,755 |
| Public wire bits | 23,922 |
| Memories | 0 |
| Processes | 8,708 |
| Cells | 11,286 |

### Cell Breakdown

| Cell | Count | Function |
|---|---:|---|
| `$mux` | 8,652 | Data/control selection |
| `$and` | 1,505 | AND logic |
| `$or` | 790 | OR logic |
| `$xor` | 229 | XOR logic |
| `$not` | 110 | Inversion |

## Interpretation

The synthesized netlist contains a large number of multiplexers because the RV32I datapath contains several selection operations.

Examples include:

- ALU operand selection
- Register write-back selection
- Memory-to-register selection
- Branch and jump PC selection
- Immediate and register operand selection

The AND, OR and XOR cells represent synthesized combinational logic from the processor's ALU and control logic.

The netlist contains no inferred memories after synthesis because the RTL memories were converted into logic/register structures during the current technology-independent Yosys synthesis flow.

## Day 30 vs Day 31

Day 30 performed RTL synthesis and generated the gate-level netlist.

Day 31 analyzed the generated netlist and extracted structural statistics.

Day 30 synthesis reported 19,990 cells including sequential cells.

Day 31 netlist read-back reports 11,286 visible `$and`, `$mux`, `$not`, `$or`, and `$xor` cells.

These statistics should not be interpreted as a direct one-to-one comparison because Yosys represents and reports the synthesized design differently during netlist read-back.

## Conclusion

The RV32I processor has successfully passed from RTL into a synthesized structural representation.

The synthesized netlist is ready for the next stages of the RTL-to-GDS flow, including timing constraints, synthesis reporting, and physical design preparation.