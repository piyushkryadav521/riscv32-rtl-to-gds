# Day 35 — Static Timing Analysis (STA)

## Objective

Perform Static Timing Analysis (STA) on the synthesized RV32I processor
using a Nangate45 standard-cell library and OpenSTA.

The objective is to analyze:

- Clock timing
- Setup timing
- Hold timing
- Critical timing paths
- Slack
- Total Negative Slack (TNS)

---

## 1. STA Flow

The timing analysis flow used in this project is:

RTL
↓
Yosys Synthesis
↓
Nangate45 Technology Mapping
↓
Mapped Standard-Cell Netlist
↓
Nangate45 Liberty Timing Library
↓
SDC Constraints
↓
OpenSTA
↓
Setup / Hold / Slack Analysis

---

## 2. Technology Library

Technology library:

`~/OpenROAD/test/Nangate45/Nangate45_typ.lib`

Technology:

**Nangate45**

The mapped netlist contains real standard cells including:

- DFF_X1
- DFFR_X1
- MUX2_X1
- NAND2_X1
- NOR2_X1
- XOR2_X1
- XNOR2_X1
- AND2_X1
- INV_X1
- OAI21_X1
- AOI21_X1

---

## 3. Technology-Mapped Netlist

Mapped netlist:

`sta/netlist/riscv32_nangate45.v`

Approximate size:

**3.5 MB**

The technology-mapped design contains:

**30,875 standard-cell instances**

including:

| Cell Type | Count |
|---|---:|
| DFF_X1 | 8,192 |
| DFFR_X1 | 1,024 |
| MUX2_X1 | 17,536 |
| INV_X1 | 1,252 |
| NOR2_X1 | 373 |
| NAND2_X1 | 363 |
| XOR2_X1 | 85 |
| XNOR2_X1 | 86 |

---

## 4. Timing Constraints

SDC file:

`sta/sdcc.sdc`

Clock:

- Clock name: `clk`
- Clock period: **10.0 ns**
- Target frequency: **100 MHz**
- Clock uncertainty: **0.1 ns**

The reset input is treated as asynchronous and excluded from
synchronous data-path timing using a false-path constraint.

---

## 5. OpenSTA

OpenSTA version:

**3.1.0**

STA script:

`sta/sta.tcl`

STA report:

`sta/reports/day35_sta.log`

---

## 6. Timing Results

### Setup Timing

Worst setup slack:

**-36.78 ns**

Status:

**VIOLATED**

The worst setup path has:

- Data arrival time: **46.64 ns**
- Data required time: **9.86 ns**

Therefore:

`Slack = Required Time - Arrival Time`

`Slack = 9.86 - 46.64`

`Slack = -36.78 ns`

---

## 7. Hold Timing

Worst hold slack:

**+0.01 ns**

Status:

**MET**

The reported worst hold path therefore satisfies the hold requirement
under the current constraints.

---

## 8. Total Negative Slack

Setup TNS:

**-300882.06 ns**

This indicates that a large number of paths violate the 10 ns setup
constraint in the current technology-mapped implementation.

---

## 9. Critical Path Observation

The reported worst setup path passes through logic involving:

- Register file
- Multiplexer logic
- ALU logic
- Data-memory address/control logic
- Final multiplexer
- Destination flip-flop

The path includes cells such as:

- MUX2_X1
- XOR2_X1
- NOR2_X1
- OAI21_X1
- XNOR2_X1
- AND3_X1
- NAND2_X1
- NOR2_X1

The long combinational path is consistent with the single-cycle
processor architecture, where instruction execution, ALU computation,
memory access and write-back occur within one clock cycle.

---

## 10. Interpretation

The current 10 ns clock constraint results in a significant setup
timing violation.

This does not mean that the RTL processor is functionally incorrect.

Instead, it indicates that the current technology-mapped implementation
cannot meet a 100 MHz clock requirement under the present architecture,
cell mapping and timing assumptions.

The design uses flip-flop-based implementations for structures such as
the register file and data memory. These generate substantial
multiplexer and combinational logic.

---

## 11. Important Limitation

The current STA is an educational technology-mapped analysis using the
Nangate45 standard-cell library.

The result should not be interpreted as production silicon performance.

Actual implementation results depend on:

- Standard-cell selection
- Physical placement
- Clock-tree synthesis
- Routing
- Parasitic extraction
- Process-voltage-temperature corner
- Physical optimization

Later physical-design stages will provide more realistic timing analysis.

---

## 12. Generated Files

### STA files

- `sta/sdcc.sdc`
- `sta/sta.tcl`
- `sta/netlist/riscv32_nangate45.v`
- `sta/reports/day35_sta.log`

---

## Conclusion

Day 35 successfully completed the first Static Timing Analysis of the
RV32I processor.

The RTL design was technology-mapped to Nangate45 standard cells and
analyzed using OpenSTA.

Final timing results:

| Metric | Result |
|---|---:|
| Clock Period | 10.00 ns |
| Target Frequency | 100 MHz |
| Worst Setup Slack | -36.78 ns |
| Worst Hold Slack | +0.01 ns |
| Setup TNS | -300882.06 ns |
| Setup Status | VIOLATED |
| Hold Status | MET |

The project is now ready to continue with detailed STA constraint
analysis and timing optimization.