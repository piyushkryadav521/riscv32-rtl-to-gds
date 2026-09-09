#Day 02

32-bit RISC-V instruction is divided into fields. 
Because CPU`s  instruction decoder, control unit, immediate generator, alu control depend on these fields.

Six major instruction formats 
RV32I uses six basic formats:

| Format     | Common use                        |
| ---------- | --------------------------------- |
| **R-type** | Register → Register operations    |
| **I-type** | Immediate operations, loads, JALR |
| **S-type** | Stores                            |
| **B-type** | Conditional branches              |
| **U-type** | Large upper immediate             |
| **J-type** | Jump                              |

R-type used = mathematical operation such as ADD, SUB, AND, OR.
I-type is used= ADDI ANDI ORI LW JALR.
S-type is primarily used for stores.
B-type is used for conditional branches such as BEQ BNE BLT BGE.
U-type contains a 20-bit immediate. Used by: LUI AUIPC.
J-type used by JAL.