`timescale 1ns/1ps

module control_unit_tb;

    reg  [6:0] opcode;

    wire reg_write;
    wire mem_read;
    wire mem_write;
    wire alu_src;
    wire mem_to_reg;
    wire branch;
    wire jump;

    control_unit uut (
        .opcode(opcode),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .jump(jump)
    );

    task check_control;
        input expected_reg_write;
        input expected_mem_read;
        input expected_mem_write;
        input expected_alu_src;
        input expected_mem_to_reg;
        input expected_branch;
        input expected_jump;

        begin
            if ((reg_write  == expected_reg_write)  &&
                (mem_read   == expected_mem_read)   &&
                (mem_write  == expected_mem_write)  &&
                (alu_src    == expected_alu_src)    &&
                (mem_to_reg == expected_mem_to_reg) &&
                (branch     == expected_branch)    &&
                (jump       == expected_jump))
                $display("PASS");
            else
                $display("FAIL");
        end
    endtask

    initial begin

        $dumpfile("sim/control_unit.vcd");
        $dumpvars(0, control_unit_tb);

        $display("===== CONTROL UNIT DEEP VERIFICATION =====");

        // -----------------------------------------
        // R-Type
        // ADD, SUB, AND, OR, XOR, SLT
        // -----------------------------------------
        opcode = 7'b0110011;
        #10;

        $display("R-Type");
        $display("RegWrite=%b MemRead=%b MemWrite=%b ALUSrc=%b MemToReg=%b Branch=%b Jump=%b",
                 reg_write, mem_read, mem_write, alu_src,
                 mem_to_reg, branch, jump);

        check_control(1,0,0,0,0,0,0);


        // -----------------------------------------
        // I-Type ALU
        // ADDI, ANDI, ORI
        // -----------------------------------------
        opcode = 7'b0010011;
        #10;

        $display("I-Type ALU");
        $display("RegWrite=%b MemRead=%b MemWrite=%b ALUSrc=%b MemToReg=%b Branch=%b Jump=%b",
                 reg_write, mem_read, mem_write, alu_src,
                 mem_to_reg, branch, jump);

        check_control(1,0,0,1,0,0,0);


        // -----------------------------------------
        // LW
        // -----------------------------------------
        opcode = 7'b0000011;
        #10;

        $display("LW");
        $display("RegWrite=%b MemRead=%b MemWrite=%b ALUSrc=%b MemToReg=%b Branch=%b Jump=%b",
                 reg_write, mem_read, mem_write, alu_src,
                 mem_to_reg, branch, jump);

        check_control(1,1,0,1,1,0,0);


        // -----------------------------------------
        // SW
        // -----------------------------------------
        opcode = 7'b0100011;
        #10;

        $display("SW");
        $display("RegWrite=%b MemRead=%b MemWrite=%b ALUSrc=%b MemToReg=%b Branch=%b Jump=%b",
                 reg_write, mem_read, mem_write, alu_src,
                 mem_to_reg, branch, jump);

        check_control(0,0,1,1,0,0,0);


        // -----------------------------------------
        // BEQ
        // -----------------------------------------
        opcode = 7'b1100011;
        #10;

        $display("BEQ");
        $display("RegWrite=%b MemRead=%b MemWrite=%b ALUSrc=%b MemToReg=%b Branch=%b Jump=%b",
                 reg_write, mem_read, mem_write, alu_src,
                 mem_to_reg, branch, jump);

        check_control(0,0,0,0,0,1,0);


        // -----------------------------------------
        // BNE
        // Same opcode-level control as BEQ
        // -----------------------------------------
        opcode = 7'b1100011;
        #10;

        $display("BNE");
        $display("RegWrite=%b MemRead=%b MemWrite=%b ALUSrc=%b MemToReg=%b Branch=%b Jump=%b",
                 reg_write, mem_read, mem_write, alu_src,
                 mem_to_reg, branch, jump);

        check_control(0,0,0,0,0,1,0);


        // -----------------------------------------
        // JAL
        // -----------------------------------------
        opcode = 7'b1101111;
        #10;

        $display("JAL");
        $display("RegWrite=%b MemRead=%b MemWrite=%b ALUSrc=%b MemToReg=%b Branch=%b Jump=%b",
                 reg_write, mem_read, mem_write, alu_src,
                 mem_to_reg, branch, jump);

        check_control(1,0,0,0,0,0,1);


        // -----------------------------------------
        // LUI
        // -----------------------------------------
        opcode = 7'b0110111;
        #10;

        $display("LUI");
        $display("RegWrite=%b MemRead=%b MemWrite=%b ALUSrc=%b MemToReg=%b Branch=%b Jump=%b",
                 reg_write, mem_read, mem_write, alu_src,
                 mem_to_reg, branch, jump);

        check_control(1,0,0,1,0,0,0);


        // -----------------------------------------
        // AUIPC
        // -----------------------------------------
        opcode = 7'b0010111;
        #10;

        $display("AUIPC");
        $display("RegWrite=%b MemRead=%b MemWrite=%b ALUSrc=%b MemToReg=%b Branch=%b Jump=%b",
                 reg_write, mem_read, mem_write, alu_src,
                 mem_to_reg, branch, jump);

        check_control(1,0,0,1,0,0,0);


        // -----------------------------------------
        // Unsupported instruction
        // -----------------------------------------
        opcode = 7'b1111111;
        #10;

        $display("INVALID");
        $display("RegWrite=%b MemRead=%b MemWrite=%b ALUSrc=%b MemToReg=%b Branch=%b Jump=%b",
                 reg_write, mem_read, mem_write, alu_src,
                 mem_to_reg, branch, jump);

        check_control(0,0,0,0,0,0,0);


        $display("========================================");
        $display("CONTROL UNIT VERIFICATION COMPLETE");
        $display("========================================");

        $finish;

    end

endmodule