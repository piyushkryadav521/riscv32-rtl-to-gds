`timescale 1ns/1ps

module immediate_generator_tb;

    reg  [31:0] instruction;
    wire [31:0] immediate;

    immediate_generator uut (
        .instruction(instruction),
        .immediate(immediate)
    );

    initial begin

        $dumpfile("sim/immediate_generator.vcd");
        $dumpvars(0, immediate_generator_tb);

        // -----------------------------------------
        // Test 1: ADDI x5, x6, 10
        // Immediate = 10
        // -----------------------------------------
        instruction = 32'b000000001010_00110_000_00101_0010011;

        #10;

        $display("===== IMMEDIATE GENERATOR TEST =====");
        $display("ADDI Immediate = %d", $signed(immediate));

        // -----------------------------------------
        // Test 2: SW x5, 20(x6)
        // Immediate = 20
        // -----------------------------------------
        instruction = 32'b0000000_00101_00110_010_10100_0100011;

        #10;

        $display("SW Immediate   = %d", $signed(immediate));

        // -----------------------------------------
        // Test 3: BEQ x5, x6, 8
        // Immediate = 8
        // -----------------------------------------
        instruction = 32'b0000000_00110_00101_000_01000_1100011;

        #10;

        $display("BEQ Immediate  = %d", $signed(immediate));

        // -----------------------------------------
        // Test 4: ADDI x5, x6, -5
        // Tests sign extension
        // -----------------------------------------
        instruction = 32'b111111111011_00110_000_00101_0010011;

        #10;

        $display("ADDI -5 Imm.   = %d", $signed(immediate));

        $finish;

    end

endmodule