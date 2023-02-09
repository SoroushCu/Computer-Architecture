`timescale 1ns/1ns
module ALU_Controller (ALUOP, Function,OP);
  input [1:0] ALUOP;
  input [5:0] Function;
  output [2:0] OP;
  reg [2:0] OP;
  always @(ALUOP, Function)
 begin
    OP = 3'b000;
    if (ALUOP == 2'b00)// lw or sw or addi
      OP = 3'b010;
    else if (ALUOP == 2'b01)// beq
      OP = 3'b110;
    else if (ALUOP == 2'b10)
      begin
        case (Function)
          6'b000001: OP = 3'b010;// add
          6'b000010: OP = 3'b110;// sub
          6'b000100: OP = 3'b000;// and
          6'b001000: OP = 3'b001;// or
          6'b010000: OP = 3'b111;// slt
          default:   OP = 3'b000;
        endcase
      end
    else//for slti
      OP = 3'b111;
  end  
endmodule
