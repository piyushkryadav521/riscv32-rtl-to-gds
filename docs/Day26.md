# Day 26 — R-Type Instruction Verification

## Objective

The objective of Day 26 was to verify the execution of RV32I R-Type instructions at the CPU level.

The following R-Type instructions were tested:

- ADD
- SUB
- AND
- OR
- XOR
- SLT

Register dependencies and the x0 hardwired-zero behavior were also verified.

---

## Test Program

The following instructions were executed:

| PC | Instruction | Expected Result |
|----|-------------|-----------------|
| 0x00 | ADDI x5, x0, 25 | x5 = 25 |
| 0x04 | ADDI x6, x0, 15 | x6 = 15 |
| 0x08 | ADD x7, x5, x6 | x7 = 40 |
| 0x0C | SUB x8, x5, x6 | x8 = 10 |
| 0x10 | AND x9, x5, x6 | x9 = 9 |
| 0x14 | OR x10, x5, x6 | x10 = 31 |
| 0x18 | XOR x11, x5, x6 | x11 = 22 |
| 0x1C | SLT x12, x6, x5 | x12 = 1 |
| 0x20 | ADD x13, x7, x8 | x13 = 50 |
| 0x24 | SUB x14, x13, x7 | x14 = 10 |
| 0x28 | NOP | No register change |

---

## Verification Results

| Register | Expected | Actual | Status |
|----------|----------|--------|--------|
| x5 | 25 | 25 | PASS |
| x6 | 15 | 15 | PASS |
| x7 | 40 | 40 | PASS |
| x8 | 10 | 10 | PASS |
| x9 | 9 | 9 | PASS |
| x10 | 31 | 31 | PASS |
| x11 | 22 | 22 | PASS |
| x12 | 1 | 1 | PASS |
| x13 | 50 | 50 | PASS |
| x14 | 10 | 10 | PASS |
| x0 | 0 | 0 | PASS |

---

## Verification Summary

```text
========================================
R-TYPE VERIFICATION
========================================

PASS = 11
FAIL = 0

R-TYPE VERIFICATION: PASS
========================================