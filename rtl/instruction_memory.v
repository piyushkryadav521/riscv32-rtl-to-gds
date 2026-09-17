`timescale 1ns/1ps

module instruction_memory (
    input  wire [31:0] address,
    output wire [31:0] instruction
);

    reg [31:0] memory [0:255];

    initial begin

        // ==========================================
        //  COMPLETE RV32I PROGRAM
    

        // 1. ADDI x5, x0, 10
       // x5 = 10
       memory[0] = 32'h00A00293;

       // 2. ADDI x6, x0, 20
      // x6 = 20
      memory[1] = 32'h01400313;

       // 3. ADD x7, x5, x6
      // x7 = 10 + 20 = 30
      memory[2] = 32'h006283B3;

       // 4. SUB x8, x7, x5
      // x8 = 30 - 10 = 20
      memory[3] = 32'h40538433;

      // 5. AND x9, x7, x6
      // x9 = 30 & 20 = 20
      memory[4] = 32'h0063F4B3;

       // 6. OR x10, x5, x6
       // x10 = 10 | 20 = 30
       memory[5] = 32'h0062E533;

       // 7. SW x7, 0(x0)
      // Memory[0] = 30
     memory[6] = 32'h00702023;

      // 8. LW x11, 0(x0)
      // x11 = Memory[0] = 30
      memory[7] = 32'h00002583;

      // 9. BEQ x11, x7, +8
      // Branch taken → skip next instruction
      memory[8] = 32'h00758463;

      // 10. ADDI x12, x0, 99
      // Should be skipped
      memory[9] = 32'h06300613;

      // 11. ADDI x12, x0, 55
      // x12 = 55
      memory[10] = 32'h03700613;

      // 12. JAL x13, +8
      // x13 = PC + 4
      memory[11] = 32'h008006EF;

      // 13. ADDI x14, x0, 99
      // Should be skipped
      memory[12] = 32'h06300713;

      // 14. ADDI x14, x0, 88
      // x14 = 88
      memory[13] = 32'h05800713;

      // 15. NOP
      memory[14] = 32'h00000013;

    end

    assign instruction = memory[address[9:2]];

endmodule