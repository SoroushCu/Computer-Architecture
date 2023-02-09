`timescale 1ns/1ns
module ALU (A, B, ctrl, Out, zero);
  input [31:0] A, B;
  input [2:0] ctrl;
  output [31:0] Out;
  output zero;
  assign Out =(ctrl == 3'b000) ? (A & B) :// for And
              (ctrl == 3'b001) ? (A | B) : // for Or
              (ctrl == 3'b010) ? (A + B) ://for Add
              (ctrl == 3'b110) ? (A - B) :// for Sub
	      (($signed(A)<$signed(B)) ? 32'd1: 32'd0);//for Slt
  assign zero = (Out == 32'd0) ? 1'b1 : 1'b0; 
endmodule