`timescale 1ns/1ps

module alu_control (
    input  wire [6:0] opcode,
    input  wire [2:0] funct3,
    input  wire [6:0] funct7,

    output reg [3:0] alu_control
);

    always @(*) begin

        // Default: ADD
        alu_control = 4'b0000;

        case (opcode)

            // R-Type
            7'b0110011: begin

                case (funct3)

                    // ADD / SUB
                    3'b000: begin
                        if (funct7 == 7'b0100000)
                            alu_control = 4'b0001; // SUB
                        else
                            alu_control = 4'b0000; // ADD
                    end

                    // AND
                    3'b111:
                        alu_control = 4'b0010;

                    // OR
                    3'b110:
                        alu_control = 4'b0011;

                    // XOR
                    3'b100:
                        alu_control = 4'b0100;

                    // SLT
                    3'b010:
                        alu_control = 4'b0101;

                    default:
                        alu_control = 4'b0000;

                endcase

            end

            // I-Type ALU
            7'b0010011: begin

                case (funct3)

                    // ADDI
                    3'b000:
                        alu_control = 4'b0000;

                    // ANDI
                    3'b111:
                        alu_control = 4'b0010;

                    // ORI
                    3'b110:
                        alu_control = 4'b0011;

                    default:
                        alu_control = 4'b0000;

                endcase

            end

            // LW
            7'b0000011:
                alu_control = 4'b0000;

            // SW
            7'b0100011:
                alu_control = 4'b0000;

            // BEQ / BNE
            7'b1100011:
                alu_control = 4'b0001;

            default:
                alu_control = 4'b0000;

        endcase

    end

endmodule