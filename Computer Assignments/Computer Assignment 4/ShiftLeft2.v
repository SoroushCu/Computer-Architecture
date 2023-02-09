`timescale 1ns/1ns
module ShiftLeft2#(parameter n=10) (input [n-1:0] Datain,output [n-1:0] Dataout);
  assign Dataout = Datain << 2;  
endmodule

