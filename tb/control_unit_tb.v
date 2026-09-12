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

    initial begin

        $dumpfile("sim/control_unit.vcd");
        $dumpvars(0, control_unit_tb);

        $display("===== CONTROL UNIT TEST =====");

        // R-Type: ADD/SUB/AND/OR/XOR/SLT
        opcode = 7'b0110011;
        #10;
        $display("R-Type : RegWrite=%b MemRead=%b MemWrite=%b ALUSrc=%b MemToReg=%b Branch=%b Jump=%b",
                 reg_write, mem_read, mem_write, alu_src, mem_to_reg, branch, jump);

        // I-Type: ADDI/ANDI/ORI
        opcode = 7'b0010011;
        #10;
        $display("I-Type : RegWrite=%b MemRead=%b MemWrite=%b ALUSrc=%b MemToReg=%b Branch=%b Jump=%b",
                 reg_write, mem_read, mem_write, alu_src, mem_to_reg, branch, jump);

        // LW
        opcode = 7'b0000011;
        #10;
        $display("LW     : RegWrite=%b MemRead=%b MemWrite=%b ALUSrc=%b MemToReg=%b Branch=%b Jump=%b",
                 reg_write, mem_read, mem_write, alu_src, mem_to_reg, branch, jump);

        // SW
        opcode = 7'b0100011;
        #10;
        $display("SW     : RegWrite=%b MemRead=%b MemWrite=%b ALUSrc=%b MemToReg=%b Branch=%b Jump=%b",
                 reg_write, mem_read, mem_write, alu_src, mem_to_reg, branch, jump);

        // Branch: BEQ/BNE
        opcode = 7'b1100011;
        #10;
        $display("Branch : RegWrite=%b MemRead=%b MemWrite=%b ALUSrc=%b MemToReg=%b Branch=%b Jump=%b",
                 reg_write, mem_read, mem_write, alu_src, mem_to_reg, branch, jump);

        // JAL
        opcode = 7'b1101111;
        #10;
        $display("JAL    : RegWrite=%b MemRead=%b MemWrite=%b ALUSrc=%b MemToReg=%b Branch=%b Jump=%b",
                 reg_write, mem_read, mem_write, alu_src, mem_to_reg, branch, jump);

        // Unsupported opcode
        opcode = 7'b1111111;
        #10;
        $display("Invalid : RegWrite=%b MemRead=%b MemWrite=%b ALUSrc=%b MemToReg=%b Branch=%b Jump=%b",
                 reg_write, mem_read, mem_write, alu_src, mem_to_reg, branch, jump);

        $finish;

    end

endmodule