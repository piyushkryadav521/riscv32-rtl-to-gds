`timescale 1ns/1ps

module branch_unit_tb;

    reg [31:0] rs1_data;
    reg [31:0] rs2_data;

    reg [2:0] funct3;
    reg       branch;

    wire branch_taken;

    branch_unit uut (
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .funct3(funct3),
        .branch(branch),
        .branch_taken(branch_taken)
    );

    initial begin

        $dumpfile("sim/branch_unit.vcd");
        $dumpvars(0, branch_unit_tb);

        $display("===== BRANCH UNIT TEST =====");

        // -----------------------------------------
        // Test 1: BEQ - Equal
        // 25 == 25 -> Branch Taken
        // -----------------------------------------
        rs1_data = 32'd25;
        rs2_data = 32'd25;
        funct3 = 3'b000;
        branch = 1'b1;

        #10;

        $display("BEQ Equal    : rs1=%d rs2=%d BranchTaken=%b",
                 rs1_data, rs2_data, branch_taken);


        // -----------------------------------------
        // Test 2: BEQ - Not Equal
        // 25 != 15 -> Branch Not Taken
        // -----------------------------------------
        rs1_data = 32'd25;
        rs2_data = 32'd15;
        funct3 = 3'b000;
        branch = 1'b1;

        #10;

        $display("BEQ Not Equal: rs1=%d rs2=%d BranchTaken=%b",
                 rs1_data, rs2_data, branch_taken);


        // -----------------------------------------
        // Test 3: BNE - Not Equal
        // 25 != 15 -> Branch Taken
        // -----------------------------------------
        rs1_data = 32'd25;
        rs2_data = 32'd15;
        funct3 = 3'b001;
        branch = 1'b1;

        #10;

        $display("BNE Not Equal: rs1=%d rs2=%d BranchTaken=%b",
                 rs1_data, rs2_data, branch_taken);


        // -----------------------------------------
        // Test 4: BNE - Equal
        // 25 == 25 -> Branch Not Taken
        // -----------------------------------------
        rs1_data = 32'd25;
        rs2_data = 32'd25;
        funct3 = 3'b001;
        branch = 1'b1;

        #10;

        $display("BNE Equal    : rs1=%d rs2=%d BranchTaken=%b",
                 rs1_data, rs2_data, branch_taken);


        // -----------------------------------------
        // Test 5: Branch disabled
        // Even if values are equal,
        // branch should NOT be taken.
        // -----------------------------------------
        rs1_data = 32'd25;
        rs2_data = 32'd25;
        funct3 = 3'b000;
        branch = 1'b0;

        #10;

        $display("Branch Off   : rs1=%d rs2=%d BranchTaken=%b",
                 rs1_data, rs2_data, branch_taken);


        // -----------------------------------------
        // Test 6: Unsupported funct3
        // -----------------------------------------
        rs1_data = 32'd25;
        rs2_data = 32'd15;
        funct3 = 3'b010;
        branch = 1'b1;

        #10;

        $display("Invalid funct3: rs1=%d rs2=%d BranchTaken=%b",
                 rs1_data, rs2_data, branch_taken);


        $display("================================");
        $display("BRANCH UNIT TEST COMPLETE");
        $display("================================");

        $finish;

    end

endmodule