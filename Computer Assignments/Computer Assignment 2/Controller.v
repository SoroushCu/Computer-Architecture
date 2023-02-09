module Controller ( OPC, Function, zero, reg_dst, mem_to_reg, reg_write,alu_src, mem_read, mem_write, pc_src, OP, JMP, JR, JAL );
    input [5:0] OPC;
    input [5:0] Function;
    input zero;
    output  mem_to_reg,reg_dst, reg_write, alu_src, 
            mem_read, mem_write, pc_src, JMP, JR, JAL;
    reg     reg_dst, mem_to_reg, reg_write, 
            alu_src, mem_read, mem_write, JMP, JR, JAL; 
    output [2:0] OP;
    reg [1:0] ALUOP;     
    reg branch;   
    ALU_Controller ALU_CTRL(ALUOP, Function, OP);
    always @(OPC)
    begin
      {reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, ALUOP, JMP, JR, JAL} = 12'd0;
      case (OPC)
        // Here we add RType instructions
        6'b000000 : {reg_dst, reg_write, ALUOP} = 4'b1110;   
        // Here we add lw          
        6'b000011 : {alu_src, mem_to_reg, reg_write, mem_read} = 4'b1111; 
        // Here we add sw
        6'b000100 : {alu_src, mem_write} = 2'b11;                                 
        // Here we add beq
        6'b000101 : {branch, ALUOP} = 3'b101; 
        // Here we add addi
        6'b000001: {reg_write, alu_src} = 2'b11;
        // Here we add slti
        6'b000010: {reg_write, alu_src, ALUOP} = 4'b1111;   
        // Here we add jump
        6'b000110: {JMP} = 1'b1;   
        // Here we add jr (Jump register)
        6'b000111: {JR} = 1'b1;     
        // Here we add jal (Jump and link)
        6'b001000: {JAL, JMP} = 2'b11;               
      endcase
    end
    assign pc_src = branch & zero;
endmodule