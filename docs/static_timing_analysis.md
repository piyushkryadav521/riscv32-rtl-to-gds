# Static Timing Analysis

## Overview

Static Timing Analysis (STA) was performed on the synthesized RV32I
processor using the Nangate45 standard-cell technology library and
OpenSTA.

The purpose of this analysis is to evaluate setup timing, hold timing,
clock uncertainty, and timing slack under different clock constraints.

## Technology

- Technology: Nangate45
- Timing Library: Nangate45_typ.lib
- STA Tool: OpenSTA
- Synthesis Tool: Yosys
- Clock Type: Ideal clock
- Clock Uncertainty: 0.1 ns

## Timing Constraints

### 100 MHz Configuration

- Clock period: 10 ns
- Target frequency: 100 MHz
- Input delay: 1 ns
- Output delay: 1 ns
- Reset: asynchronous false path

Constraint file:

`sta/sdcc.sdc`

### 50 MHz Configuration

- Clock period: 20 ns
- Target frequency: 50 MHz
- Input delay: 1 ns
- Output delay: 1 ns
- Reset: asynchronous false path

Constraint file:

`sta/constraints_50MHz.sdc`

## Timing Results

| Parameter | 100 MHz | 50 MHz |
|---|---:|---:|
| Clock Period | 10.00 ns | 20.00 ns |
| Data Arrival | 46.64 ns | 46.64 ns |
| Data Required | 9.86 ns | 19.86 ns |
| Worst Setup Slack | -36.78 ns | -26.78 ns |
| Worst Hold Slack | +0.01 ns | +0.01 ns |
| Setup TNS | -300882.06 ns | -214162.08 ns |

## Setup Timing

At 100 MHz, the worst setup slack is:

`-36.78 ns`

At 50 MHz, the worst setup slack improves to:

`-26.78 ns`

The setup violation remains because the critical data path has a
data arrival time of 46.64 ns.

## Hold Timing

The worst hold slack is:

`+0.01 ns`

Therefore, the analyzed design satisfies the hold-time requirement
under both clock configurations.

## Timing Comparison

Reducing the target frequency from 100 MHz to 50 MHz increases the
clock period from 10 ns to 20 ns.

The combinational delay remains unchanged because the synthesized
netlist and technology library are unchanged.

The additional timing budget improves setup slack by approximately
10 ns.

## Critical Path

The critical setup path passes through several parts of the processor,
including:

- Register file
- Multiplexer logic
- ALU logic
- Data memory logic
- Final write-back multiplexer
- Destination flip-flop

The measured data arrival time is approximately:

`46.64 ns`

## Interpretation

The current synthesized implementation does not satisfy the setup
timing requirement at either 100 MHz or 50 MHz.

However, hold timing is satisfied.

The results indicate that further optimization of the processor
datapath and synthesized logic is required before achieving the
desired operating frequency.

Possible future optimization areas include:

- Reducing combinational logic depth
- Optimizing multiplexer structures
- Improving ALU implementation
- Optimizing data-memory address/control logic
- Pipelining the processor datapath
- Using stronger standard-cell drive strengths
- Technology-aware synthesis optimization

## Generated Files

### Constraints

- `sta/sdcc.sdc`
- `sta/constraints_50MHz.sdc`

### STA Scripts

- `sta/sta.tcl`
- `sta/timing_analysis_50MHz.tcl`

### Reports

- `sta/reports/nangate45_mapping.log`
- `sta/reports/timing_analysis_100MHz.log`
- `sta/reports/timing_analysis_50MHz.log`
- `sta/reports/timing_comparison.txt`

### Netlist

- `sta/netlist/riscv32_nangate45.v`

## Conclusion

Static Timing Analysis was successfully performed on the Nangate45
mapped RV32I processor.

The analysis demonstrates how clock constraints affect setup timing
while the intrinsic data-path delay remains unchanged. The design
currently satisfies hold timing but has significant setup violations,
providing a clear target for subsequent timing optimization and
physical-design stages.
