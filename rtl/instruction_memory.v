`timescale 1ns/1ps

module instruction_memory (
    input  wire [31:0] address,
    output wire [31:0] instruction
);

    reg [31:0] memory [0:255];

    initial begin

        // ADD x5, x6, x7
        // x5 = 25 + 15 = 40
        memory[0] = 32'h007302B3;

        // SUB x8, x9, x10
        // x8 = 25 - 15 = 10
        memory[1] = 32'h40A48433;

        // AND x11, x12, x13
        // x11 = 15 & 7 = 7
        memory[2] = 32'h00D675B3;

        // OR x14, x15, x16
        // x14 = 15 | 5 = 15
        memory[3] = 32'h0107E733;

        // XOR x17, x18, x19
        // x17 = 12 ^ 10 = 6
        memory[4] = 32'h013948B3;

        // SLT x20, x21, x22
        // x20 = (5 < 10) = 1
        memory[5] = 32'h016AA A33;

        // ADDI x23, x0, 50
        // x23 = 50
        memory[6] = 32'h03200B93;

        // ANDI x24, x23, 15
        // x24 = 50 & 15 = 2
        memory[7] = 32'h00FBFC13;

        // ORI x25, x0, 10
        // x25 = 10
        memory[8] = 32'h00A00C93;

        // NOP
        memory[9] = 32'h00000013;

    end

    assign instruction = memory[address[9:2]];

endmodule