`timescale 1ns/1ps

module alu_control_verification_tb;

    reg [6:0] opcode;
    reg [2:0] funct3;
    reg [6:0] funct7;

    wire [3:0] alu_control;

    integer pass_count;
    integer fail_count;

    alu_control dut (
        .opcode      (opcode),
        .funct3      (funct3),
        .funct7      (funct7),
        .alu_control (alu_control)
    );

    task check_alu_control;
        input [6:0] test_opcode;
        input [2:0] test_funct3;
        input [6:0] test_funct7;
        input [3:0] expected_control;

        begin

            opcode = test_opcode;
            funct3 = test_funct3;
            funct7 = test_funct7;

            #10;

            if (alu_control == expected_control) begin
                $display(
                    "Opcode=%b funct3=%b funct7=%b : PASS",
                    test_opcode, test_funct3, test_funct7
                );
                pass_count = pass_count + 1;
            end
            else begin
                $display(
                    "Opcode=%b funct3=%b funct7=%b : FAIL - Got %b Expected %b",
                    test_opcode,
                    test_funct3,
                    test_funct7,
                    alu_control,
                    expected_control
                );
                fail_count = fail_count + 1;
            end

        end
    endtask

    initial begin

        $dumpfile("sim/alu_control_day24.vcd");
        $dumpvars(0, alu_control_verification_tb);

        pass_count = 0;
        fail_count = 0;

        $display("");
        $display("========================================");
        $display("ALU CONTROL VERIFICATION");
        $display("========================================");

        // ====================================
        // R-TYPE
        // ====================================

        // ADD
        check_alu_control(
            7'b0110011,
            3'b000,
            7'b0000000,
            4'b0000
        );

        // SUB
        check_alu_control(
            7'b0110011,
            3'b000,
            7'b0100000,
            4'b0001
        );

        // AND
        check_alu_control(
            7'b0110011,
            3'b111,
            7'b0000000,
            4'b0010
        );

        // OR
        check_alu_control(
            7'b0110011,
            3'b110,
            7'b0000000,
            4'b0011
        );

        // XOR
        check_alu_control(
            7'b0110011,
            3'b100,
            7'b0000000,
            4'b0100
        );

        // SLT
        check_alu_control(
            7'b0110011,
            3'b010,
            7'b0000000,
            4'b0101
        );

        // ====================================
        // I-TYPE
        // ====================================

        // ADDI
        check_alu_control(
            7'b0010011,
            3'b000,
            7'b0000000,
            4'b0000
        );

        // ANDI
        check_alu_control(
            7'b0010011,
            3'b111,
            7'b0000000,
            4'b0010
        );

        // ORI
        check_alu_control(
            7'b0010011,
            3'b110,
            7'b0000000,
            4'b0011
        );

        // ====================================
        // MEMORY
        // ====================================

        // LW -> ADD
        check_alu_control(
            7'b0000011,
            3'b010,
            7'b0000000,
            4'b0000
        );

        // SW -> ADD
        check_alu_control(
            7'b0100011,
            3'b010,
            7'b0000000,
            4'b0000
        );

        // ====================================
        // BRANCH
        // ====================================

        // BEQ/BNE -> SUB
        check_alu_control(
            7'b1100011,
            3'b000,
            7'b0000000,
            4'b0001
        );

        // ====================================
        // INVALID
        // ====================================

        check_alu_control(
            7'b1111111,
            3'b000,
            7'b0000000,
            4'b0000
        );

        $display("");
        $display("========================================");
        $display("PASS = %0d", pass_count);
        $display("FAIL = %0d", fail_count);
        $display("========================================");

        if (fail_count == 0)
            $display("ALU CONTROL VERIFICATION: PASS");
        else
            $display("ALU CONTROL VERIFICATION: FAIL");

        $display("========================================");

        $finish;

    end

endmodule