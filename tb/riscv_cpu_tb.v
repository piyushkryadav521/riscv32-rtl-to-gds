`timescale 1ns/1ps

module riscv_cpu_tb;

    reg clk;
    reg reset;

    wire [31:0] pc;
    wire [31:0] instruction;

    // ============================================
    // DUT
    // ============================================

    riscv_cpu dut (
        .clk         (clk),
        .reset       (reset),
        .pc          (pc),
        .instruction (instruction)
    );

    // ============================================
    // Clock Generation
    // ============================================

    always #5 clk = ~clk;

    // ============================================
    // Waveform Dump
    // ============================================

    initial begin
        $dumpfile("sim/riscv_cpu.vcd");
        $dumpvars(0, riscv_cpu_tb);
    end

    // ============================================
    // Test
    // ============================================

    initial begin

        clk   = 1'b0;
        reset = 1'b1;

        // Keep reset active
        #12;

        // Release reset
        reset = 1'b0;

        // ========================================
        // Allow CPU to execute
        // ========================================

        #60;

        // ========================================
        // Branch Verification
        // ========================================

        $display("========================================");
        $display("BRANCH CPU VERIFICATION");
        $display("========================================");

        $display("x5 = %0d", dut.registers.registers[5]);
        $display("x6 = %0d", dut.registers.registers[6]);
        $display("x7 = %0d", dut.registers.registers[7]);

        $display("========================================");

        $finish;

    end

    // ============================================
    // CPU Monitor
    // ============================================

    always @(posedge clk) begin

        $display("Time=%0t PC=%h Instruction=%h ALU=%h WB=%h",
             $time,
             pc,
             instruction,
             dut.alu_result,
             dut.write_back_data);

        $display("        Immediate=%h Branch=%b BranchTaken=%b BranchTarget=%h NextPC=%h",
             dut.immediate,
             dut.branch,
             dut.branch_taken,
             dut.branch_target,
             dut.next_pc);

    end

endmodule