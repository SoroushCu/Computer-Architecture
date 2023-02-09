`timescale 1ns/1ns
module MUX2to1 #(parameter n=10)(input [n-1:0] In1,In2,input Sel,output [n-1:0] Out);
	assign Out=Sel? In2:In1;
endmodule

module Register #(parameter n=5)(input [n-1:0] ParIn,input CLK,RST,LD,output reg [n-1:0] ParOut);
	always@(posedge CLK,posedge RST) begin
	   if(RST)
             ParOut<=5'd0;    
	   else
             ParOut<=(LD) ? ParIn : ParOut;
	end
endmodule

module SHtoLRegister #(parameter n=10)(input[n-1:0] ParIn,input CLK,RST,LD,SIR,EN,output reg[n-1:0] ParOut);
	always@(posedge CLK,posedge RST)begin
		if (RST) ParOut<=9'd0;
		else if(LD) ParOut<=ParIn;
		else if(EN)
		     ParOut<={ParOut[n-2:0],SIR};
	end
		    	
endmodule

module DCNT3BIT #(parameter n=3)(input[n-1:0] ParIn,input CLK,RST,CNT,LD,SEL,output reg[n-1:0]ParOut,output CO);
	always@(posedge CLK,posedge RST)begin
		if(RST) ParOut<=3'd0;
		else begin
		     if(LD)
			ParOut<=ParIn;
		     else if(CNT) ParOut<=ParOut-1;

		end
	end
	assign CO=(SEL)? &{~ParOut}:1'b0;endmodule
module SUB #(parameter n=5)(input[n-1:0] In1,In2,output[n-1:0] Out);
	assign Out=In1-In2;
endmodule

module PosCheckerandFixer #(parameter n=10)(input[n-1:0] In1,input[n-6:0] In2,output[n-1:0] Out,output PosFlag);
	assign Out=(In2[n-6]) ? In1:{In2,In1[n-6:1],1'b1};
	assign PosFlag= (In2[n-6]) ? 1'b0:1'b1;
endmodule

module InputChecker #(parameter n=10)(input[n-6:0] In1,input[n-6:0] In2,output ov,divbyzero);
	assign divbyzero=(In1==0)?1'b1:1'b0;
	assign ov=(In1>=In2)? 1'b0:1'b1;
endmodule


