# Day 16 — RTL Integration Review

## Objective

The objective of Day 16 was to perform a final RTL integration review before connecting the individual modules into a complete 32-bit RISC-V RV32I single-cycle processor.

The review focused on instruction execution flow, module interfaces, control signals, ALU operation mapping, memory access, writeback, and next-PC generation.

## RTL Modules Reviewed

The following 10 RTL modules were reviewed:

1. `program_counter.v`
2. `instruction_memory.v`
3. `instruction_decoder.v`
4. `register_file.v`
5. `immediate_generator.v`
6. `control_unit.v`
7. `alu_control.v`
8. `alu.v`
9. `data_memory.v`
10. `branch_unit.v`

## Instruction Execution Flow

The basic single-cycle instruction flow is:

```text
PC
 ↓
Instruction Memory
 ↓
Instruction Decoder
 ↓
Register File / Immediate Generator / Control Unit
 ↓
ALU Control
 ↓
ALU
 ↓
Data Memory
 ↓
Writeback
 ↓
Register File
 ↓
Next PC
```

Each instruction completes its required datapath operations within a single clock cycle.

## Control Signal Mapping

| Signal       | Function                                        |
| ------------ | ----------------------------------------------- |
| `reg_write`  | Enables register writeback                      |
| `mem_read`   | Enables data-memory read                        |
| `mem_write`  | Enables data-memory write                       |
| `alu_src`    | Selects register or immediate as ALU operand    |
| `mem_to_reg` | Selects memory data or ALU result for writeback |
| `branch`     | Enables branch evaluation                       |
| `jump`       | Enables jump/next-PC selection                  |

## ALU Operation Mapping

The ALU control encoding was verified against the ALU implementation.

| ALU Control | Operation |
| ----------- | --------- |
| `0000`      | ADD       |
| `0001`      | SUB       |
| `0010`      | AND       |
| `0011`      | OR        |
| `0100`      | XOR       |
| `0101`      | SLT       |

The encoding is consistent between `alu_control.v` and `alu.v`.

## ALU Operand Selection

The second ALU operand will be selected using `alu_src`.

```text
alu_src = 0 → rs2_data
alu_src = 1 → immediate
```

This allows the same ALU to support register-register operations and immediate/address calculations.

## Writeback Selection

The writeback path will select between the ALU result and data-memory output.

```text
mem_to_reg = 0 → ALU Result
mem_to_reg = 1 → Memory Data
```

This supports normal ALU instructions and load instructions.

## Branch Operation

The branch unit receives:

* `rs1_data`
* `rs2_data`
* `funct3`
* `branch`

For the currently supported conditional branches:

```text
BEQ → branch when rs1 == rs2
BNE → branch when rs1 != rs2
```

When a branch is taken, the next PC will be generated using the branch immediate.

## Next-PC Logic

The integrated CPU will require selection between sequential execution and control-flow targets.

```text
PC + 4
   │
   ├─────────────┐
   │             │
   ▼             ▼
Sequential    Branch Target
                 │
                 ▼
              Next PC
```

JAL will additionally require:

```text
JAL:
rd = PC + 4
PC = PC + immediate
```

Therefore, JAL requires both a jump-target calculation and a separate writeback value.

## Special Instructions

The following instructions require special datapath handling during CPU integration:

### LUI

```text
rd = immediate
```

### AUIPC

```text
rd = PC + immediate
```

### JAL

```text
rd = PC + 4
PC = PC + immediate
```

These instructions will be handled explicitly during top-level CPU integration.

## Instruction Memory Review

The current instruction memory contains basic test instructions:

* ADD
* SUB
* AND
* OR
* ADDI

Word-aligned addressing is implemented using:

```verilog
memory[address[9:2]]
```

This maps byte addresses such as 0, 4, 8, 12 and 16 to consecutive instruction-memory locations.

## Integration Readiness

The following checks were completed:

* All 10 RTL modules are present.
* Module interfaces were reviewed.
* Control signals were reviewed.
* ALU and ALU Control compatibility was verified.
* Instruction-memory addressing was reviewed.
* Branch operation was reviewed.
* Writeback requirements were identified.
* Next-PC requirements were identified.
* Special instruction handling requirements were identified.
* Git repository status was verified as clean.
* Day 1–15 documentation was confirmed to be present.

## Current Project Status

```text
RTL Modules                  : 10
Individual Module Testing   : Completed
Interface Review             : Completed
Datapath Planning            : Completed
Integration Review           : Completed
Top-Level CPU                : Not Started
```

## Supported Instruction Subset

The initial integrated processor is planned to support:

### R-Type

* ADD
* SUB
* AND
* OR
* XOR
* SLT

### I-Type

* ADDI
* ANDI
* ORI

### Memory

* LW
* SW

### Branch

* BEQ
* BNE

### Jump

* JAL

### Upper Immediate

* LUI
* AUIPC

## Conclusion

Day 16 completed the final RTL integration review.

All individual RTL modules have been implemented and verified, and their interfaces and datapath relationships have been reviewed.

The project is now ready to move from individual module development toward complete CPU datapath integration.

The next major milestone is the creation of the top-level `riscv_cpu.v` module and connection of the verified RTL blocks into a functional single-cycle RV32I processor.
