`timescale 1ns/1ns
module Flag2bitreg(input clk , rst , ld , input[1:0] inreg, output reg[1:0] outreg);
  always@(posedge clk, posedge rst)begin
    if(rst) outreg <= 2'b0;
    else if(ld) outreg <= inreg;
  end
endmodule