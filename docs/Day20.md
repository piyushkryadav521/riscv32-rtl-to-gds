# Day 20 – Memory Integration and Verification

## Objective

The objective of Day 20 was to verify the complete integration of the Data Memory with the RV32I CPU datapath.

The verification focused on:

- Store Word (SW)
- Load Word (LW)
- ALU-based memory address generation
- Memory write control
- Memory read control
- Memory-to-register write-back
- Register File and Data Memory interaction

---

## Memory Test Program

The following operations were executed:

| Instruction | Operation | Expected Result |
|---|---|---|
| ADDI x5, x0, 100 | Load immediate | x5 = 100 |
| ADDI x6, x0, 200 | Load immediate | x6 = 200 |
| SW x5, 0(x0) | Store 100 | Memory[0] = 100 |
| SW x6, 4(x0) | Store 200 | Memory[1] = 200 |
| LW x7, 0(x0) | Load from memory | x7 = 100 |
| LW x8, 4(x0) | Load from memory | x8 = 200 |
| ADD x9, x7, x8 | Add loaded values | x9 = 300 |
| SW x9, 8(x0) | Store result | Memory[2] = 300 |
| LW x10, 8(x0) | Load result | x10 = 300 |

---

## Memory Datapath

```text
              Register File
             /             \
           x5/x6           Read Data
             |                |
             v                |
             +-------> ALU <---+
                        |
                 Address Generation
                        |
                        v
                  Data Memory
                  /          \
                SW            LW
                |              |
                v              v
           Memory Write    Memory Read
                               |
                               v
                         Write Back MUX
                               |
                               v
                         Register File