`timescale 1ns/1ps

module register_file_tb;

    reg         clk;
    reg         reset;

    reg  [4:0]  rs1;
    reg  [4:0]  rs2;
    reg  [4:0]  rd;

    reg  [31:0] write_data;
    reg         reg_write;

    wire [31:0] read_data1;
    wire [31:0] read_data2;

    // Register File
    register_file uut (
        .clk(clk),
        .reset(reset),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .reg_write(reg_write),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin

        // VCD
        $dumpfile("sim/register_file.vcd");
        $dumpvars(0, register_file_tb);

        // Initial values
        clk = 0;
        reset = 1;
        rs1 = 0;
        rs2 = 0;
        rd = 0;
        write_data = 0;
        reg_write = 0;

        // Reset
        #10;
        reset = 0;

        // Write 25 into x6
        rd = 5'd6;
        write_data = 32'd25;
        reg_write = 1;

        #10;

        // Write 15 into x7
        rd = 5'd7;
        write_data = 32'd15;

        #10;

        // Stop writing
        reg_write = 0;

        // Read x6 and x7
        rs1 = 5'd6;
        rs2 = 5'd7;

        #5;

        $display("===== REGISTER FILE TEST =====");
        $display("x6 = %d", read_data1);
        $display("x7 = %d", read_data2);

        // Test x0
        rs1 = 5'd0;
        rs2 = 5'd0;

        #5;

        $display("x0 = %d", read_data1);

        $finish;
    end

endmodule