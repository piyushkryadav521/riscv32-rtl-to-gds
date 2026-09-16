# Day 18 — Register File + ALU Integration

## Objective

The objective of Day 18 was to verify the integration between the Register File, ALU, control logic, and write-back path inside the RV32I CPU.

The focus was on verifying that source registers are correctly read, ALU operations are correctly selected, results are generated, and results are written back to the destination registers.

---

## Datapath Verified

The following datapath was verified:

```text
Instruction Memory
        |
        v
Instruction Decoder
        |
        v
Register File
   |          |
   |          |
   v          v
 rs1_data   rs2_data
      \       /
       \     /
        v   v
         ALU
          |
          v
     ALU Result
          |
          v
     Write Back
          |
          v
    Register File