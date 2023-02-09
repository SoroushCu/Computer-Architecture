`timescale 1ns/1ns
module Datapath (clk, rst, inst_adr, inst,data_adr, data_out, data_in,reg_dst, mem_to_reg, alu_src, pc_src, alu_ctrl, reg_write,JMP, JR, JAL,zero);
  input  clk, rst;
  input  [31:0] data_in;
  input   mem_to_reg, reg_dst, alu_src, pc_src, reg_write, JMP, JR, JAL;
  input  [2:0] alu_ctrl;
  input  [31:0] inst;
  output [31:0] inst_adr;
  output [31:0] data_adr;
  output [31:0] data_out;
  output zero;
  wire [31:0] pc_out;
  wire [31:0] adder1_out;
  wire [31:0] read_data1, read_data2;
  wire [31:0] sgnextout;
  wire [31:0] mux2_out;
  wire [31:0] alu_out;
  wire [31:0] adder2_out;
  wire [31:0] shl2_out, shl2_out2;
  wire [31:0] mux3_out;
  wire [31:0] mux4_out, mux6_out, mux7_out, mux8_out;
  wire [4:0]  mux1_out, mux5_out;
  Register32bit PC(mux8_out, rst, 1'b1, clk, pc_out);
  RegisterFile  Regfile(mux4_out, inst[25:21], inst[20:16], mux1_out, reg_write, rst, clk, read_data1, read_data2);
  SignExtend Signextension(inst[15:0], sgnextout);
  ALU ArithmeticLogicUnit(read_data1, mux2_out, alu_ctrl, alu_out, zero);
  //The Adders
  Adder_32bit FirstAdd (pc_out , 32'd4, 1'b0, , adder1_out);
  Adder_32bit SecondAdd(adder1_out, shl2_out, 1'b0, , adder2_out);
//The Multiplexers
  MUX2to1 #(32) MUX32bit1(read_data2, sgnextout, alu_src, mux2_out);
  MUX2to1 #(32) MUX32bit2(adder1_out, adder2_out, pc_src, mux3_out);
  MUX2to1 #(32) MUX32bit3(alu_out, data_in, mem_to_reg, mux4_out);
  MUX2to1 #(32) MUX32bit4(mux4_out, adder1_out, JAL, mux6_out);
  MUX2to1 #(32) MUX32bit5(mux3_out, {adder1_out[31:28],shl2_out2[27:0]}, JMP, mux7_out);
  MUX2to1 #(32) MUX32bit6(mux7_out, read_data1, JR, mux8_out);
  MUX2to1 #(5)MUX5bit1(inst[20:16], inst[15:11], reg_dst, mux1_out);
  MUX2to1 #(5)MUX5bit2(mux1_out, 5'd31, JAL, mux5_out);
//The shift elements
  ShiftLeft2 FirstShiftLeftElement(sgnextout, shl2_out);
  ShiftLeft2 SecondShiftLeftElement({6'b0,inst[25:0]}, shl2_out2);
  assign inst_adr = pc_out;
  assign data_adr = alu_out;
  assign data_out = read_data2;
endmodule