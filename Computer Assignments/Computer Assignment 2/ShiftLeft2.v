`timescale 1ns/1ns
module ShiftLeft2 (input [31:0] Datain,output [31:0] Dataout);
  assign Dataout = Datain << 2;  
endmodule

