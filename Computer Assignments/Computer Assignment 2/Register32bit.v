`timescale 1ns/1ns
module Register32bit (input [31:0]Datain, input syncclr, ld, clk,output reg [31:0] Dataout);
  always @(posedge clk)
  begin
    if (syncclr==1'b1)
      Dataout = 32'd0;
    else if (ld)
      Dataout = Datain;
  end
endmodule
