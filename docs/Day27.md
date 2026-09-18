# Day 27 — I-Type and Memory Instruction Verification

## Objective

The objective of Day 27 was to verify I-Type arithmetic/logical instructions and load/store memory operations at the CPU level.

The following instructions were tested:

- ADDI
- ANDI
- ORI
- SW
- LW
- ADD after memory read
- Register-to-memory data transfer
- Memory-to-register data transfer

The x0 hardwired-zero behavior was also verified.

---

## Test Program

| PC | Instruction | Expected Result |
|----|-------------|-----------------|
| 0x00 | ADDI x5, x0, 25 | x5 = 25 |
| 0x04 | ADDI x6, x0, 15 | x6 = 15 |
| 0x08 | ANDI x7, x5, 15 | x7 = 9 |
| 0x0C | ORI x8, x6, 16 | x8 = 31 |
| 0x10 | SW x8, 0(x0) | Memory[0] = 31 |
| 0x14 | LW x9, 0(x0) | x9 = 31 |
| 0x18 | ADDI x10, x9, 5 | x10 = 36 |
| 0x1C | SW x10, 4(x0) | Memory[1] = 36 |
| 0x20 | LW x11, 4(x0) | x11 = 36 |
| 0x24 | ADD x12, x9, x11 | x12 = 67 |
| 0x28 | NOP | No register change |

---

## Register Verification

| Register | Expected | Actual | Status |
|----------|----------|--------|--------|
| x5 | 25 | 25 | PASS |
| x6 | 15 | 15 | PASS |
| x7 | 9 | 9 | PASS |
| x8 | 31 | 31 | PASS |
| x9 | 31 | 31 | PASS |
| x10 | 36 | 36 | PASS |
| x11 | 36 | 36 | PASS |
| x12 | 67 | 67 | PASS |
| x0 | 0 | 0 | PASS |

---

## Memory Verification

| Memory Location | Expected | Actual | Status |
|-----------------|----------|--------|--------|
| Memory[0] | 31 | 31 | PASS |
| Memory[1] | 36 | 36 | PASS |

The test successfully verified both directions of data transfer:

```text
Register → Memory
Memory → Register