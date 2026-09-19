`timescale 1ns/1ps

module riscv_cpu_day28_tb;

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

        $dumpfile("sim/riscv_cpu_day28.vcd");
        $dumpvars(0, riscv_cpu_day28_tb);

        clk = 1'b0;
        reset = 1'b1;

        pass_count = 0;
        fail_count = 0;

        #12;
        reset = 1'b0;

        // Allow complete program execution
        #180;

        $display("");
        $display("========================================");
        $display("BRANCH & JUMP VERIFICATION");
        $display("========================================");

        // Basic register values
        check_register(5,  32'd10);
        check_register(6,  32'd10);

        // BEQ taken: x7 must be 77, not 99
        check_register(7,  32'd77);

        // BNE not taken: x9 must execute
        check_register(9,  32'd55);

        // Instruction after BNE not taken
        check_register(10, 32'd25);

        // BNE taken: x12 must be 66, not 99
        check_register(12, 32'd66);

        // JAL return address
        // JAL at PC 0x34 → PC + 4 = 0x38 = 56
        check_register(13, 32'd56);

        // Instruction after JAL must be skipped
        check_register(14, 32'd88);

        // x8 used to make BNE taken
        check_register(8, 32'd20);

        // x11 executed before second BNE
        check_register(11, 32'd30);

        // x0 must remain zero
        check_register(0, 32'd0);

        $display("");
        $display("PASS = %0d", pass_count);
        $display("FAIL = %0d", fail_count);

        if (fail_count == 0)
            $display("BRANCH & JUMP VERIFICATION: PASS");
        else
            $display("BRANCH & JUMP VERIFICATION: FAIL");

        $display("========================================");

        $finish;

    end

endmodule