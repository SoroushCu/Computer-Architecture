`timescale 1ns/1ns
module DataMem (adr, Datain, mread, mwrite, clk, Dataout);
  input [31:0] adr;
  input [31:0] Datain;
  input mread, mwrite, clk;
  output [31:0] Dataout;
  reg [31:0] mem[0:65535];  
  initial
  begin
      $readmemb("Datamemorytext.txt",mem);
  end 
  always @(posedge clk)
    if (mwrite==1'b1)
      {mem[adr+3], mem[adr+2], mem[adr+1], mem[adr]} = Datain;
  assign Dataout = (mread==1'b1) ? {mem[adr+3], mem[adr+2], mem[adr+1], mem[adr]} : 32'd0;
endmodule   