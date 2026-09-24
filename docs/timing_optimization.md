# Timing Optimization and Critical Path Analysis

## Overview

Day 37 focused on identifying and reducing the critical timing path of the RV32I processor.

## Baseline

At 50 MHz:

- Clock period: 20 ns
- Data arrival time: 46.64 ns
- Data required time: 19.86 ns
- Worst setup slack: -26.78 ns
- Worst hold slack: +0.01 ns
- Mapped cell count: 30,875

## Critical Path

The critical path is:

PC → Instruction Memory → Register File → ALU → Data Memory → DFF

The synthesized Data Memory uses a large multiplexer network for the 256 × 32-bit register array.

The critical path contains a high-delay OAI21_X1 stage followed by Data Memory address-decoding logic.

## Optimization

The Data Memory combinational read logic was restructured from a conditional continuous assignment to an explicit combinational always block.

The memory architecture was preserved:

- 256 words
- 32-bit word width
- Address range selected by address[9:2]

No reduction in memory capacity was performed.

## Results

| Metric | Baseline | Optimized |
|---|---:|---:|
| Cell count | 30,875 | 30,875 |
| Arrival time | 46.64 ns | 46.32 ns |
| Setup slack | -26.78 ns | -26.46 ns |
| Hold slack | +0.01 ns | +0.01 ns |

## Improvement

Critical arrival time improved by:

0.32 ns

Setup slack improved by:

0.32 ns

This corresponds to approximately 0.69% reduction in critical-path delay.

## Functional Verification

Data Memory unit verification passed after the RTL modification.

Full CPU branch and jump verification also passed:

- x5 = 10
- x6 = 10
- x7 = 77
- x8 = 20
- x9 = 55
- x10 = 25

## Conclusion

The optimization produced a small timing improvement without changing memory capacity or mapped cell count.

The processor remains setup-time limited. The dominant critical path continues through the ALU and synthesized Data Memory multiplexer/decode structure.
