`timescale 1ns/1ps

module instruction_memory (
    input  wire [31:0] address,
    output wire [31:0] instruction
);

    reg [31:0] memory [0:255];

    // Instruction memory initialization

    initial begin

        // LUI x5, 0x12345
        // Expected x5 = 0x12345000
        memory[0] = 32'h123452B7;

        // AUIPC x6, 0x00001
        // PC = 4
        // Expected x6 = 0x00001004
        memory[1] = 32'h00001317;

        // NOP
        memory[2] = 32'h00000013;

    end

    // Word-aligned addressing
    assign instruction = memory[address[9:2]];

endmodule