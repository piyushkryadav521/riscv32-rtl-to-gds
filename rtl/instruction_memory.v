`timescale 1ns/1ps

module instruction_memory (
    input  wire [31:0] address,
    output wire [31:0] instruction
);

    reg [31:0] memory [0:255];

    initial begin

        // ==========================================
        // DAY 26 — R-TYPE INSTRUCTION VERIFICATION
        // ==========================================

        // ADDI x5, x0, 25
        memory[0] = 32'h01900293;

        // ADDI x6, x0, 15
        memory[1] = 32'h00F00313;

        // ADD x7, x5, x6
        // x7 = 25 + 15 = 40
        memory[2] = 32'h006283B3;

        // SUB x8, x5, x6
        // x8 = 25 - 15 = 10
        memory[3] = 32'h40628433;

        // AND x9, x5, x6
        // x9 = 25 & 15 = 9
        memory[4] = 32'h0062F4B3;

        // OR x10, x5, x6
        // x10 = 25 | 15 = 31
        memory[5] = 32'h0062E533;

        // XOR x11, x5, x6
        // x11 = 25 ^ 15 = 22
        memory[6] = 32'h0062C5B3;

        // SLT x12, x6, x5
        // x12 = (15 < 25) = 1
        memory[7] = 32'h00532633;

        // ADD x13, x7, x8
        // x13 = 40 + 10 = 50
        memory[8] = 32'h008386B3;

        // SUB x14, x13, x7
        // x14 = 50 - 40 = 10
        memory[9] = 32'h40768733;

        // NOP
        memory[10] = 32'h00000013;

    end

    assign instruction = memory[address[9:2]];

endmodule