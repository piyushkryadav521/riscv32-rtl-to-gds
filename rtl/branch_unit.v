`timescale 1ns/1ps

module branch_unit (
    input  wire [31:0] rs1_data,
    input  wire [31:0] rs2_data,

    input  wire [2:0] funct3,
    input  wire       branch,

    output reg        branch_taken
);

    always @(*) begin

        // Default: branch not taken
        branch_taken = 1'b0;

        if (branch) begin

            case (funct3)

                // BEQ
                3'b000: begin
                    if (rs1_data == rs2_data)
                        branch_taken = 1'b1;
                end

                // BNE
                3'b001: begin
                    if (rs1_data != rs2_data)
                        branch_taken = 1'b1;
                end

                // Unsupported branch
                default: begin
                    branch_taken = 1'b0;
                end

            endcase

        end

    end

endmodule