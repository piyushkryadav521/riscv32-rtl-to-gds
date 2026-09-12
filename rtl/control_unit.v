`timescale 1ns/1ps

module control_unit (
    input  wire [6:0] opcode,

    output reg        reg_write,
    output reg        mem_read,
    output reg        mem_write,
    output reg        alu_src,
    output reg        mem_to_reg,
    output reg        branch,
    output reg        jump
);

    always @(*) begin

        // Default control signals
        reg_write = 1'b0;
        mem_read  = 1'b0;
        mem_write = 1'b0;
        alu_src   = 1'b0;
        mem_to_reg = 1'b0;
        branch    = 1'b0;
        jump      = 1'b0;

        case (opcode)

            // R-Type: ADD, SUB, AND, OR, XOR, SLT
            7'b0110011: begin
                reg_write = 1'b1;
                alu_src   = 1'b0;
                mem_to_reg = 1'b0;
            end

            // I-Type ALU: ADDI, ANDI, ORI
            7'b0010011: begin
                reg_write = 1'b1;
                alu_src   = 1'b1;
                mem_to_reg = 1'b0;
            end

            // LW
            7'b0000011: begin
                reg_write = 1'b1;
                mem_read  = 1'b1;
                alu_src   = 1'b1;
                mem_to_reg = 1'b1;
            end

            // SW
            7'b0100011: begin
                mem_write = 1'b1;
                alu_src   = 1'b1;
            end

            // Branch: BEQ, BNE
            7'b1100011: begin
                branch = 1'b1;
                alu_src = 1'b0;
            end

            // JAL
            7'b1101111: begin
                reg_write = 1'b1;
                jump      = 1'b1;
            end

            // LUI
            7'b0110111: begin
                reg_write = 1'b1;
                alu_src   = 1'b1;
            end

            // AUIPC
            7'b0010111: begin
                reg_write = 1'b1;
                alu_src   = 1'b1;
            end

            // Unsupported instruction
            default: begin
                reg_write = 1'b0;
                mem_read  = 1'b0;
                mem_write = 1'b0;
                alu_src   = 1'b0;
                mem_to_reg = 1'b0;
                branch    = 1'b0;
                jump      = 1'b0;
            end

        endcase

    end

endmodule