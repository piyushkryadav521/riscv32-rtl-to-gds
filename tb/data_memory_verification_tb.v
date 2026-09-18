`timescale 1ns/1ps

module data_memory_verification_tb;

    reg        clk;
    reg        mem_read;
    reg        mem_write;
    reg [31:0] address;
    reg [31:0] write_data;

    wire [31:0] read_data;

    integer pass_count;
    integer fail_count;

    data_memory dut (
        .clk        (clk),
        .mem_read   (mem_read),
        .mem_write  (mem_write),
        .address    (address),
        .write_data (write_data),
        .read_data  (read_data)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("sim/data_memory_day24.vcd");
        $dumpvars(0, data_memory_verification_tb);

        pass_count = 0;
        fail_count = 0;

        clk = 1'b0;
        mem_read = 1'b0;
        mem_write = 1'b0;
        address = 32'd0;
        write_data = 32'd0;

        $display("");
        $display("========================================");
        $display("DATA MEMORY VERIFICATION");
        $display("========================================");

        // ------------------------------------
        // Read address 0
        // Expected = 100
        // ------------------------------------
        mem_read = 1'b1;
        address = 32'd0;
        #2;

        if (read_data == 32'd100) begin
            $display("READ [0]       : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("READ [0]       : FAIL - Got %0d", read_data);
            fail_count = fail_count + 1;
        end

        // ------------------------------------
        // Read address 4
        // Expected = 200
        // ------------------------------------
        address = 32'd4;
        #2;

        if (read_data == 32'd200) begin
            $display("READ [4]       : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("READ [4]       : FAIL - Got %0d", read_data);
            fail_count = fail_count + 1;
        end

        // ------------------------------------
        // Read address 8
        // Expected = 300
        // ------------------------------------
        address = 32'd8;
        #2;

        if (read_data == 32'd300) begin
            $display("READ [8]       : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("READ [8]       : FAIL - Got %0d", read_data);
            fail_count = fail_count + 1;
        end

        // ------------------------------------
        // Write 500 to address 12
        // ------------------------------------
        @(negedge clk);

        mem_read = 1'b0;
        mem_write = 1'b1;
        address = 32'd12;
        write_data = 32'd500;

        @(posedge clk);
        #1;

        // ------------------------------------
        // Read address 12
        // Expected = 500
        // ------------------------------------
        mem_write = 1'b0;
        mem_read = 1'b1;
        address = 32'd12;
        #2;

        if (read_data == 32'd500) begin
            $display("WRITE/READ [12]: PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("WRITE/READ [12]: FAIL - Got %0d", read_data);
            fail_count = fail_count + 1;
        end

        // ------------------------------------
        // Write 999 to address 16
        // ------------------------------------
        @(negedge clk);

        mem_read = 1'b0;
        mem_write = 1'b1;
        address = 32'd16;
        write_data = 32'd999;

        @(posedge clk);
        #1;

        // Read address 16
        mem_write = 1'b0;
        mem_read = 1'b1;
        address = 32'd16;
        #2;

        if (read_data == 32'd999) begin
            $display("WRITE/READ [16]: PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("WRITE/READ [16]: FAIL - Got %0d", read_data);
            fail_count = fail_count + 1;
        end

        // ------------------------------------
        // Read disabled
        // ------------------------------------
        mem_read = 1'b0;
        address = 32'd0;
        #2;

        if (read_data == 32'd0) begin
            $display("READ DISABLED  : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("READ DISABLED  : FAIL - Got %0d", read_data);
            fail_count = fail_count + 1;
        end

        $display("");
        $display("========================================");
        $display("PASS = %0d", pass_count);
        $display("FAIL = %0d", fail_count);
        $display("========================================");

        if (fail_count == 0)
            $display("DATA MEMORY VERIFICATION: PASS");
        else
            $display("DATA MEMORY VERIFICATION: FAIL");

        $display("========================================");

        $finish;

    end

endmodule