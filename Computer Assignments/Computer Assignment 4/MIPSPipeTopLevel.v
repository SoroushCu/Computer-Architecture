`timescale 1ns/1ns
module MIPSPipeTopLevel(clk,rst,inst_adr,inst,data_adr,data_out,data_in,mem_write_to_data_mem,mem_read_to_data_mem);
    input clk, rst;
    input [31:0] inst,data_in;
    output [31:0] data_adr,data_out,inst_adr; 
    output mem_write_to_data_mem, mem_read_to_data_mem;
    wire alu_src,flush,reg_write,mem_read, mem_write,IFID_Ld,pc_load,Sel,operands_equal,zero_out,IDEX_mem_read,EXMEM_reg_write,MEMWB_reg_write;
    wire [1:0] reg_dst,mem_to_reg,pc_src,FWDA, FWDB;
    wire [2:0] alu_ctrl; 
    wire [5:0] IFIDopcode_out, IFIDfunc_out; 
    wire [4:0] IDEX_Rt, IFID_Rt, IFID_Rs, IDEX_Rs,EXMEM_Rd,MEMWB_Rd;
    Datapath DP(clk,rst,inst_adr,inst,data_adr,data_out,data_in,reg_dst,mem_to_reg,alu_src,pc_src,alu_ctrl,reg_write,
flush,mem_read,mem_write,FWDA,FWDB,mem_write_to_data_mem,mem_read_to_data_mem,pc_load,IFID_Ld,Sel,
IFIDopcode_out,IFIDfunc_out,zero_out,operands_equal,IDEX_mem_read,IDEX_Rt,IFID_Rt,IFID_Rs,IDEX_Rs,EXMEM_reg_write,EXMEM_Rd,MEMWB_reg_write,MEMWB_Rd);
    Controller CU(IFIDopcode_out,IFIDfunc_out,zero_out,reg_dst,mem_to_reg,reg_write,alu_src,mem_read,mem_write,pc_src,alu_ctrl,flush,operands_equal);
    
    HZD_Detection_Unit HDU(IDEX_mem_read, IDEX_Rt, IFID_Rs, IFID_Rt, Sel, IFID_Ld, pc_load);
    
    FWD_Unit FU(IDEX_Rs, IDEX_Rt, EXMEM_reg_write, EXMEM_Rd, MEMWB_reg_write, MEMWB_Rd, FWDA, FWDB);
endmodule

