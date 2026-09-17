`timescale 1ns/1ps

module top_tb;

    reg clk;
    reg reset;

    wire [31:0] pc;
    wire [31:0] instruction;

    // ==========================================
    // TOP-LEVEL CPU INSTANCE
 
    top dut (
        .clk         (clk),
        .reset       (reset),
        .pc          (pc),
        .instruction (instruction)
    );

    // Clock: 10 ns period
    always #5 clk = ~clk;

    // ==========================================
    // WAVEFORM
    // ==========================================

    initial begin
        $dumpfile("sim/top_day22.vcd");
        $dumpvars(0, top_tb);
    end

    // ==========================================
    // TEST

    initial begin

        clk   = 1'b0;
        reset = 1'b1;

        // Reset CPU
        #12;
        reset = 1'b0;

        // Allow CPU to execute several instructions
        #100;

        $display("");
        $display("========================================");
        $display("TOP-LEVEL VERIFICATION");

        $display("PC          = %h", pc);
        $display("Instruction = %h", instruction);

        $display("x5  = %0d", dut.cpu.registers.registers[5]);
        $display("x6  = %0d", dut.cpu.registers.registers[6]);
        $display("x7  = %0d", dut.cpu.registers.registers[7]);
        $display("x8  = %0d", dut.cpu.registers.registers[8]);
        $display("x9  = %0d", dut.cpu.registers.registers[9]);
        $display("x10 = %0d", dut.cpu.registers.registers[10]);

        $display("========================================");
        $display(" TOP-LEVEL VERIFICATION COMPLETE");

        $finish;

    end

    // ==========================================
    // EXECUTION TRACE
    // ==========================================

    always @(posedge clk) begin

        $display(
            "Time=%0t PC=%h Instruction=%h",
            $time,
            pc,
            instruction
        );

    end

endmodule