`timescale 1ns/1ns
module Checker(input Z,N,C,V, input[1:0] CIR, output Cond);
	assign Cond = (CIR == 2'b00)? Z:
                      (CIR == 2'b01)? (~Z)&(~(N^V)):
		      (CIR == 2'b10)? (N^V):
                      (CIR == 2'b11)? 1'b1:1'b0;
endmodule
