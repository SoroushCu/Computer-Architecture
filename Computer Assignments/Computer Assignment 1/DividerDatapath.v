`timescale 1ns/1ns
module DividerDatapath(CLK,Divisor,Dividend,Rem,Quo,CNTRST,CNTEN,CNTSEL,CNTLD,CNTCO,REGRST,REGLD,SHREGRST,SHREGLD,SHREGEN,MUXSEL,POSFLAG,ov,divbyzero);
	input CLK,CNTRST,CNTEN,CNTSEL,CNTLD,CNTCO,REGRST,REGLD,SHREGRST,SHREGLD,SHREGEN,
	MUXSEL,POSFLAG,ov,divbyzero;
	input [9:0] Dividend;
	input [4:0] Divisor;
	output [4:0] Quo,Rem;
	reg SHREGSIR=1'b0;
	reg[2:0] DCNTStartPoint=3'b101;
	wire[2:0] CNTOUT;
	wire [4:0] REGOUT,SUBOUT;
	wire[9:0] SHREGIN,SHREGOUT,PFIXEROUT;
	assign Rem=SHREGOUT[9:5];
	assign Quo=SHREGOUT[4:0];
	Register #(5) DivisorReg(Divisor,CLK,REGRST,REGLD,REGOUT);
	SHtoLRegister #(10) TheNum(SHREGIN,CLK,SHREGRST,SHREGLD,SHREGSIR,SHREGEN,SHREGOUT);
	InputChecker #(10) CheckingInputs(Divisor,Dividend[9:5],ov,divbyzero);
	SUB #(5) Subtraction(SHREGOUT[9:5],Divisor,SUBOUT);
	PosCheckerandFixer #(10) CHECKNFIX(SHREGOUT,SUBOUT,PFIXEROUT,POSFLAG);
	MUX2to1 #(10) Multiplexing(Dividend,PFIXEROUT,MUXSEL,SHREGIN);
	DCNT3BIT #(3) Downcounting(DCNTStartPoint,CLK,CNTRST,CNTEN,CNTLD,CNTSEL,CNTOUT,CNTCO);
endmodule