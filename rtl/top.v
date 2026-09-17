`timescale 1ns/1ps

module top (
    input  wire        clk,
    input  wire        reset,

    output wire [31:0] pc,
    output wire [31:0] instruction
);

    // ==========================================
    // RV32I CPU TOP-LEVEL MODULE
    

    riscv_cpu cpu (
        .clk         (clk),
        .reset       (reset),
        .pc          (pc),
        .instruction (instruction)
    );

endmodule