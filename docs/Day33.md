#  — Synthesis Reports & Area Analysis

## Objective

Analyze the optimized RV32I processor netlist and quantify its technology-independent logic distribution.

## 1. Analysis Source

Optimized netlist:

`synthesis/day32/netlist/riscv32_optimized.v`

Analysis report:

`synthesis/day32/reports/day33_area_analysis.log`

The netlist was analyzed using Yosys 0.33.

## 2. Netlist Statistics

| Metric | Value |
|---|---:|
| Wires | 22,453 |
| Wire bits | 31,854 |
| Public wires | 14,133 |
| Public wire bits | 23,410 |
| Processes | 7,108 |
| Explicit combinational cells | 8,060 |

## 3. Combinational Cell Distribution

| Cell Type | Count | Percentage |
|---|---:|---:|
| MUX | 6,846 | 84.94% |
| AND | 524 | 6.50% |
| OR | 449 | 5.57% |
| XOR | 119 | 1.48% |
| NOT | 122 | 1.51% |
| **Total** | **8,060** | **100%** |

## 4. Dominant Logic

Multiplexers are the dominant explicit combinational cell type, representing approximately 84.94% of the cells in this re-read structural representation.

The large MUX count is consistent with the single-cycle processor datapath, which contains multiple data-selection paths involving:

- Register operands
- Immediate values
- ALU results
- Memory data
- PC + 4
- Branch targets
- Jump targets
- LUI/AUIPC write-back paths

## 5. Area Interpretation

The current analysis is technology-independent.

Therefore, the cell counts and percentages cannot be directly interpreted as physical silicon area in µm².

Actual physical area requires mapping the design to a specific standard-cell library.

Later stages will provide more meaningful:

- Cell area
- Timing
- Power
- Utilization
- Physical dimensions

## 6. Relation to Day 32

Day 32 optimization reduced the reported Yosys synthesized-cell count from:

`19,990 → 15,164`

This represents approximately a 24.1% reduction in the reported technology-independent cell count.

Day 33 further analyzes the resulting optimized structure.

## 7. Generated Report

The detailed Yosys analysis is stored in:

`synthesis/day32/reports/day33_area_analysis.log`

## Conclusion

Day 33 successfully analyzed the optimized RV32I netlist.

The analysis shows that multiplexers form the dominant explicit combinational logic component in the current synthesized representation.

The project is now ready to move toward more detailed synthesis reporting and technology-specific analysis.