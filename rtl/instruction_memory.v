`timescale 1ns/1ps

module instruction_memory (
    input  wire [31:0] address,
    output wire [31:0] instruction
);

    reg [31:0] memory [0:255];

    initial begin

        
        // BRANCH AND JUMP TEST

        // ADDI x5, x0, 10
        // x5 = 10
        memory[0] = 32'h00A00293;

        // ADDI x6, x0, 10
        // x6 = 10
        memory[1] = 32'h00A00313;

        // BEQ x5, x6, +8
        // 10 == 10 → branch taken
        // Skip instruction at PC=12
        memory[2] = 32'h00628463;

        // ADDI x7, x0, 99
        // Should be skipped
        memory[3] = 32'h06300393;

        // ADDI x7, x0, 77
        // Branch target
        memory[4] = 32'h04D00393;

        // BNE x5, x6, +8
        // 10 != 10 is false → branch NOT taken
        memory[5] = 32'h00629463;

        // ADDI x8, x0, 55
        // Should execute
        memory[6] = 32'h03700413;

        // JAL x9, +8
        // x9 = PC + 4
        // Jump to PC + 8
        memory[7] = 32'h008004EF;

        // ADDI x10, x0, 99
        // Should be skipped
        memory[8] = 32'h06300513;

        // ADDI x10, x0, 88
        // JAL target
        memory[9] = 32'h05800513;

        // NOP
        memory[10] = 32'h00000013;

    end

    assign instruction = memory[address[9:2]];

endmodule