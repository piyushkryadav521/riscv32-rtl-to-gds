`timescale 1ns/1ps

module register_file_verification_tb;

    reg         clk;
    reg         reset;
    reg  [4:0]  rs1;
    reg  [4:0]  rs2;
    reg  [4:0]  rd;
    reg  [31:0] write_data;
    reg         reg_write;

    wire [31:0] read_data1;
    wire [31:0] read_data2;

    integer pass_count;
    integer fail_count;

    register_file dut (
        .clk        (clk),
        .reset      (reset),
        .rs1        (rs1),
        .rs2        (rs2),
        .rd         (rd),
        .write_data (write_data),
        .reg_write  (reg_write),
        .read_data1 (read_data1),
        .read_data2 (read_data2)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("sim/register_file_day24.vcd");
        $dumpvars(0, register_file_verification_tb);

        pass_count = 0;
        fail_count = 0;

        clk = 1'b0;
        reset = 1'b1;
        rs1 = 5'd0;
        rs2 = 5'd0;
        rd = 5'd0;
        write_data = 32'd0;
        reg_write = 1'b0;

        $display("");
        $display("========================================");
        $display("REGISTER FILE VERIFICATION");
        $display("========================================");

        // Reset
        #12;
        reset = 1'b0;

        // Write x5 = 100
        @(negedge clk);
        rd = 5'd5;
        write_data = 32'd100;
        reg_write = 1'b1;

        @(posedge clk);
        #1;

        // Read x5
        rs1 = 5'd5;
        #1;

        if (read_data1 == 32'd100) begin
            $display("WRITE/READ x5 : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("WRITE/READ x5 : FAIL - Got %0d", read_data1);
            fail_count = fail_count + 1;
        end

        // Write x10 = 200
        @(negedge clk);
        rd = 5'd10;
        write_data = 32'd200;
        reg_write = 1'b1;

        @(posedge clk);
        #1;

        rs1 = 5'd5;
        rs2 = 5'd10;
        #1;

        if ((read_data1 == 32'd100) &&
            (read_data2 == 32'd200)) begin
            $display("DUAL READ       : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("DUAL READ       : FAIL - x5=%0d x10=%0d",
                     read_data1, read_data2);
            fail_count = fail_count + 1;
        end

        // x0 must always be zero
        rs1 = 5'd0;
        rs2 = 5'd0;
        #1;

        if ((read_data1 == 32'd0) &&
            (read_data2 == 32'd0)) begin
            $display("x0 READ         : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("x0 READ         : FAIL - x0=%0d",
                     read_data1);
            fail_count = fail_count + 1;
        end

        // Attempt to write x0
        @(negedge clk);
        rd = 5'd0;
        write_data = 32'd999;
        reg_write = 1'b1;

        @(posedge clk);
        #1;

        rs1 = 5'd0;
        #1;

        if (read_data1 == 32'd0) begin
            $display("x0 WRITE BLOCK  : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("x0 WRITE BLOCK  : FAIL - x0=%0d",
                     read_data1);
            fail_count = fail_count + 1;
        end

        // Disable write and verify existing value remains
        @(negedge clk);
        reg_write = 1'b0;
        rd = 5'd5;
        write_data = 32'd9999;

        @(posedge clk);
        #1;

        rs1 = 5'd5;
        #1;

        if (read_data1 == 32'd100) begin
            $display("WRITE DISABLED  : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("WRITE DISABLED  : FAIL - Got %0d",
                     read_data1);
            fail_count = fail_count + 1;
        end

        $display("");
        $display("========================================");
        $display("PASS = %0d", pass_count);
        $display("FAIL = %0d", fail_count);
        $display("========================================");

        if (fail_count == 0)
            $display("REGISTER FILE VERIFICATION: PASS");
        else
            $display("REGISTER FILE VERIFICATION: FAIL");

        $display("========================================");

        $finish;

    end

endmodule