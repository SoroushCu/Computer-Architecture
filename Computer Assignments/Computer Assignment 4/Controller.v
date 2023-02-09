module Controller (opcode, func, zero, reg_dst, mem_to_reg,reg_write,
alu_src,mem_read, mem_write,pc_src,operation,IFflush, operands_equal);
    input [5:0] opcode;
    input [5:0] func;
    input zero;
    output reg reg_write, alu_src, mem_read, mem_write;
    output reg [1:0] pc_src;
    output reg [1:0] mem_to_reg;
    output [2:0] operation;
    output reg IFflush;
    input operands_equal;
    output reg [1:0] reg_dst;
    reg [1:0] ALUOP;
    reg branch;
    ALU_Controller ALU_CTRL(ALUOP, func, operation);
    always @(opcode)
    begin
        {reg_dst, mem_to_reg, reg_write, alu_src, mem_read, mem_write, pc_src, ALUOP, IFflush} = {2'b00, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 2'b00, 2'b00, 1'b0};
        case (opcode)
            // RType
            6'b000000 : {reg_dst, reg_write, ALUOP} = {2'b01, 1'b1, 2'b10};

            // LW
            6'b000011  : {alu_src, mem_to_reg, reg_write, mem_read} = {1'b1, 2'b01, 1'b1, 1'b1};
            
            // SW
            6'b000100  : {alu_src, mem_write} = 2'b11;

            // Beq
            6'b000101  : {pc_src, IFflush} = {1'b0, operands_equal, operands_equal};
            
            // Addi
            6'b000001: {reg_write, alu_src} = 2'b11;
            
            // SLTI
            6'b000010: {alu_src, reg_dst, reg_write, ALUOP, mem_to_reg} = {1'b1, 2'b00, 1'b1, 2'b11, 2'b00}; 
            
            // J
            6'b000110: {pc_src, IFflush} = {2'b10, 1'b1};
            
            // JAL
             6'b001000: {reg_dst, mem_to_reg, pc_src} = {2'b10, 2'b10, 2'b10};
            
            // JR
             6'b000111: {pc_src} = {2'b11};
            
            //NOP (No Operation) 
            //Nothing must happen.
        endcase
    end 
endmodule

