`timescale 1ns/1ps

module immediate_generator_verification_tb;

    reg  [31:0] instruction;
    wire [31:0] immediate;

    integer pass_count;
    integer fail_count;

    immediate_generator dut (
        .instruction(instruction),
        .immediate(immediate)
    );

    initial begin

        $dumpfile("sim/immediate_generator_day24.vcd");
        $dumpvars(0, immediate_generator_verification_tb);

        pass_count = 0;
        fail_count = 0;

        $display("");
        $display("========================================");
        $display("IMMEDIATE GENERATOR VERIFICATION");
        $display("========================================");

        // ------------------------------------
        // ADDI x5, x0, 10
        // ------------------------------------
        instruction = 32'h00A00293;
        #10;

        if (immediate == 32'd10) begin
            $display("ADDI +10       : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("ADDI +10       : FAIL - Got %0d", immediate);
            fail_count = fail_count + 1;
        end

        // ------------------------------------
        // ADDI x5, x0, -5
        // ------------------------------------
        instruction = 32'hFFB00293;
        #10;

        if ($signed(immediate) == -5) begin
            $display("ADDI -5        : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("ADDI -5        : FAIL - Got %0d",
                     $signed(immediate));
            fail_count = fail_count + 1;
        end

        // ------------------------------------
        // LW x5, 20(x0)
        // ------------------------------------
        instruction = 32'h01402283;
        #10;

        if (immediate == 32'd20) begin
            $display("LW +20         : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("LW +20         : FAIL - Got %0d", immediate);
            fail_count = fail_count + 1;
        end

        // ------------------------------------
        // SW x5, 20(x0)
        // ------------------------------------
        instruction = 32'h00502A23;
        #10;

        if (immediate == 32'd20) begin
            $display("SW +20         : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("SW +20         : FAIL - Got %0d", immediate);
            fail_count = fail_count + 1;
        end

        // ------------------------------------
        // BEQ +8
        // ------------------------------------
        instruction = 32'h00628463;
        #10;

        if (immediate == 32'd8) begin
            $display("BEQ +8         : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("BEQ +8         : FAIL - Got %0d", immediate);
            fail_count = fail_count + 1;
        end

        // ------------------------------------
        // JAL +8
        // ------------------------------------
        instruction = 32'h008000EF;
        #10;

        if (immediate == 32'd8) begin
            $display("JAL +8         : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("JAL +8         : FAIL - Got %0d", immediate);
            fail_count = fail_count + 1;
        end

        // ------------------------------------
        // LUI
        // ------------------------------------
        instruction = 32'h123450B7;
        #10;

        if (immediate == 32'h12345000) begin
            $display("LUI             : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("LUI             : FAIL - Got %h", immediate);
            fail_count = fail_count + 1;
        end

        // ------------------------------------
        // INVALID opcode
        // ------------------------------------
        instruction = 32'hFFFFFFFF;
        #10;

        if (immediate == 32'b0) begin
            $display("INVALID         : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("INVALID         : FAIL - Got %h", immediate);
            fail_count = fail_count + 1;
        end

        $display("");
        $display("========================================");
        $display("PASS = %0d", pass_count);
        $display("FAIL = %0d", fail_count);
        $display("========================================");

        if (fail_count == 0)
            $display("IMMEDIATE GENERATOR VERIFICATION: PASS");
        else
            $display("IMMEDIATE GENERATOR VERIFICATION: FAIL");

        $display("========================================");

        $finish;

    end

endmodule