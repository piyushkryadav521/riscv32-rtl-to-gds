# Day 4 – Datapath Architecture and Immediate Generator

## Objective

The objective of Day 4 was to understand the basic datapath architecture of a single-cycle RV32I processor and implement the Immediate Generator module in Verilog.

The Immediate Generator converts the immediate fields present inside a 32-bit RISC-V instruction into a complete 32-bit immediate value.

---

## 1. Processor Datapath

A processor datapath is the collection of hardware blocks responsible for moving and processing data.

The basic RV32I single-cycle datapath contains:

```text
              +----------------------+
              |    Program Counter   |
              +----------+-----------+
                         |
                         v
              +----------------------+
              | Instruction Memory  |
              +----------+-----------+
                         |
                         v
              +----------------------+
              | Instruction Decoder |
              +----------+-----------+
                         |
              +----------+----------+
              |                     |
              v                     v
       +-------------+      +------------------+
       | Register    |      | Immediate        |
       | File        |      | Generator        |
       +------+------+      +--------+---------+
              |                      |
              +----------+-----------+
                         |
                         v
                   +-----------+
                   |    ALU    |
                   +-----+-----+
                         |
               +---------+---------+
               |                   |
               v                   v
        +-------------+      +-------------+
        | Data Memory |      | Write Back  |
        +-------------+      +-------------+