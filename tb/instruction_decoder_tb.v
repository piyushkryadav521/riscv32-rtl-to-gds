`timescale 1ns/1ps

module instruction_decoder_tb;
    reg [31:0] instruction;
    
    wire [6:0] opcode;
    wire [4:0] rd;
    wire [2:0] funct3;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [6:0] funct7;

    instruction_decoder uut(
        .instruction(instruction),
        .opcode(opcode),
        .rd(rd),
        .funct3(funct3),
        .rs1(rs1),
        .rs2(rs2),
        .funct7(funct7)
    );

    initial begin

        $dumpfile("sim/instruction_decoder.vcd");
        $dumpvars(0, instruction_decoder_tb);
        instruction = 32'b0100000_01010_01001_000_01000_0110011;

        #10;
        
        $display("Instruction Decoder Test");
        $display("Instruction = %b", instruction);
        $display("opcode      = %b", opcode);
        $display("rd          = %d", rd);
        $display("funct3      = %b", funct3);
        $display("rs1         = %d", rs1);
        $display("rs2         = %d", rs2);
        $display("funct7      = %b", funct7);

        $finish;
    end
endmodule 