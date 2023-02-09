`timescale 1ns/1ns
module MDR(input clk, rst, input [31:0] dataIn, output reg [31:0] MDRout);
  always@(posedge clk, posedge rst) begin
    if(rst)
      MDRout <= 32'b0;
    else if(clk)
      MDRout <= dataIn;
  end
endmodule

