`timescale 1ns/1ps

module riscv_cpu_trace_tb;

    reg clk;
    reg reset;

    wire [31:0] pc;
    wire [31:0] instruction;

    integer cycle;

    riscv_cpu dut (
        .clk         (clk),
        .reset       (reset),
        .pc          (pc),
        .instruction (instruction)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("sim/riscv_cpu_day25_trace.vcd");
        $dumpvars(0, riscv_cpu_trace_tb);

        clk = 1'b0;
        reset = 1'b1;
        cycle = 0;

        $display("");
        $display("==============================================");
        $display("PU EXECUTION TRACE");
        $display("==============================================");
        $display("Cycle  PC Instruction");
        $display("----------------------------------------------");

        #12;
        reset = 1'b0;

        // Run the complete program
        #180;

        $display("----------------------------------------------");
        $display("CPU EXECUTION TRACE COMPLETE");
        $display("==============================================");

        $finish;

    end

    always @(posedge clk) begin

        if (!reset) begin
            cycle = cycle + 1;

            $display(
                "%4d     %h     %h",
                cycle,
                pc,
                instruction
            );
        end

    end

endmodule