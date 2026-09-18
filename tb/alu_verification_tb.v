`timescale 1ns/1ps

module alu_verification_tb;

    reg [31:0] a;
    reg [31:0] b;
    reg [3:0]  alu_control;

    wire [31:0] result;
    wire        zero;

    integer pass_count;
    integer fail_count;

    alu dut (
        .a           (a),
        .b           (b),
        .alu_control (alu_control),
        .result      (result),
        .zero        (zero)
    );

    initial begin

        $dumpfile("sim/alu_day24.vcd");
        $dumpvars(0, alu_verification_tb);

        pass_count = 0;
        fail_count = 0;

        $display("");
        $display("========================================");
        $display("ALU VERIFICATION");
        $display("========================================");

        // ADD
        a = 32'd25;
        b = 32'd15;
        alu_control = 4'b0000;
        #10;

        if (result == 32'd40) begin
            $display("ADD  : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("ADD  : FAIL - Got %0d", result);
            fail_count = fail_count + 1;
        end

        // SUB
        a = 32'd25;
        b = 32'd15;
        alu_control = 4'b0001;
        #10;

        if (result == 32'd10) begin
            $display("SUB  : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("SUB  : FAIL - Got %0d", result);
            fail_count = fail_count + 1;
        end

        // AND
        a = 32'h0F0F0F0F;
        b = 32'h00FF00FF;
        alu_control = 4'b0010;
        #10;

        if (result == 32'h000F000F) begin
            $display("AND  : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("AND  : FAIL - Got %h", result);
            fail_count = fail_count + 1;
        end

        // OR
        a = 32'h0F000F00;
        b = 32'h00FF00FF;
        alu_control = 4'b0011;
        #10;

        if (result == 32'h0FFF0FFF) begin
            $display("OR   : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("OR   : FAIL - Got %h", result);
            fail_count = fail_count + 1;
        end

        // XOR
        a = 32'h0F0F0F0F;
        b = 32'h00FF00FF;
        alu_control = 4'b0100;
        #10;

        if (result == 32'h0FF00FF0) begin
            $display("XOR  : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("XOR  : FAIL - Got %h", result);
            fail_count = fail_count + 1;
        end

        // SLT
        a = 32'd10;
        b = 32'd20;
        alu_control = 4'b0101;
        #10;

        if (result == 32'd1) begin
            $display("SLT  : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("SLT  : FAIL - Got %0d", result);
            fail_count = fail_count + 1;
        end

        // SLT false case
        a = 32'd20;
        b = 32'd10;
        alu_control = 4'b0101;
        #10;

        if (result == 32'd0) begin
            $display("SLT-F: PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("SLT-F: FAIL - Got %0d", result);
            fail_count = fail_count + 1;
        end

        // Zero flag
        a = 32'd25;
        b = 32'd25;
        alu_control = 4'b0001;
        #10;

        if ((result == 32'd0) && (zero == 1'b1)) begin
            $display("ZERO : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("ZERO : FAIL - Result=%0d Zero=%b",
                     result, zero);
            fail_count = fail_count + 1;
        end

        $display("");
        $display("========================================");
        $display("PASS = %0d", pass_count);
        $display("FAIL = %0d", fail_count);
        $display("========================================");

        if (fail_count == 0)
            $display("ALU VERIFICATION: PASS");
        else
            $display("ALU VERIFICATION: FAIL");

        $display("========================================");

        $finish;

    end

endmodule