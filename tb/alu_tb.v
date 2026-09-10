`timescale 1ns/1ps

module alu_tb;

    reg  [31:0] a;
    reg  [31:0] b;
    reg  [3:0]  alu_control;

    wire [31:0] result;
    wire        zero;

    // ALU
    alu uut (
        .a(a),
        .b(b),
        .alu_control(alu_control),
        .result(result),
        .zero(zero)
    );

    initial begin

        // VCD
        $dumpfile("sim/alu.vcd");
        $dumpvars(0, alu_tb);

        // ADD: 25 + 15 = 40
        a = 32'd25;
        b = 32'd15;
        alu_control = 4'b0000;

        #10;

        $display("===== ALU TEST =====");
        $display("ADD: %d + %d = %d", a, b, result);
        $display("Zero = %b", zero);

        // SUB: 25 - 15 = 10
        a = 32'd25;
        b = 32'd15;
        alu_control = 4'b0001;

        #10;

        $display("SUB: %d - %d = %d", a, b, result);

        // AND
        a = 32'h0F0F0F0F;
        b = 32'h00FF00FF;
        alu_control = 4'b0010;

        #10;

        $display("AND: %h", result);

        // OR
        alu_control = 4'b0011;

        #10;

        $display("OR : %h", result);

        // XOR
        alu_control = 4'b0100;

        #10;

        $display("XOR: %h", result);

        $finish;

    end

endmodule