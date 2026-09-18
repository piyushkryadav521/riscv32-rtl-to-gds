`timescale 1ns/1ps

module riscv_cpu_day25_tb;

    reg clk;
    reg reset;

    wire [31:0] pc;
    wire [31:0] instruction;

    integer pass_count;
    integer fail_count;

    riscv_cpu dut (
        .clk         (clk),
        .reset       (reset),
        .pc          (pc),
        .instruction (instruction)
    );

    // 10 ns clock period
    always #5 clk = ~clk;

    initial begin

        $dumpfile("sim/riscv_cpu_day25.vcd");
        $dumpvars(0, riscv_cpu_day25_tb);

        clk = 1'b0;
        reset = 1'b1;

        pass_count = 0;
        fail_count = 0;

        $display("");
        $display("========================================");
        $display("CPU-LEVEL REGRESSION");
        $display("========================================");

        // Reset CPU
        #12;
        reset = 1'b0;

        // Allow complete program execution
        #180;

        // ====================================
        // REGISTER CHECKS
        // ====================================

        if (dut.registers.registers[5] == 32'd10) begin
            $display("x5  = 10  : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("x5  : FAIL - Got %0d",
                     dut.registers.registers[5]);
            fail_count = fail_count + 1;
        end

        if (dut.registers.registers[6] == 32'd20) begin
            $display("x6  = 20  : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("x6  : FAIL - Got %0d",
                     dut.registers.registers[6]);
            fail_count = fail_count + 1;
        end

        if (dut.registers.registers[7] == 32'd30) begin
            $display("x7  = 30  : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("x7  : FAIL - Got %0d",
                     dut.registers.registers[7]);
            fail_count = fail_count + 1;
        end

        if (dut.registers.registers[8] == 32'd20) begin
            $display("x8  = 20  : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("x8  : FAIL - Got %0d",
                     dut.registers.registers[8]);
            fail_count = fail_count + 1;
        end

        if (dut.registers.registers[9] == 32'd20) begin
            $display("x9  = 20  : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("x9  : FAIL - Got %0d",
                     dut.registers.registers[9]);
            fail_count = fail_count + 1;
        end

        if (dut.registers.registers[10] == 32'd30) begin
            $display("x10 = 30  : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("x10 : FAIL - Got %0d",
                     dut.registers.registers[10]);
            fail_count = fail_count + 1;
        end

        if (dut.registers.registers[11] == 32'd30) begin
            $display("x11 = 30  : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("x11 : FAIL - Got %0d",
                     dut.registers.registers[11]);
            fail_count = fail_count + 1;
        end

        if (dut.registers.registers[12] == 32'd55) begin
            $display("x12 = 55  : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("x12 : FAIL - Got %0d",
                     dut.registers.registers[12]);
            fail_count = fail_count + 1;
        end

        if (dut.registers.registers[13] == 32'd48) begin
            $display("x13 = 48  : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("x13 : FAIL - Got %0d",
                     dut.registers.registers[13]);
            fail_count = fail_count + 1;
        end

        if (dut.registers.registers[14] == 32'd88) begin
            $display("x14 = 88  : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("x14 : FAIL - Got %0d",
                     dut.registers.registers[14]);
            fail_count = fail_count + 1;
        end

        // ====================================
        // MEMORY CHECK
        // ====================================

        if (dut.dmem.memory[0] == 32'd30) begin
            $display("Memory[0] = 30 : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("Memory[0] : FAIL - Got %0d",
                     dut.dmem.memory[0]);
            fail_count = fail_count + 1;
        end

        // ====================================
        // x0 CHECK
        // ====================================

        if (dut.registers.registers[0] == 32'd0) begin
            $display("x0 = 0       : PASS");
            pass_count = pass_count + 1;
        end
        else begin
            $display("x0 : FAIL - Got %0d",
                     dut.registers.registers[0]);
            fail_count = fail_count + 1;
        end

        // ====================================
        // FINAL SUMMARY
        // ====================================

        $display("");
        $display("========================================");
        $display("PASS = %0d", pass_count);
        $display("FAIL = %0d", fail_count);
        $display("========================================");

        if (fail_count == 0)
            $display("CPU REGRESSION: PASS");
        else
            $display("CPU REGRESSION: FAIL");

        $display("========================================");

        $finish;

    end

endmodule