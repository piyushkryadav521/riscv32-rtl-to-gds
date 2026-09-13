`timescale 1ns/1ps

module instruction_memory (
    input  wire [31:0] address,
    output wire [31:0] instruction
);

    reg [31:0] memory [0:255];

    // Instruction memory initialization
    initial begin

        // ADD x5, x6, x7
        memory[0] = 32'b0000000_00111_00110_000_00101_0110011;

        // SUB x8, x9, x10
        memory[1] = 32'b0100000_01010_01001_000_01000_0110011;

        // AND x11, x12, x13
        memory[2] = 32'b0000000_01101_01100_111_01011_0110011;

        // OR x14, x15, x16
        memory[3] = 32'b0000000_10000_01111_110_01110_0110011;

        // ADDI x17, x18, 10
        memory[4] = 32'b000000001010_10010_000_10001_0010011;

        // Default remaining memory locations to NOP
        memory[5] = 32'h00000013;

    end

    // Word-aligned addressing
    assign instruction = memory[address[9:2]];

endmodule