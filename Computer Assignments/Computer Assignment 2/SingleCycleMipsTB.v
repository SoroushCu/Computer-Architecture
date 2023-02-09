`timescale 1ns/1ns
module SingleCycleMipsTB;
  wire [31:0] inst_adr, inst, data_adr, data_in, data_out;
  wire mem_read, mem_write;
  reg clk, rst;
  MipsSingleCycle Processor(rst, clk, inst_adr, inst, data_adr, data_out, data_in, mem_read, mem_write);
  InstMem InstMemort (inst_adr, inst);
  DataMem Datamemory (data_adr, data_in, mem_read, mem_write, clk, data_out);
  initial
  begin
    rst = 1'b1;
    clk = 1'b0;
    #20 rst = 1'b0;
    #4200 $stop;
  end
  
  always
  begin
    #10 clk = ~clk;
  end
  
endmodule
