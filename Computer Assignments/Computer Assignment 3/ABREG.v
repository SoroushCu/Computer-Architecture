`timescale 1ns/1ns
module ABREG(input clk, rst,input[31:0] inreg, output reg[31:0] outreg);
  always@(posedge clk, posedge rst)begin
    if(rst) outreg <= 32'b0;
    else outreg <= inreg;
  end
endmodule
