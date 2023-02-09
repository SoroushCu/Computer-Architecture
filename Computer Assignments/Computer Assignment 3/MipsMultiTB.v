`timescale 1ns/1ns
module MipsMultiTB();    reg clk,rst;    wire [31:0]mux1_out,Bwrite,Mem_out,MinVal,MinIndice;    wire  MemRead,MemWrite;    MipsMultiCycle  CPU(clk,rst,Mem_out,mux1_out,Bwrite,MemRead,MemWrite);    Memory memory(mux1_out, Bwrite, MemRead, MemWrite, clk, Mem_out,MinIndice,MinVal);    initial    begin
        rst  = 1'b1;        clk  = 1'b0;        #20 rst = 1'b0;        #7000 $stop;    end      always    begin    #10 clk = ~clk;    endendmodule
