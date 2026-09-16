`timescale 1ns/1ps

module instruction_memory (
    input  wire [31:0] address,
    output wire [31:0] instruction
);

    reg [31:0] memory [0:255];

    initial begin

        // ==========================================
        // MEMORY INTEGRATION TEST
        
        // ADDI x5, x0, 100
        // x5 = 100
        memory[0] = 32'h06400293;

        // ADDI x6, x0, 200
        // x6 = 200
        memory[1] = 32'h0C800313;

        // SW x5, 0(x0)
        // memory[0] = 100
        memory[2] = 32'h00502023;

        // SW x6, 4(x0)
        // memory[1] = 200
        memory[3] = 32'h00602223;

        // LW x7, 0(x0)
        // x7 = 100
        memory[4] = 32'h00002383;

        // LW x8, 4(x0)
        // x8 = 200
        memory[5] = 32'h00402403;

        // ADD x9, x7, x8
        // x9 = 100 + 200 = 300
        memory[6] = 32'h008384B3;

        // SW x9, 8(x0)
        // memory[2] = 300
        memory[7] = 32'h00902423;

        // LW x10, 8(x0)
        // x10 = 300
        memory[8] = 32'h00802503;

        // NOP
        memory[9] = 32'h00000013;

    end

    assign instruction = memory[address[9:2]];

endmodule