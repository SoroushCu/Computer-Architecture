`timescale 1ns/1ns
module MEM_WB_CTRL(clk,rst,mem_to_reg_in,reg_write_in,mem_to_reg_out,reg_write_out);
    input clk, rst,reg_write_in;
    input [1:0] mem_to_reg_in;
     output reg reg_write_out;
    output reg [1:0] mem_to_reg_out;
    always @(posedge clk) begin
        if (rst)
            {mem_to_reg_out, reg_write_out} <= {2'b00, 1'b0};
        else
            {mem_to_reg_out, reg_write_out} <= {mem_to_reg_in, reg_write_in};
    end
endmodule
