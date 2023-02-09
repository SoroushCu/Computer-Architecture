`timescale 1ns/1ns
module ID_EX_CTRL(clk, rst, ALUOPIN,
 alu_src_in, reg_write_in, reg_dst_in,
 mem_read_in, mem_write_in, mem_to_reg_in, ALUOP,
 alu_src, reg_write, reg_dst, mem_read, mem_write, mem_to_reg);
    input clk, rst,reg_write_in,alu_src_in,mem_read_in, mem_write_in;
    input [1:0] reg_dst_in;
    input [2:0] ALUOPIN;
    input [1:0] mem_to_reg_in;
    output reg alu_src,mem_read, mem_write,reg_write;
    output reg [1:0] reg_dst,mem_to_reg;
    output reg [2:0] ALUOP;
    always @(posedge clk)
    begin
        if (rst)
            {ALUOP, alu_src, reg_write, reg_dst, mem_read, mem_write, mem_to_reg} <= {3'b000, 1'b0, 1'b0, 2'b00, 1'b0, 1'b0, 2'b00};
        else
            {ALUOP, alu_src, reg_write, reg_dst, mem_read, mem_write, mem_to_reg} <= {ALUOPIN, alu_src_in, reg_write_in, reg_dst_in, mem_read_in, mem_write_in, mem_to_reg_in};
    end 
endmodule