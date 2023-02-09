`timescale 1ns/1ns
module SignExtend (input [15:0] Datain,output[31:0] Dataout);
  assign Dataout = {{16{Datain[15]}}, Datain};
endmodule

