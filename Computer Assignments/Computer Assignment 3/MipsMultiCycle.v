`timescale 1ns/1ns
module MipsMultiCycle(clk,rst,mem_out,mux1_out,Bwrite,memRead,memWrite);
input clk,rst;
output[31:0]mem_out,mux1_out,Bwrite;
output memRead,memWrite;
wire clk, rst,RegDst, MemtoReg, PCSrc,
  reg_write,Cond,PCWrite,IorD,RmorRd,LoadALU,
loadZN,loadCV,IRWrite,L1,L2,I;
wire [1:0] AluSrcA,AluSrcB;
wire [2:0] alu_ctrl,inst,opcode;  
Datapath dp(clk,rst,inst,mem_out,RegDst, MemtoReg, PCSrc,
 alu_ctrl, reg_write,Cond,PCWrite,IorD,RmorRd,AluSrcA,AluSrcB,LoadALU,
loadZN,loadCV,IRWrite,LT,LB,I,Bwrite,mux1_out,opcode);

Controller cu(Cond,LT,LB,I,inst,opcode,MemtoReg, RegDst, PCSrc,
 reg_write,PCWrite,IorD,RmorRd,LoadALU,loadZN,loadCV,IRWrite,memRead,
memWrite,AluSrcA,AluSrcB,alu_ctrl,clk,rst);
endmodule