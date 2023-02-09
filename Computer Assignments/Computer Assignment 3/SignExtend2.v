`timescale 1ns/1ns
module SignExtend2(input [25:0] Datain,output[31:0] Dataout);
  assign Dataout = {{6{Datain[11]}}, Datain};
endmodule
