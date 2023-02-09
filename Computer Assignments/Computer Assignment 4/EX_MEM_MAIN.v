`timescale 1ns/1ns
module EX_MEM_MAIN(clk, rst, ADD1, zero, alu_result, mux3_out, mux5_out, ADD1_OUT, zero_out, alu_result_out, mux3_out_out, mux5_out_out);
    input clk, rst,zero;
    input [31:0] ADD1,alu_result, mux3_out;
    input [4:0] mux5_out;    
    output reg [31:0] ADD1_OUT;
    output reg zero_out;
    output reg [31:0] alu_result_out, mux3_out_out;
    output reg [4:0] mux5_out_out;   
    always @(posedge clk) begin
        if (rst)
            {ADD1_OUT, zero_out, alu_result_out, mux3_out_out, mux5_out_out} <= {32'b0, 1'b0, 32'b0, 32'b0, 5'b0};
        else
            {ADD1_OUT, zero_out, alu_result_out, mux3_out_out, mux5_out_out} <= {ADD1, zero, alu_result, mux3_out, mux5_out};
    end
endmodule
