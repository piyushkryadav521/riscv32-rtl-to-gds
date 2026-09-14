# Day 12 – Control Unit Deep Verification

## Objective

The objective of Day 12 was to perform detailed verification of the Control Unit of the 32-bit RISC-V RV32I processor.

The Control Unit generates the control signals required to control the processor datapath based on the instruction opcode.

---

## Control Unit Signals

The Control Unit generates the following signals:

| Signal | Function |
|---|---|
| RegWrite | Enables writing data into the register file |
| MemRead | Enables reading from data memory |
| MemWrite | Enables writing to data memory |
| ALUSrc | Selects ALU second input between register data and immediate |
| MemToReg | Selects memory data for register write-back |
| Branch | Indicates a conditional branch instruction |
| Jump | Indicates a jump instruction |

---

## Supported Instruction Groups

The Control Unit supports the following instruction groups:

- R-Type instructions
- I-Type ALU instructions
- Load Word (LW)
- Store Word (SW)
- Branch instructions (BEQ/BNE)
- JAL
- LUI
- AUIPC

Unsupported instructions generate safe default control signals.

---

## Opcode Mapping

| Instruction Type | Opcode |
|---|---|
| R-Type | `0110011` |
| I-Type ALU | `0010011` |
| LW | `0000011` |
| SW | `0100011` |
| Branch | `1100011` |
| JAL | `1101111` |
| LUI | `0110111` |
| AUIPC | `0010111` |

---

## Control Signal Verification

The following control configurations were verified:

| Instruction | RegWrite | MemRead | MemWrite | ALUSrc | MemToReg | Branch | Jump |
|---|---:|---:|---:|---:|---:|---:|---:|
| R-Type | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
| I-Type ALU | 1 | 0 | 0 | 1 | 0 | 0 | 0 |
| LW | 1 | 1 | 0 | 1 | 1 | 0 | 0 |
| SW | 0 | 0 | 1 | 1 | 0 | 0 | 0 |
| BEQ | 0 | 0 | 0 | 0 | 0 | 1 | 0 |
| BNE | 0 | 0 | 0 | 0 | 0 | 1 | 0 |
| JAL | 1 | 0 | 0 | 0 | 0 | 0 | 1 |
| LUI | 1 | 0 | 0 | 1 | 0 | 0 | 0 |
| AUIPC | 1 | 0 | 0 | 1 | 0 | 0 | 0 |
| Invalid | 0 | 0 | 0 | 0 | 0 | 0 | 0 |

---

## Verification Method

A dedicated testbench was used to verify the Control Unit.

The testbench:

1. Applied different instruction opcodes.
2. Observed all seven control signals.
3. Compared the generated control signals against expected values.
4. Reported `PASS` or `FAIL`.
5. Generated a VCD waveform for GTKWave analysis.

---

## Simulation Result

The Control Unit was compiled using Icarus Verilog.

All ten verification cases passed successfully.

```text
===== CONTROL UNIT DEEP VERIFICATION =====

R-Type
RegWrite=1 MemRead=0 MemWrite=0 ALUSrc=0 MemToReg=0 Branch=0 Jump=0
PASS

I-Type ALU
RegWrite=1 MemRead=0 MemWrite=0 ALUSrc=1 MemToReg=0 Branch=0 Jump=0
PASS

LW
RegWrite=1 MemRead=1 MemWrite=0 ALUSrc=1 MemToReg=1 Branch=0 Jump=0
PASS

SW
RegWrite=0 MemRead=0 MemWrite=1 ALUSrc=1 MemToReg=0 Branch=0 Jump=0
PASS

BEQ
RegWrite=0 MemRead=0 MemWrite=0 ALUSrc=0 MemToReg=0 Branch=1 Jump=0
PASS

BNE
RegWrite=0 MemRead=0 MemWrite=0 ALUSrc=0 MemToReg=0 Branch=1 Jump=0
PASS

JAL
RegWrite=1 MemRead=0 MemWrite=0 ALUSrc=0 MemToReg=0 Branch=0 Jump=1
PASS

LUI
RegWrite=1 MemRead=0 MemWrite=0 ALUSrc=1 MemToReg=0 Branch=0 Jump=0
PASS

AUIPC
RegWrite=1 MemRead=0 MemWrite=0 ALUSrc=1 MemToReg=0 Branch=0 Jump=0
PASS

INVALID
RegWrite=0 MemRead=0 MemWrite=0 ALUSrc=0 MemToReg=0 Branch=0 Jump=0
PASS