`timescale 1ns/1ns
module ALUOut(input clk, rst,LoadALU, input [31:0] dataIn, output reg [31:0] AluOut);
  always@(posedge clk, posedge rst) begin
    if(rst)
      AluOut <= 32'b0;
    else if(clk & LoadALU)
      AluOut <= dataIn;
  end
endmodule
