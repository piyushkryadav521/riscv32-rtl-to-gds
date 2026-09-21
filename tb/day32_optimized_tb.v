`timescale 1ns/1ps

module day32_optimized_tb;

    reg clk;
    reg reset;

    wire [31:0] pc;
    wire [31:0] instruction;

    // Synthesized top-level design
    top dut (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instruction(instruction)
    );

    // Clock
    always #5 clk = ~clk;

    initial begin

        clk = 1'b0;
        reset = 1'b1;

        #10;
        reset = 1'b0;

        // Run processor
        #200;

        $display("========================================");
        $display("DOPTIMIZED NETLIST TEST");
        $display("========================================");
        $display("PC          = %h", pc);
        $display("Instruction = %h", instruction);
        $display("OPTIMIZED NETLIST SIMULATION COMPLETE");
        $display("========================================");

        $finish;
    end

endmodule