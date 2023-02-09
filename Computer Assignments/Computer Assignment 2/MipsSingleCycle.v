`timescale 1ns/1ns
module MipsSingleCycle (rst, clk, inst_adr, inst, data_adr, data_in, data_out, mem_read, mem_write);
  input rst, clk;
  input  [31:0] inst;
  input  [31:0] data_in;
  output [31:0] inst_adr;
  output [31:0] data_adr;
  output [31:0] data_out;
  output mem_read, mem_write;
  wire reg_dst, mem_to_reg, alu_src, pc_src, reg_write, zero, JMP, JR, JAL;
  wire [2:0] alu_ctrl;
  Datapath Dpath(clk, rst, inst_adr, inst, data_adr, data_out, data_in,reg_dst, mem_to_reg, alu_src, pc_src, alu_ctrl, reg_write, JMP, JR, JAL, zero); 
  Controller CUnit(inst[31:26], inst[5:0], zero, reg_dst, mem_to_reg, reg_write,alu_src, mem_read, mem_write, pc_src, alu_ctrl, JMP, JR, JAL);
endmodule
