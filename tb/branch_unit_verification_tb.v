`timescale 1ns/1ps

module branch_unit_verification_tb;

    reg [31:0] rs1_data;
    reg [31:0] rs2_data;
    reg [2:0]  funct3;
    reg        branch;

    wire branch_taken;

    integer pass_count;
    integer fail_count;

    branch_unit dut (
        .rs1_data     (rs1_data),
        .rs2_data     (rs2_data),
        .funct3       (funct3),
        .branch       (branch),
        .branch_taken (branch_taken)
    );

    task check_branch;
        input [31:0] test_rs1;
        input [31:0] test_rs2;
        input [2:0]  test_funct3;
        input        test_branch;
        input        expected;

        begin

            rs1_data = test_rs1;
            rs2_data = test_rs2;
            funct3 = test_funct3;
            branch = test_branch;

            #10;

            if (branch_taken == expected) begin
                $display(
                    "rs1=%0d rs2=%0d funct3=%b branch=%b : PASS",
                    test_rs1,
                    test_rs2,
                    test_funct3,
                    test_branch
                );

                pass_count = pass_count + 1;
            end
            else begin
                $display(
                    "rs1=%0d rs2=%0d funct3=%b branch=%b : FAIL - Got %b Expected %b",
                    test_rs1,
                    test_rs2,
                    test_funct3,
                    test_branch,
                    branch_taken,
                    expected
                );

                fail_count = fail_count + 1;
            end

        end
    endtask

    initial begin

        $dumpfile("sim/branch_unit_day24.vcd");
        $dumpvars(0, branch_unit_verification_tb);

        pass_count = 0;
        fail_count = 0;

        $display("");
        $display("========================================");
        $display("BRANCH UNIT VERIFICATION");
        $display("========================================");

        // ------------------------------------
        // BEQ taken
        // ------------------------------------
        check_branch(
            32'd10,
            32'd10,
            3'b000,
            1'b1,
            1'b1
        );

        // ------------------------------------
        // BEQ not taken
        // ------------------------------------
        check_branch(
            32'd10,
            32'd20,
            3'b000,
            1'b1,
            1'b0
        );

        // ------------------------------------
        // BNE taken
        // ------------------------------------
        check_branch(
            32'd10,
            32'd20,
            3'b001,
            1'b1,
            1'b1
        );

        // ------------------------------------
        // BNE not taken
        // ------------------------------------
        check_branch(
            32'd10,
            32'd10,
            3'b001,
            1'b1,
            1'b0
        );

        // ------------------------------------
        // Branch disabled
        // ------------------------------------
        check_branch(
            32'd10,
            32'd10,
            3'b000,
            1'b0,
            1'b0
        );

        // ------------------------------------
        // Unsupported funct3
        // ------------------------------------
        check_branch(
            32'd10,
            32'd10,
            3'b010,
            1'b1,
            1'b0
        );

        $display("");
        $display("========================================");
        $display("PASS = %0d", pass_count);
        $display("FAIL = %0d", fail_count);
        $display("========================================");

        if (fail_count == 0)
            $display("BRANCH UNIT VERIFICATION: PASS");
        else
            $display(" BRANCH UNIT VERIFICATION: FAIL");

        $display("========================================");

        $finish;

    end

endmodule