`timescale 1ns/1ps

module riscv_cpu_day26_tb;

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

    initial begin

        $dumpfile("sim/riscv_cpu_day26.vcd");
        $dumpvars(0, riscv_cpu_day26_tb);

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
        $display("R-TYPE VERIFICATION");
        $display("========================================");

        check_register(5,  32'd25);
        check_register(6,  32'd15);
        check_register(7,  32'd40);
        check_register(8,  32'd10);
        check_register(9,  32'd9);
        check_register(10, 32'd31);
        check_register(11, 32'd22);
        check_register(12, 32'd1);
        check_register(13, 32'd50);
        check_register(14, 32'd10);
        check_register(0,  32'd0);

        $display("");
        $display("PASS = %0d", pass_count);
        $display("FAIL = %0d", fail_count);

        if (fail_count == 0)
            $display("R-TYPE VERIFICATION: PASS");
        else
            $display("R-TYPE VERIFICATION: FAIL");

        $display("========================================");

        $finish;

    end

endmodule