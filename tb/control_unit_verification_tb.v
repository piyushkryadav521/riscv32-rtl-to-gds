`timescale 1ns/1ps

module control_unit_verification_tb;

    reg [6:0] opcode;

    wire reg_write;
    wire mem_read;
    wire mem_write;
    wire alu_src;
    wire mem_to_reg;
    wire branch;
    wire jump;

    integer pass_count;
    integer fail_count;

    control_unit dut (
        .opcode     (opcode),
        .reg_write  (reg_write),
        .mem_read   (mem_read),
        .mem_write  (mem_write),
        .alu_src    (alu_src),
        .mem_to_reg (mem_to_reg),
        .branch     (branch),
        .jump       (jump)
    );

    task check_control;
        input [6:0] test_opcode;
        input expected_reg_write;
        input expected_mem_read;
        input expected_mem_write;
        input expected_alu_src;
        input expected_mem_to_reg;
        input expected_branch;
        input expected_jump;

        begin

            opcode = test_opcode;
            #10;

            if ((reg_write  == expected_reg_write)  &&
                (mem_read   == expected_mem_read)   &&
                (mem_write  == expected_mem_write)  &&
                (alu_src    == expected_alu_src)    &&
                (mem_to_reg == expected_mem_to_reg)  &&
                (branch     == expected_branch)      &&
                (jump       == expected_jump)) begin

                $display("Opcode %b : PASS", test_opcode);
                pass_count = pass_count + 1;

            end
            else begin

                $display("Opcode %b : FAIL", test_opcode);

                $display("  Got:      RW=%b MR=%b MW=%b AS=%b MTR=%b BR=%b JP=%b",
                         reg_write, mem_read, mem_write,
                         alu_src, mem_to_reg, branch, jump);

                $display("  Expected: RW=%b MR=%b MW=%b AS=%b MTR=%b BR=%b JP=%b",
                         expected_reg_write, expected_mem_read,
                         expected_mem_write, expected_alu_src,
                         expected_mem_to_reg, expected_branch,
                         expected_jump);

                fail_count = fail_count + 1;

            end

        end
    endtask

    initial begin

        $dumpfile("sim/control_unit_day24.vcd");
        $dumpvars(0, control_unit_verification_tb);

        pass_count = 0;
        fail_count = 0;

        $display("");
        $display("========================================");
        $display("CONTROL UNIT VERIFICATION");
        $display("========================================");

        // R-Type
        check_control(
            7'b0110011,
            1'b1, 1'b0, 1'b0,
            1'b0, 1'b0, 1'b0, 1'b0
        );

        // I-Type ALU
        check_control(
            7'b0010011,
            1'b1, 1'b0, 1'b0,
            1'b1, 1'b0, 1'b0, 1'b0
        );

        // LW
        check_control(
            7'b0000011,
            1'b1, 1'b1, 1'b0,
            1'b1, 1'b1, 1'b0, 1'b0
        );

        // SW
        check_control(
            7'b0100011,
            1'b0, 1'b0, 1'b1,
            1'b1, 1'b0, 1'b0, 1'b0
        );

        // BEQ/BNE
        check_control(
            7'b1100011,
            1'b0, 1'b0, 1'b0,
            1'b0, 1'b0, 1'b1, 1'b0
        );

        // JAL
        check_control(
            7'b1101111,
            1'b1, 1'b0, 1'b0,
            1'b0, 1'b0, 1'b0, 1'b1
        );

        // LUI
        check_control(
            7'b0110111,
            1'b1, 1'b0, 1'b0,
            1'b1, 1'b0, 1'b0, 1'b0
        );

        // AUIPC
        check_control(
            7'b0010111,
            1'b1, 1'b0, 1'b0,
            1'b1, 1'b0, 1'b0, 1'b0
        );

        // INVALID
        check_control(
            7'b1111111,
            1'b0, 1'b0, 1'b0,
            1'b0, 1'b0, 1'b0, 1'b0
        );

        $display("");
        $display("========================================");
        $display("PASS = %0d", pass_count);
        $display("FAIL = %0d", fail_count);
        $display("========================================");

        if (fail_count == 0)
            $display("CONTROL UNIT VERIFICATION: PASS");
        else
            $display("CONTROL UNIT VERIFICATION: FAIL");

        $display("========================================");

        $finish;

    end

endmodule