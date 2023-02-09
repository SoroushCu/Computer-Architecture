`timescale 1ns/1ns
module Memory(input[31:0] address,writedata, input memRead,memWrite,clk, output[31:0] readdata,MinIndice,MinVal);
  reg [31:0] mem[0:65535];//64k
  initial
  begin
   $readmemb("MemInst.txt",mem);
  end
  assign readdata=memRead ? mem[address] : readdata;
  always@(posedge clk)begin
 	if(memWrite)
	    mem[address]=writedata;
   end
  assign MinVal = {mem[2003], mem[2002], mem[2001], mem[2000]};
  assign MinIndice = {mem[2007], mem[2006], mem[2005], mem[2004]};
endmodule