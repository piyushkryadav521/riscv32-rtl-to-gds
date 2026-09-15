`timescale 1ns/1ps

module riscv_cpu (
    input  wire        clk,
    input  wire        reset,

    output wire [31:0] pc,
    output wire [31:0] instruction
);

    // ============================================
    // CPU Datapath Signals
    // ============================================

    reg [31:0] next_pc;

    // Instruction Decoder
    wire [6:0] opcode;
    wire [4:0] rd;
    wire [2:0] funct3;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [6:0] funct7;

    // Register File
    wire [31:0] read_data1;
    wire [31:0] read_data2;

    // Immediate Generator
    wire [31:0] immediate;

    // Control Unit
    wire reg_write;
    wire mem_read;
    wire mem_write;
    wire alu_src;
    wire mem_to_reg;
    wire branch;
    wire jump;

    // ALU Control
    wire [3:0] alu_control_signal;

    // ALU
    wire [31:0] alu_input_b;
    wire [31:0] alu_result;
    wire        alu_zero;

    // Data Memory
    wire [31:0] memory_read_data;

    // Write Back
    wire [31:0] write_back_data;

    // Branch
    wire branch_taken;

        // ============================================
    // Program Counter
    // ============================================

    program_counter pc_unit (
        .clk     (clk),
        .reset   (reset),
        .next_pc (next_pc),
        .pc      (pc)
    );

        // ============================================
    // Instruction Memory
    // ============================================

    instruction_memory imem (
        .address     (pc),
        .instruction (instruction)
    );

        // ============================================
    // Instruction Decoder
    // ============================================

    instruction_decoder decoder (
        .instruction (instruction),
        .opcode      (opcode),
        .rd          (rd),
        .funct3      (funct3),
        .rs1         (rs1),
        .rs2         (rs2),
        .funct7      (funct7)
    );

        // ============================================
    // Register File
    // ============================================

    register_file registers (
        .clk        (clk),
        .reset      (reset),
        .rs1        (rs1),
        .rs2        (rs2),
        .rd         (rd),
        .write_data (write_back_data),
        .reg_write  (reg_write),
        .read_data1 (read_data1),
        .read_data2 (read_data2)
    );

        // ============================================
    // Immediate Generator
    // ============================================

    immediate_generator imm_gen (
        .instruction (instruction),
        .immediate   (immediate)
    );

        // ============================================
    // Control Unit
    // ============================================

    control_unit control (
        .opcode     (opcode),
        .reg_write  (reg_write),
        .mem_read   (mem_read),
        .mem_write  (mem_write),
        .alu_src    (alu_src),
        .mem_to_reg (mem_to_reg),
        .branch     (branch),
        .jump       (jump)
    );

        // ============================================
    // ALU Control
    // ============================================

    alu_control alu_ctrl (
        .opcode      (opcode),
        .funct3      (funct3),
        .funct7      (funct7),
        .alu_control (alu_control_signal)
    );

        // ============================================
    // ALU Operand Selection
    // ============================================

    assign alu_input_b = alu_src ? immediate : read_data2;

        // ============================================
    // ALU
    // ============================================

    alu alu_unit (
        .a           (read_data1),
        .b           (alu_input_b),
        .alu_control (alu_control_signal),
        .result      (alu_result),
        .zero        (alu_zero)
    );


        // ============================================
    // Data Memory
    // ============================================

    data_memory dmem (
        .clk        (clk),
        .mem_read   (mem_read),
        .mem_write  (mem_write),
        .address    (alu_result),
        .write_data (read_data2),
        .read_data  (memory_read_data)
    );

        // ============================================
    // Write-Back Selection
    // ============================================

    wire [31:0] pc_plus4;

    assign pc_plus4 = pc + 32'd4;

    assign write_back_data = jump ?
                         pc_plus4 :
                         (opcode == 7'b0110111) ?
                         immediate :
                         (opcode == 7'b0010111) ?
                         (pc + immediate) :
                         (mem_to_reg ?
                          memory_read_data :
                          alu_result);

        // ============================================
    // Branch Unit
    // ============================================

    branch_unit branch_logic (
        .rs1_data     (read_data1),
        .rs2_data     (read_data2),
        .funct3       (funct3),
        .branch       (branch),
        .branch_taken (branch_taken)
    );

        // ============================================
    // Branch Target
    // ============================================

    wire [31:0] branch_target;

    assign branch_target = pc + immediate;

        // ============================================
    // Jump Target
    // ============================================

    wire [31:0] jump_target;

    assign jump_target = pc + immediate;

        // ============================================
    // Next PC Logic
    // ============================================

    always @(*) begin

        if (jump)
            next_pc = jump_target;

        else if (branch && branch_taken)
            next_pc = branch_target;

        else
            next_pc = pc + 32'd4;

    end

    

endmodule