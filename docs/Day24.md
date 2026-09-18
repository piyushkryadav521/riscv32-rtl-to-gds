# Day 24 — Module-Level Verification & Testbench Expansion

## Objective

The objective of Day 24 was to perform systematic module-level verification of the RV32I processor components using directed Verilog testbenches.

The verification focused on functional correctness, PASS/FAIL checking, waveform generation, and regression-style testing.

---

## Modules Verified

1. ALU
2. Register File
3. Immediate Generator
4. Control Unit
5. ALU Control
6. Data Memory
7. Branch Unit

---

## Verification Results

| Module | Tests | Passed | Failed |
|--------|------:|-------:|-------:|
| ALU | 8 | 8 | 0 |
| Register File | 5 | 5 | 0 |
| Immediate Generator | 8 | 8 | 0 |
| Control Unit | 9 | 9 | 0 |
| ALU Control | 13 | 13 | 0 |
| Data Memory | 6 | 6 | 0 |
| Branch Unit | 6 | 6 | 0 |
| **Total** | **55** | **55** | **0** |

---

## ALU Verification

Tested:

- ADD
- SUB
- AND
- OR
- XOR
- SLT true condition
- SLT false condition
- Zero flag

Result:

```text
PASS = 8
FAIL = 0