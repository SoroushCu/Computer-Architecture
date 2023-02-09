`timescale 1ns/1ns
module DataMem (adr, Datain, mread, mwrite, clk, Dataout,MinIndice,MinVal);
  input [31:0] adr;
  input [31:0] Datain;
  input mread, mwrite, clk;
  output [31:0] Dataout,MinVal,MinIndice;
  reg [31:0] mem[0:65535];  
  initial
  begin
      $readmemb("Datamemorytext.txt",mem);
  end 
  always @(posedge clk)
    if (mwrite==1'b1)
      {mem[adr+3], mem[adr+2], mem[adr+1], mem[adr]} = Datain;
  assign MinIndice = {mem[2003], mem[2002], mem[2001], mem[2000]};
  assign MinVal = {mem[2007], mem[2006], mem[2005], mem[2004]};
  assign Dataout = (mread==1'b1) ? {mem[adr+3], mem[adr+2], mem[adr+1], mem[adr]} : 32'd0;
endmodule   
