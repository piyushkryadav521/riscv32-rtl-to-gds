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
        $dumpfile("sim/riscv_cpu_day18.vcd");
        $dumpvars(0, riscv_cpu_tb);
    end

    initial begin

        clk   = 1'b0;
        reset = 1'b1;

        // Hold reset
        #12;
        reset = 1'b0;

        // Initialize source registers for Day 18 tests
        dut.registers.registers[6]  = 32'd25;
        dut.registers.registers[7]  = 32'd15;

        dut.registers.registers[9]  = 32'd25;
        dut.registers.registers[10] = 32'd15;

        dut.registers.registers[12] = 32'd15;
        dut.registers.registers[13] = 32'd7;

        dut.registers.registers[15] = 32'd15;
        dut.registers.registers[16] = 32'd5;

        dut.registers.registers[18] = 32'd12;
        dut.registers.registers[19] = 32'd10;

        dut.registers.registers[21] = 32'd5;
        dut.registers.registers[22] = 32'd10;

        // Run CPU
        #100;

        $display("");
        $display("========================================");
        $display("REGISTER + ALU VERIFICATION");

        $display("x5  = %0d  (Expected 40)", dut.registers.registers[5]);
        $display("x8  = %0d  (Expected 10)", dut.registers.registers[8]);
        $display("x11 = %0d  (Expected 7)", dut.registers.registers[11]);
        $display("x14 = %0d  (Expected 15)", dut.registers.registers[14]);
        $display("x17 = %0d  (Expected 6)", dut.registers.registers[17]);
        $display("x20 = %0d  (Expected 1)", dut.registers.registers[20]);
        $display("x23 = %0d  (Expected 50)", dut.registers.registers[23]);
        $display("x24 = %0d  (Expected 2)", dut.registers.registers[24]);
        $display("x25 = %0d  (Expected 10)", dut.registers.registers[25]);

        $display("VERIFICATION COMPLETE");

        $finish;

    end

    always @(posedge clk) begin

        $display("Time=%0t PC=%h Instruction=%h ALU=%h WB=%h",
                 $time,
                 pc,
                 instruction,
                 dut.alu_result,
                 dut.write_back_data);

    end

endmodule