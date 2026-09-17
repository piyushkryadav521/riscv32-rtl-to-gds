`timescale 1ns/1ps

module riscv_cpu_day23_tb;

    reg clk;
    reg reset;

    wire [31:0] pc;
    wire [31:0] instruction;

    riscv_cpu dut (
        .clk         (clk),
        .reset       (reset),
        .pc          (pc),
        .instruction (instruction)
    );

    // 10 ns clock period
    always #5 clk = ~clk;

    // Waveform
    initial begin
        $dumpfile("sim/riscv_cpu_day23.vcd");
        $dumpvars(0, riscv_cpu_day23_tb);
    end

    // Test
    initial begin

        clk   = 1'b0;
        reset = 1'b1;

        // Reset CPU
        #12;
        reset = 1'b0;

        // Allow complete program execution
        #180;

        $display("");
        $display("========================================");
        $display(" BASIC PROGRAM EXECUTION");
        $display("========================================");

        $display("x5  = %0d  (Expected 10)",
                 dut.registers.registers[5]);

        $display("x6  = %0d  (Expected 20)",
                 dut.registers.registers[6]);

        $display("x7  = %0d  (Expected 30)",
                 dut.registers.registers[7]);

        $display("x8  = %0d  (Expected 20)",
                 dut.registers.registers[8]);

        $display("x9  = %0d  (Expected 20)",
                 dut.registers.registers[9]);

        $display("x10 = %0d  (Expected 30)",
                 dut.registers.registers[10]);

        $display("x11 = %0d  (Expected 30)",
                 dut.registers.registers[11]);

        $display("x12 = %0d  (Expected 55)",
                 dut.registers.registers[12]);

        $display("x13 = %0d  (Expected 48)",
                 dut.registers.registers[13]);

        $display("x14 = %0d  (Expected 88)",
                 dut.registers.registers[14]);

        $display("Memory[0] = %0d  (Expected 30)",
                 dut.dmem.memory[0]);

        $display("========================================");
        $display("VERIFICATION COMPLETE");

        $finish;

    end

    // Execution trace
    always @(posedge clk) begin

        $display(
            "Time=%0t PC=%h Instruction=%h Immediate=%h ALU=%h WB=%h",
            $time,
            pc,
            instruction,
            dut.immediate,
            dut.alu_result,
            dut.write_back_data
        );

        $display(
            "       RegWrite=%b MemRead=%b MemWrite=%b ALUSrc=%b MemToReg=%b Branch=%b BranchTaken=%b Jump=%b",
            dut.reg_write,
            dut.mem_read,
            dut.mem_write,
            dut.alu_src,
            dut.mem_to_reg,
            dut.branch,
            dut.branch_taken,
            dut.jump
        );

    end

endmodule