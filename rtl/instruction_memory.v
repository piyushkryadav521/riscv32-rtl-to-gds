`timescale 1ns/1ps

module instruction_memory (
    input  wire [31:0] address,
    output wire [31:0] instruction
);

    reg [31:0] memory [0:255];

    initial begin

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
      // memory[0] = 31
      memory[4] = 32'h00802023;

      // LW x9, 0(x0)
      // x9 = 31
      memory[5] = 32'h00002483;

      // BEQ x9, x8, +8
      // Branch to instruction at PC = 28
      memory[6] = 32'h00848463;

      // This instruction should be skipped
      // ADDI x10, x0, 99
      memory[7] = 32'h06300513;

      // Target
      // ADDI x10, x0, 77
      memory[8] = 32'h04D00513;

      // BNE x5, x6, +8
      // 25 != 15 → branch taken
      memory[9] = 32'h00629463;

      // This instruction should be skipped
      // ADDI x11, x0, 88
      memory[10] = 32'h05800593;

      // Target
      // ADDI x11, x0, 66
      memory[11] = 32'h04200593;

      // NOP
      memory[12] = 32'h00000013;

    end

    assign instruction = memory[address[9:2]];

endmodule