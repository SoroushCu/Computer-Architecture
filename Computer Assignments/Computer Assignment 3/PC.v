`timescale 1ns/1ns
module PC(input clk, rst, input PCWrite, input  [31:0] PCin, output reg [31:0]PCout);
	always @(posedge clk, posedge rst) begin
		if (rst == 1)
			PCout <= 32'b0;
		else
		  if(PCWrite)
			  PCout <= PCin ;
			else
			  PCout <= PCout ;
	end
endmodule
