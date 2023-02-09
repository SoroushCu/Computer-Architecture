`timescale 1ns/1ns
module ALU (A, B, ctrl, Out, Z,N,C,V);
  input [31:0] A, B;
  input [2:0] ctrl;
  output [31:0] Out;
  output Z,N,C,V;
  assign {C,Out} = (ctrl == 3'b000 ) ? (A + B):
	      (ctrl == 3'b111 ) ? (A + B):
              (ctrl == 3'b001) ? (A - B):
	      (ctrl == 3'b010) ? (A - B): 
	      (ctrl == 3'b110) ? (A - B): 
              (ctrl == 3'b011) ? (A & B) :
	      (ctrl == 3'b101) ? (A & B) :
              (ctrl == 3'b100) ? (~B) :33'b0;
  assign Z = (Out == 32'd0) ? 1'b1 : 1'b0; 
  assign N = (Out[31] == 1'b1) ? 1'b1 : 1'b0; 
  assign V = ((ctrl==3'b000 | ctrl==3'b111) &((~A[31]& B[31] & Out[31])|(A[31]& B[31] & Out[31])))? 1'b1: 
	     ((ctrl==3'b001 | ctrl==3'b010 | ctrl==3'b110) &((~A[31]&  B[31] & Out[31])|(A[31]&  B[31] & Out[31])))? 1'b1 :1'b0;
endmodule
