# Day 17 — CPU Datapath Integration

## Objective

The objective of Day 17 was to integrate the previously developed RV32I RTL modules into a complete single-cycle RISC-V CPU datapath and verify instruction execution at the CPU level.

---

## 1. CPU Integration

The following modules were integrated into `riscv_cpu.v`:

* Program Counter
* Instruction Memory
* Instruction Decoder
* Register File
* Immediate Generator
* Control Unit
* ALU Control
* ALU
* Data Memory
* Branch Unit

The CPU connects these modules to form a complete instruction execution datapath.

---

## 2. CPU Execution Flow

The integrated CPU follows this basic single-cycle execution flow:

```text
        +------------------+
        | Program Counter  |
        +--------+---------+
                 |
                 v
        +------------------+
        | Instruction      |
        | Memory           |
        +--------+---------+
                 |
                 v
        +------------------+
        | Instruction      |
        | Decoder          |
        +--------+---------+
                 |
        +--------+---------+
        |                  |
        v                  v
 +-------------+    +-------------+
 | Register    |    | Immediate   |
 | File        |    | Generator   |
 +------+------+    +------+------+
        |                  |
        +--------+---------+
                 |
                 v
        +------------------+
        | ALU Control      |
        +--------+---------+
                 |
                 v
        +------------------+
        | ALU              |
        +--------+---------+
                 |
          +------+------+
          |             |
          v             v
 +----------------+  +----------------+
 | Data Memory    |  | Write Back     |
 +----------------+  +-------+--------+
                            |
                            v
                      Register File

Branch and Jump logic determine the next PC.
```

---

## 3. Datapath Components

### Program Counter

The Program Counter stores the current instruction address.

For normal sequential execution:

```text
Next PC = PC + 4
```

For a taken branch:

```text
Next PC = PC + Branch Immediate
```

For JAL:

```text
Next PC = PC + Jump Immediate
```

---

## 4. Instruction Fetch

The instruction memory receives the current PC and provides the corresponding 32-bit instruction.

Example:

```text
PC = 0x00000000
Instruction = 0x00500293
```

This corresponds to:

```text
ADDI x5, x0, 5
```

---

## 5. Register File Integration

The register file provides two source operands and receives the final write-back result.

Example:

```text
x5 = 5
x6 = 10
```

The register file also preserves the RISC-V requirement that:

```text
x0 = 0
```

---

## 6. ALU Integration

The ALU was connected to the register file and immediate generator through an input multiplexer.

When:

```text
ALUSrc = 0
```

the second ALU operand comes from:

```text
rs2
```

When:

```text
ALUSrc = 1
```

the second ALU operand comes from:

```text
Immediate
```

Supported ALU operations include:

* ADD
* SUB
* AND
* OR
* XOR
* SLT

---

## 7. Load/Store Integration

The ALU calculates the effective memory address.

For example:

```text
LW x6, 0(x0)
```

results in:

```text
Address = x0 + 0
```

The memory data is then selected for register write-back.

For store:

```text
SW x5, 0(x0)
```

the register value is written into data memory.

CPU-level verification produced:

```text
x5 = 100
x6 = 100
Memory[0] = 100
```

This confirms that the complete load/store datapath is working.

---

## 8. Branch Integration

The Branch Unit supports:

* BEQ
* BNE

For a branch instruction, the Branch Unit compares the two register operands.

For example:

```text
BEQ x5, x6, +8
```

When:

```text
x5 = 5
x6 = 5
```

the branch is taken.

Verified result:

```text
Immediate   = 0x00000008
Branch      = 1
BranchTaken = 1
BranchTarget = 0x00000010
NextPC      = 0x00000010
```

The CPU successfully skipped the instruction at PC `0x0C` and executed the instruction at PC `0x10`.

BNE was also verified successfully.

---

## 9. JAL Integration

JAL requires two operations:

1. Update the PC with the jump target.
2. Write `PC + 4` into the destination register.

The CPU was updated to support:

```text
JAL rd, immediate
```

Verified result:

```text
x5 = 4
x6 = 77
```

This confirms that:

```text
x5 = PC + 4
```

and that the jump target was correctly executed.

---

## 10. LUI Integration

LUI writes the upper immediate value directly into the destination register.

Example:

```text
LUI x5, 0x12345
```

Expected:

```text
x5 = 0x12345000
```

Verified result:

```text
x5 = 305418240
```

Therefore:

```text
x5 = 0x12345000
```

---

## 11. AUIPC Integration

AUIPC calculates:

```text
rd = PC + Immediate
```

For:

```text
AUIPC x6, 0x00001
```

at:

```text
PC = 0x00000004
```

the expected result is:

```text
x6 = 0x00001004
```

Verified result:

```text
x6 = 4100
```

Therefore:

```text
x6 = 0x00001004
```

---

## 12. CPU-Level Verification

The following instruction classes were successfully verified:

| Instruction | Result |
| ----------- | ------ |
| ADD         | PASS   |
| SUB         | PASS   |
| AND         | PASS   |
| OR          | PASS   |
| XOR         | PASS   |
| SLT         | PASS   |
| ADDI        | PASS   |
| ANDI        | PASS   |
| ORI         | PASS   |
| LW          | PASS   |
| SW          | PASS   |
| BEQ         | PASS   |
| BNE         | PASS   |
| JAL         | PASS   |
| LUI         | PASS   |
| AUIPC       | PASS   |

---

## 13. Simulation

The CPU was compiled using Icarus Verilog.

Example compilation:

```bash
iverilog -g2012 \
-o sim/riscv_cpu_sim \
tb/riscv_cpu_tb.v \
rtl/riscv_cpu.v \
rtl/program_counter.v \
rtl/instruction_memory.v \
rtl/instruction_decoder.v \
rtl/register_file.v \
rtl/immediate_generator.v \
rtl/control_unit.v \
rtl/alu_control.v \
rtl/alu.v \
rtl/data_memory.v \
rtl/branch_unit.v
```

Simulation was executed using:

```bash
vvp sim/riscv_cpu_sim
```

Waveforms were generated in:

```text
sim/riscv_cpu.vcd
```

The waveform can be inspected using GTKWave.

---

## 14. Final Day 17 Result

The previously developed RTL modules were successfully integrated into a single-cycle RV32I CPU.

The CPU successfully demonstrated:

* Instruction fetch
* Instruction decoding
* Register read/write
* Immediate generation
* ALU execution
* Memory access
* Load/store operation
* Conditional branch
* Jump operation
* Special immediate operations
* PC update
* Register write-back

### Status

**Day 17 CPU Datapath Integration: COMPLETE**

---

## Next Step

Day 18 will focus on deeper CPU integration and instruction execution verification, including systematic testing of register operations, ALU operations, immediate instructions, memory instructions, and control-flow instructions.
