`timescale 1ns/1ns
module Datapath (clk,rst,inst_adr,inst,data_adr,data_out,data_in,reg_dst,
mem_to_reg,alu_src,pc_src,alu_ctrl,reg_write,flush,
mem_read,mem_write,FWDA,FWDB,mem_write_to_data_mem,
mem_read_to_data_mem,pc_load,IF_ID_Ld,SELSig,
IF_IDopcode_out,IF_IDfunc_out,zero_out,operands_equal,
IDEX_mem_read,IDEX_Rt,IF_ID_Rt,IF_ID_Rs,IDEX_Rs, EXMEM_reg_write,
 EXMEM_Rd, MEMWB_reg_write, MEMWB_Rd);    
    input  clk, rst,alu_src, reg_write,mem_read,mem_write,flush,pc_load,IF_ID_Ld,SELSig;
    input [1:0] mem_to_reg,pc_src,reg_dst,FWDA, FWDB;
    input  [2:0] alu_ctrl; 
    input  [31:0] inst,data_in;
    output zero_out,IDEX_mem_read,operands_equal,mem_read_to_data_mem, mem_write_to_data_mem,EXMEM_reg_write, MEMWB_reg_write;
    output [4:0] IDEX_Rt, IF_ID_Rt, IF_ID_Rs, IDEX_Rs;
    output [4:0] EXMEM_Rd, MEMWB_Rd;
    output [5:0] IF_IDopcode_out;
    output [5:0] IF_IDfunc_out;
    output [31:0] data_out,inst_adr,data_adr;
    wire cout1,cout2,MEMWB_reg_write_out,IDEX_reg_write_out,IDEX_mem_read_out,IDEX_mem_write_out,IDEX_alu_src_out,IDEX_alu_src_in;
    wire IDEX_reg_write_in,IDEX_mem_write_in,IDEX_mem_read_in,alu_zero,EXMEM_zero_out,EXMEM_mem_write_out, EXMEM_mem_read_out, EXMEM_reg_write_out; 
    wire [1:0] IDEX_reg_dst_out,IDEX_mem_to_reg_out,IDEX_reg_dst_in,IDEX_mem_to_reg_in,EXMEM_mem_to_reg_out,MEMWB_mem_to_reg_out;
    wire [2:0] IDEX_alu_ctrl_out,IDEX_alu_ctrl_in;
    wire [4:0] MEMWB_mux5_out,IDEX_Rt_out, IDEX_Rd_out, IDEX_Rs_out,mux5_out,EXMEM_mux5_out;
    wire [10:0] mux7_out;
    wire [25:0] shl2_26b_out;
    wire [31:0] mux1_out,pc_out,adder1_out,IF_IDinst_out, IF_IDadder1_out,adder2_out,read_data1,sgn_ext_out,shl2_32_out,mux6_out;
    wire [31:0] read_data2,IDEX_read1_out, IDEX_read2_out, IDEX_sgn_ext_out,IDEX_adder1_out,mux3_out, mux4_out,EXMEM_alu_result_out;
    wire [31:0] mux2_out,alu_result,EXMEM_adder1_out,EXMEM_mux3_out,MEMWB_data_from_memory_out,MEMWB_alu_result_out,MEMWB_adder1_out;
    Register32bit PC(mux1_out, rst, pc_load, clk, pc_out);
    Adder_32bit ADDER_1(pc_out , 32'd4, 1'b0, cout1 , adder1_out);
    IF_ID IF_IDReg(clk, rst, IF_ID_Ld, flush, inst, adder1_out, IF_IDinst_out, IF_IDadder1_out);
    MUX4to1 #(32) MUX1(adder1_out, adder2_out, {2'b00,IF_IDadder1_out[31:28], shl2_26b_out}, read_data1, pc_src, mux1_out);
    SignExtend SGN_EXT(IF_IDinst_out[15:0], sgn_ext_out);
    ShiftLeft2 #(32) SHL2_32(sgn_ext_out, shl2_32_out);
    Adder_32bit ADDER_2(shl2_32_out, IF_IDadder1_out, 1'b0, cout2, adder2_out);
    ShiftLeft2 #(26) SHL2_26(IF_IDinst_out[25:0], shl2_26b_out);
    RegisterFile RF(mux6_out, IF_IDinst_out[25:21], IF_IDinst_out[20:16], MEMWB_mux5_out, MEMWB_reg_write_out, rst, clk, read_data1, read_data2);
    ID_EX_MAIN IDEX_DATAS(clk, rst, read_data1, read_data2, sgn_ext_out, IF_IDinst_out[20:16], IF_IDinst_out[15:11], IF_IDinst_out[25:21], IF_IDadder1_out,IDEX_read1_out, IDEX_read2_out, IDEX_sgn_ext_out, IDEX_Rt_out, IDEX_Rd_out, IDEX_Rs_out, IDEX_adder1_out);
    MUX2to1 #(11) MUX7(11'b0, {alu_ctrl, alu_src, reg_write, reg_dst, mem_read, mem_write, mem_to_reg}, SELSig, mux7_out); 
    ID_EX_CTRL IDEX_CTRL(clk, rst, IDEX_alu_ctrl_in, IDEX_alu_src_in, IDEX_reg_write_in, IDEX_reg_dst_in, IDEX_mem_read_in, IDEX_mem_write_in, IDEX_mem_to_reg_in,IDEX_alu_ctrl_out, IDEX_alu_src_out, IDEX_reg_write_out, IDEX_reg_dst_out, IDEX_mem_read_out, IDEX_mem_write_out, IDEX_mem_to_reg_out);
    MUX3to1 #(5) MUX5(IDEX_Rt_out, IDEX_Rd_out, 5'b11111, IDEX_reg_dst_out, mux5_out);
    MUX2to1 #(32) MUX4(mux3_out, IDEX_sgn_ext_out, IDEX_alu_src_out, mux4_out);
    MUX3to1 #(32) MUX3(IDEX_read2_out, mux6_out, EXMEM_alu_result_out, FWDB, mux3_out);
    MUX3to1 #(32) MUX2(IDEX_read1_out, mux6_out, EXMEM_alu_result_out, FWDA, mux2_out);
    ALU ArithmeticLogicUnit(mux2_out, mux4_out, IDEX_alu_ctrl_out, alu_result, alu_zero);
    EX_MEM_MAIN EXMEM_DATAS(clk, rst, IDEX_adder1_out, alu_zero, alu_result, mux3_out, mux5_out,EXMEM_adder1_out, EXMEM_zero_out, EXMEM_alu_result_out, EXMEM_mux3_out, EXMEM_mux5_out);
    EX_MEM_CTRL EXMEM_CTRL(clk, rst, IDEX_mem_write_out, IDEX_mem_read_out, IDEX_mem_to_reg_out, IDEX_reg_write_out,EXMEM_mem_write_out, EXMEM_mem_read_out, EXMEM_mem_to_reg_out, EXMEM_reg_write_out); 
    MEM_WB_CTRL MEMWB_CTRL(clk, rst, EXMEM_mem_to_reg_out, EXMEM_reg_write_out, MEMWB_mem_to_reg_out, MEMWB_reg_write_out); 
    MEM_WB_MAIN MEMWB_DATAS(clk, rst, data_in, EXMEM_alu_result_out, EXMEM_mux5_out, EXMEM_adder1_out,MEMWB_data_from_memory_out, MEMWB_alu_result_out, MEMWB_mux5_out, MEMWB_adder1_out);
    MUX3to1 #(32) MUX6(MEMWB_alu_result_out, MEMWB_data_from_memory_out, MEMWB_adder1_out, MEMWB_mem_to_reg_out, mux6_out);
    assign MEMWB_Rd = MEMWB_mux5_out;
    assign data_adr = EXMEM_alu_result_out;
    assign data_out = EXMEM_mux3_out;  
    assign MEMWB_reg_write = MEMWB_reg_write_out;
    assign EXMEM_reg_write = EXMEM_reg_write_out;
    assign mem_write_to_data_mem = EXMEM_mem_write_out;
    assign mem_read_to_data_mem = EXMEM_mem_read_out; 
    assign EXMEM_Rd = EXMEM_mux5_out;
    assign zero_out = alu_zero;
    assign IDEX_mem_read = IDEX_mem_read_out;
    assign IDEX_Rt = IDEX_Rt_out;
    assign IDEX_Rs = IDEX_Rs_out;
    assign operands_equal = (read_data1 == read_data2);
    assign {IDEX_alu_ctrl_in, IDEX_alu_src_in, IDEX_reg_write_in, IDEX_reg_dst_in, IDEX_mem_read_in, IDEX_mem_write_in, IDEX_mem_to_reg_in} = mux7_out;
    assign inst_adr = pc_out;
    assign IF_IDopcode_out = IF_IDinst_out[31:26];
    assign IF_IDfunc_out = IF_IDinst_out[5:0];
    assign IF_ID_Rt = IF_IDinst_out[20:16];
    assign IF_ID_Rs = IF_IDinst_out[25:21];
    assign inst_adr = pc_out;
endmodule
