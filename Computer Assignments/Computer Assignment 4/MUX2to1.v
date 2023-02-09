`timescale 1ns/1ns
module MUX2to1 #(parameter n=10)(input [n-1:0] In1,In2,input Sel,output [n-1:0] Out);
	assign Out=Sel? In2:In1;
endmodule

