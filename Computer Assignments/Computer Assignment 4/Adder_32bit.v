`timescale 1ns/1ns
module Adder_32bit (input [31:0]a , b,input cin, output cout,output [31:0] sum);
  assign {cout, sum} = a + b + cin;
endmodule
