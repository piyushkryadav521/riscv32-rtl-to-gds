`timescale 1ns/1ps

module program_counter_tb;

    reg        clk;
    reg        reset;
    reg [31:0] next_pc;

    wire [31:0] pc;

    program_counter uut (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc(pc)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("sim/program_counter.vcd");
        $dumpvars(0, program_counter_tb);

        clk = 0;
        reset = 1;
        next_pc = 32'd0;

        #10;

        reset = 0;

        // PC = 4
        next_pc = 32'd4;
        #10;
        $display("PC = %d", pc);

        // PC = 8
        next_pc = 32'd8;
        #10;
        $display("PC = %d", pc);

        // PC = 12
        next_pc = 32'd12;
        #10;
        $display("PC = %d", pc);

        // PC = 16
        next_pc = 32'd16;
        #10;
        $display("PC = %d", pc);

        $finish;

    end

endmodule