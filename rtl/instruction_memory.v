`timescale 1ns/1ps

module instruction_memory (
    input  wire [31:0] address,
    output wire [31:0] instruction
);

    reg [31:0] memory [0:255];

    initial begin

        // ==========================================
        //  BRANCH & JUMP VERIFICATION
        // ==========================================

        // 0x00: ADDI x5, x0, 10
        // x5 = 10
        memory[0] = 32'h00A00293;

        // 0x04: ADDI x6, x0, 10
        // x6 = 10
        memory[1] = 32'h00A00313;

        // 0x08: BEQ x5, x6, +8
        // TAKEN → jump to 0x10
        memory[2] = 32'h00628463;

        // 0x0C: ADDI x7, x0, 99
        // SKIPPED
        memory[3] = 32'h06300393;

        // 0x10: ADDI x7, x0, 77
        // x7 = 77
        memory[4] = 32'h04D00393;

        // 0x14: ADDI x8, x0, 20
        // x8 = 20
        memory[5] = 32'h01400413;

        // 0x18: BNE x5, x6, +8
        // NOT TAKEN because x5 == x6
        memory[6] = 32'h00629463;

        // 0x1C: ADDI x9, x0, 55
        // EXECUTED
        memory[7] = 32'h03700493;

        // 0x20: ADDI x10, x0, 25
        // EXECUTED
        memory[8] = 32'h01900513;

        // 0x24: ADDI x11, x0, 30
        // x11 = 30
        memory[9] = 32'h01E00593;

        // 0x28: BNE x5, x8, +8
        // TAKEN because 10 != 20
        // Jump to 0x30
        memory[10] = 32'h00829463;

        // 0x2C: ADDI x12, x0, 99
        // SKIPPED
        memory[11] = 32'h06300613;

        // 0x30: ADDI x12, x0, 66
        // x12 = 66
        memory[12] = 32'h04200613;

        // 0x34: JAL x13, +8
        // x13 = PC + 4 = 0x38
        // Jump to 0x3C
        memory[13] = 32'h008006EF;

        // 0x38: ADDI x14, x0, 99
        // SKIPPED
        memory[14] = 32'h06300713;

        // 0x3C: ADDI x14, x0, 88
        // x14 = 88
        memory[15] = 32'h05800713;

        // 0x40: NOP
        memory[16] = 32'h00000013;

    end

    assign instruction = memory[address[9:2]];

endmodule