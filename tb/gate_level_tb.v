`timescale 1ns/1ps

module gate_level_tb;

    reg clk;
    reg reset;

    wire [31:0] pc;
    wire [31:0] instruction;

    // Synthesized CPU
    top dut (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instruction(instruction)
    );

    // Clock: 10 ns period
    always #5 clk = ~clk;


    always @(posedge clk) begin
        if (!reset)
            $display("TIME=%0t  PC=%h  INSTRUCTION=%h",$time, pc, instruction);
    end

    initial begin

        $dumpfile("sim/gate_level/riscv32_gate_level.vcd");
        $dumpvars(0, gate_level_tb);

        clk = 1'b0;
        reset = 1'b1;

        // Reset
        #20;
        reset = 1'b0;

        // Run synthesized CPU
        #140;

        $display("========================================");
        $display("GATE-LEVEL SIMULATION");
        $display("========================================");

        $display("Final PC          = %h", pc);
        $display("Current Instruction = %h", instruction);

        $display("========================================");
        $display("GATE-LEVEL SIMULATION COMPLETE");
        $display("========================================");

        $finish;
    end

endmodule