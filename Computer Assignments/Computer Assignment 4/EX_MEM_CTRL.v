`timescale 1ns/1ns
module EX_MEM_CTRL(clk,rst, mem_write_in, mem_read_in, mem_to_reg_in,
reg_write_in, mem_write,mem_read,
 mem_to_reg, reg_write);
    input clk, rst,mem_read_in, mem_write_in,reg_write_in;
    input [1:0] mem_to_reg_in;
    output reg reg_write,mem_read, mem_write;
    output reg [1:0] mem_to_reg;
    always @(posedge clk) begin
        if (rst)
            {mem_write, mem_read, mem_to_reg, reg_write} <= {1'b0, 1'b0, 2'b00, 1'b0};
        else
            {mem_write, mem_read, mem_to_reg, reg_write} <= {mem_write_in, mem_read_in, mem_to_reg_in, reg_write_in};
    end
endmodule
