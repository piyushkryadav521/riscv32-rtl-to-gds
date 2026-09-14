`timescale 1ns/1ps

module data_memory_tb;

    reg        clk;
    reg        mem_read;
    reg        mem_write;

    reg [31:0] address;
    reg [31:0] write_data;

    wire [31:0] read_data;

    data_memory uut (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("sim/data_memory.vcd");
        $dumpvars(0, data_memory_tb);

        clk = 0;
        mem_read = 0;
        mem_write = 0;
        address = 32'd0;
        write_data = 32'd0;

        $display("===== DATA MEMORY TEST =====");

        // -----------------------------------------
        // Test 1: Read memory[0]
        // Address = 0
        // Expected = 100
        // -----------------------------------------
        mem_read = 1;
        address = 32'd0;

        #10;

        $display("READ  Address=%d Data=%d", address, read_data);

        // -----------------------------------------
        // Test 2: Read memory[1]
        // Address = 4
        // Expected = 200
        // -----------------------------------------
        address = 32'd4;

        #10;

        $display("READ  Address=%d Data=%d", address, read_data);

        // -----------------------------------------
        // Test 3: Read memory[2]
        // Address = 8
        // Expected = 300
        // -----------------------------------------
        address = 32'd8;

        #10;

        $display("READ  Address=%d Data=%d", address, read_data);

        // -----------------------------------------
        // Test 4: Write 500 to address 12
        // -----------------------------------------
        mem_read = 0;
        mem_write = 1;
        address = 32'd12;
        write_data = 32'd500;

        #10;

        $display("WRITE Address=%d Data=%d", address, write_data);

        // -----------------------------------------
        // Test 5: Read address 12
        // Expected = 500
        // -----------------------------------------
        mem_write = 0;
        mem_read = 1;

        #10;

        $display("READ  Address=%d Data=%d", address, read_data);

        // -----------------------------------------
        // Test 6: Memory read disabled
        // Expected = 0
        // -----------------------------------------
        mem_read = 0;
        address = 32'd0;

        #10;

        $display("READ DISABLED Data=%d", read_data);

        $display("================================");
        $display("DATA MEMORY TEST COMPLETE");
        $display("================================");

        $finish;

    end

endmodule