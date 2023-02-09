`timescale 1ns/1ns
module InstMem (adr, Dataout);
  input [31:0] adr;
  output [31:0] Dataout;
  reg [31:0] mem[0:65535];
  initial
  begin
    $readmemb("Instructionmemorytext.txt",mem);
  end
  assign Dataout = {mem[adr[15:0]+3], mem[adr[15:0]+2], mem[adr[15:0]+1], mem[adr[15:0]]};
endmodule
