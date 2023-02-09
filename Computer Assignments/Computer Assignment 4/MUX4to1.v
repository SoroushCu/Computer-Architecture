`timescale 1ns/1ns
module MUX4to1#(parameter n=10)( input [n-1:0] In1 , In2, In3 , In4 , input [1:0]Sel , output [n-1:0]Out);
	assign Out = (Sel == 2'b00) ? In1 : 
	             (Sel == 2'b01) ? In2 : 
	             (Sel == 2'b10) ? In3 : 
	             (Sel == 2'b11) ? In4 : 32'bx;
endmodule

