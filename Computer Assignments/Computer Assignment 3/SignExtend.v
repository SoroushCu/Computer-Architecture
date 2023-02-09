`timescale 1ns/1ns
module SignExtend(input [11:0] Datain,output[31:0] Dataout);
  assign Dataout = {{20{Datain[11]}}, Datain};
endmodule

