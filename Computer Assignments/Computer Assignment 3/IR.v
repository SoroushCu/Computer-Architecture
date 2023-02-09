`timescale 1ns/1ns
module IR(input clk, rst, input IRWrite, input [31:0] dataIn, output reg [31:0] IRout);
  always@(posedge clk, posedge rst) begin
    if(rst)
      IRout <= 32'b0;
    else
      if(IRWrite)
        IRout <= dataIn;
      else
        IRout <= IRout;
  end
endmodule

