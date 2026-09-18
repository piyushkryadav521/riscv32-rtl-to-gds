`timescale 1ns/1ps

module riscv_cpu_day27_tb;

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

    always #5 clk = ~clk;

    task check_register;
        input [4:0] reg_num;
        input [31:0] expected;
        begin
            if (dut.registers.registers[reg_num] == expected) begin
                $display("PASS: x%0d = %0d", reg_num, expected);
                pass_count = pass_count + 1;
            end
            else begin
                $display(
                    "FAIL: x%0d = %0d, Expected = %0d",
                    reg_num,
                    dut.registers.registers[reg_num],
                    expected
                );
                fail_count = fail_count + 1;
            end
        end
    endtask

    task check_memory;
        input [7:0] mem_addr;
        input [31:0] expected;
        begin
            if (dut.dmem.memory[mem_addr] == expected) begin
                $display(
                    "PASS: Memory[%0d] = %0d",
                    mem_addr,
                    expected
                );
                pass_count = pass_count + 1;
            end
            else begin
                $display(
                    "FAIL: Memory[%0d] = %0d, Expected = %0d",
                    mem_addr,
                    dut.dmem.memory[mem_addr],
                    expected
                );
                fail_count = fail_count + 1;
            end
        end
    endtask

    initial begin

        $dumpfile("sim/riscv_cpu_day27.vcd");
        $dumpvars(0, riscv_cpu_day27_tb);

        clk = 1'b0;
        reset = 1'b1;

        pass_count = 0;
        fail_count = 0;

        #12;
        reset = 1'b0;

        // Allow complete program execution
        #120;

        $display("");
        $display("========================================");
        $display("I-TYPE & MEMORY VERIFICATION");
        $display("========================================");

        // Register checks
        check_register(5,  32'd25);
        check_register(6,  32'd15);
        check_register(7,  32'd9);
        check_register(8,  32'd31);
        check_register(9,  32'd31);
        check_register(10, 32'd36);
        check_register(11, 32'd36);
        check_register(12, 32'd67);

        // Memory checks
        check_memory(0, 32'd31);
        check_memory(1, 32'd36);

        // x0 must remain zero
        check_register(0, 32'd0);

        $display("");
        $display("PASS = %0d", pass_count);
        $display("FAIL = %0d", fail_count);

        if (fail_count == 0)
            $display("I-TYPE & MEMORY VERIFICATION: PASS");
        else
            $display("I-TYPE & MEMORY VERIFICATION: FAIL");

        $display("========================================");

        $finish;

    end

endmodule