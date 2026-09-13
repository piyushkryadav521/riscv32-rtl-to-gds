`timescale 1ns/1ps

module instruction_memory_tb;

    reg  [31:0] address;
    wire [31:0] instruction;

    instruction_memory uut (
        .address(address),
        .instruction(instruction)
    );

    initial begin

        $dumpfile("sim/instruction_memory.vcd");
        $dumpvars(0, instruction_memory_tb);

        $display("===== INSTRUCTION MEMORY TEST =====");

        address = 32'd0;
        #10;
        $display("PC = %d, Instruction = %b", address, instruction);

        address = 32'd4;
        #10;
        $display("PC = %d, Instruction = %b", address, instruction);

        address = 32'd8;
        #10;
        $display("PC = %d, Instruction = %b", address, instruction);

        address = 32'd12;
        #10;
        $display("PC = %d, Instruction = %b", address, instruction);

        address = 32'd16;
        #10;
        $display("PC = %d, Instruction = %b", address, instruction);

        $finish;

    end

endmodule