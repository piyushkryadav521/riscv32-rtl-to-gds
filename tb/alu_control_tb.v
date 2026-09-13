`timescale 1ns/1ps

module alu_control_tb;

    reg  [6:0] opcode;
    reg  [2:0] funct3;
    reg  [6:0] funct7;

    wire [3:0] alu_control;

    alu_control uut (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .alu_control(alu_control)
    );

    initial begin

        $dumpfile("sim/alu_control.vcd");
        $dumpvars(0, alu_control_tb);

        $display("===== ALU CONTROL TEST =====");

        // ADD
        opcode = 7'b0110011;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        #10;
        $display("ADD : ALU Control = %b", alu_control);

        // SUB
        funct7 = 7'b0100000;
        #10;
        $display("SUB : ALU Control = %b", alu_control);

        // AND
        funct3 = 3'b111;
        funct7 = 7'b0000000;
        #10;
        $display("AND : ALU Control = %b", alu_control);

        // OR
        funct3 = 3'b110;
        #10;
        $display("OR  : ALU Control = %b", alu_control);

        // XOR
        funct3 = 3'b100;
        #10;
        $display("XOR : ALU Control = %b", alu_control);

        // SLT
        funct3 = 3'b010;
        #10;
        $display("SLT : ALU Control = %b", alu_control);

        // ADDI
        opcode = 7'b0010011;
        funct3 = 3'b000;
        #10;
        $display("ADDI: ALU Control = %b", alu_control);

        // LW
        opcode = 7'b0000011;
        #10;
        $display("LW  : ALU Control = %b", alu_control);

        // SW
        opcode = 7'b0100011;
        #10;
        $display("SW  : ALU Control = %b", alu_control);

        // BEQ/BNE
        opcode = 7'b1100011;
        #10;
        $display("BRANCH: ALU Control = %b", alu_control);

        $finish;

    end

endmodule