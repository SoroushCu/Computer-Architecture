`timescale 1ns/1ns
module Datapath (clk, rst,inst, mem_out,RegDst, MemtoReg, PCSrc,
 alu_ctrl, reg_write,Cond,PCWrite,IorD,RmorRd,AluSrcA,AluSrcB,LoadALU,loadZN,loadCV,IRWrite,LT,LB,I,Bwrite,mux1_out,opcode);
  input  clk, rst;
  input[1:0]AluSrcA,AluSrcB;
  input loadZN,loadCV,IRWrite;
  input   MemtoReg, RegDst, PCSrc, reg_write,PCWrite,IorD,RmorRd,LoadALU;
  input  [2:0] alu_ctrl;
  input  [31:0] mem_out;
  output  [31:0] mux1_out,Bwrite;
  output  [2:0] inst,opcode;
  output  Cond,LT,LB,I;
  wire [1:0]ZNRegOut,CVRegOut;
  wire Z,N,C,V;
  wire [31:0] pc_out,IR,MDR_out,Aout,Bout;
  wire [31:0] read_data1, read_data2;
  wire [31:0] sgnextout11,sgnextout25;
  wire [31:0] alu_out,alu_raw;
  wire [3:0] mux2_out,mux3_out;
  wire [31:0] mux6_out, mux7_out,mux4_out, mux5_out;
  PC pc(clk, rst, PCWrite, mux7_out, pc_out);
  RegisterFile  Regfile(mux4_out, IR[19:16], mux2_out, mux3_out, reg_write, rst, clk, read_data1, read_data2);
  SignExtend Signextension1(IR[11:0], sgnextout11);
  SignExtend2 Signextension2(IR[25:0], sgnextout25);
  ALU ArithmeticLogicUnit(mux5_out, mux6_out, alu_ctrl, alu_raw,Z,N,C,V);
//The Multiplexers
  MUX2to1 #(32) MUX32bit1(pc_out, alu_out, IorD, mux1_out);
  MUX2to1 #(4) MUX4bit2(IR[15:12],IR[3:0], RmorRd, mux2_out);
  MUX2to1 #(4) MUX4bit3(IR[15:12], 4'b1111,RegDst, mux3_out);
  MUX2to1 #(32) MUX32bit4(MDR_out, alu_out, MemtoReg, mux4_out);
  MUX3to1 #(32) MUX32bit5(pc_out,Aout, 32'b0,AluSrcA ,mux5_out);
  MUX4to1 #(32) MUX32bit6(Bout, 32'b1,sgnextout11 , sgnextout25,AluSrcB,mux6_out);
  MUX2to1 #(32)MUX32bit7(alu_raw, alu_out,PCSrc, mux7_out);
  //The Registers
  ABREG regA(clk,rst,read_data1,Aout);
  ABREG regB(clk,rst,read_data2,Bout);
  ALUOut regaluout(clk,rst,LoadALU,alu_raw,alu_out);
  Flag2bitreg ZN(clk,rst,loadZN,{Z,N},ZNRegOut);
  Flag2bitreg CV(clk,rst,loadCV,{C,V},CVRegOut);
  IR IRReg(clk,rst,IRWrite,mem_out,IR);
  MDR MDRREG(clk,rst,mem_out,MDR_out);
  //The Checker
  Checker check(ZNRegOut[1],ZNRegOut[0],CVRegOut[1],CVRegOut[0],IR[31:30],Cond);
  assign LT=IR[20];
  assign LB=IR[26];
  assign I=IR[23];
  assign Bwrite=Bout;
  assign inst=IR[29:27];
  assign opcode=IR[22:20];
endmodule
