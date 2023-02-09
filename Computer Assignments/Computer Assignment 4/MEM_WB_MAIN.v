`timescale 1ns/1ns
module MEM_WB_MAIN(clk, rst, DFDMEM_IN,
 alu_result_in, mux5_out_in, ADD1_IN,
 DFMEM_OUT, alu_result_out, mux5_out_in_out, ADD1_OUT);
    input clk, rst;
    input [4:0] mux5_out_in;
    input [31:0] DFDMEM_IN,alu_result_in,ADD1_IN;
    output reg [4:0] mux5_out_in_out;
    output reg [31:0] DFMEM_OUT,ADD1_OUT,alu_result_out;
    always @(posedge clk) begin
        if (rst)
            {DFMEM_OUT, alu_result_out, mux5_out_in_out, ADD1_OUT} <= {32'b0, 32'b0, 5'b0, 32'b0};
        else
            {DFMEM_OUT, alu_result_out, mux5_out_in_out, ADD1_OUT} <= {DFDMEM_IN, alu_result_in, mux5_out_in, ADD1_IN};
    end
endmodule
