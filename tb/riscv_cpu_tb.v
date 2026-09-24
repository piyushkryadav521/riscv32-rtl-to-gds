`timescale 1ns/1ps

module riscv_cpu_tb;

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

    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim/riscv_cpu_day21.vcd");
        $dumpvars(0, riscv_cpu_tb);
    end

    initial begin

        clk   = 1'b0;
        reset = 1'b1;

        // Reset CPU
        #12;
        reset = 1'b0;

        // Run complete branch and jump program
        #110;

        $display("");
        $display("========================================");
        $display(" BRANCH + JUMP VERIFICATION");
        

        $display("x5  = %0d  (Expected 10)",
                 dut.registers.registers[5]);

        $display("x6  = %0d  (Expected 10)",
                 dut.registers.registers[6]);

        $display("x7  = %0d  (Expected 77)",
                 dut.registers.registers[7]);

        $display("x8  = %0d  (Expected 20)",
                 dut.registers.registers[8]);

        $display("x9  = %0d  (Expected 55)",
                 dut.registers.registers[9]);

        $display("x10 = %0d  (Expected 25)",
                 dut.registers.registers[10]);

        $display("========================================");
        $display(" VERIFICATION COMPLETE");

        $finish;

    end

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