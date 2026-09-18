`timescale 1ns/1ps

module instruction_memory (
    input  wire [31:0] address,
    output wire [31:0] instruction
);

    reg [31:0] memory [0:255];

    initial begin

        // ==========================================
        // — I-TYPE & MEMORY VERIFICATION
        // ==========================================

        // ADDI x5, x0, 25
        // x5 = 25
        memory[0] = 32'h01900293;

        // ADDI x6, x0, 15
        // x6 = 15
        memory[1] = 32'h00F00313;

        // ANDI x7, x5, 15
        // x7 = 25 & 15 = 9
        memory[2] = 32'h00F2F393;

        // ORI x8, x6, 16
        // x8 = 15 | 16 = 31
        memory[3] = 32'h01036413;

        // SW x8, 0(x0)
        // Memory[0] = 31
        memory[4] = 32'h00802023;

        // LW x9, 0(x0)
        // x9 = Memory[0] = 31
        memory[5] = 32'h00002483;

        // ADDI x10, x9, 5
        // x10 = 31 + 5 = 36
        memory[6] = 32'h00548513;

        // SW x10, 4(x0)
        // Memory[1] = 36
        memory[7] = 32'h00A02223;

        // LW x11, 4(x0)
        // x11 = Memory[1] = 36
        memory[8] = 32'h00402583;

        // ADD x12, x9, x11
        // x12 = 31 + 36 = 67
        memory[9] = 32'h00B48633;

        // NOP
        memory[10] = 32'h00000013;

    end

    assign instruction = memory[address[9:2]];

endmodule