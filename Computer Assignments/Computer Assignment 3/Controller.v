`timescale 1ns/1ns
module Controller(Cond,LT,LB,I,inst,opc,MemtoReg, RegDst, PCSrc,
 reg_write,PCWrite,IorD,RmorRd,LoadALU,loadZN,loadCV,IRWrite,memRead,
memWrite,AluSrcA,AluSrcB,AluOP,clk,rst);
  input Cond,I,LT,LB,clk,rst;
  input [2:0] inst,opc;
  output reg MemtoReg, RegDst, PCSrc, reg_write,PCWrite,IorD,RmorRd,LoadALU;
  output reg loadZN,loadCV,IRWrite,memRead,memWrite;
  output reg [1:0]AluSrcA,AluSrcB;
  output reg [2:0]AluOP;
  reg[4:0] ps, ns;
  always@(ps)begin
    ns = 5'b0;
    {MemtoReg, RegDst,  PCSrc, reg_write,PCWrite,
       IorD,RmorRd,LoadALU,loadZN,loadCV,IRWrite,memRead,
        memWrite,AluSrcA,AluSrcB,AluOP} = 20'b0;
    case(ps)
      /*IF*///0
      5'b00000: begin
        ns = 5'b00001;
        {AluSrcA,AluSrcB,PCSrc,PCWrite,IorD,IRWrite,memRead,AluOP} = 12'b000101011000;
      end
      /*ID*///1
      5'b00001: begin
        if(Cond==1'b0) ns = 5'b00000;
        if(Cond==1'b1 & inst==3'b101 & LB==1'b1) ns = 5'b00010;
        if(Cond==1'b1 & inst==3'b101 & LB==1'b0) ns = 5'b00100;
        if(Cond==1'b1 & inst==3'b010) ns = 5'b00101;
        if(Cond==1'b1 & inst==3'b000 &(opc==3'b011|opc==3'b100|opc==3'b101)) ns = 5'b01001;
        if(Cond==1'b1 & inst==3'b000 &(opc==3'b000|opc==3'b001|opc==3'b010|opc==3'b110)) ns = 5'b01110;
        if(Cond==1'b1 & inst==3'b000 & opc==3'b111) ns = 5'b10001;
        {AluOP,AluSrcA, AluSrcB} = 7'b0000011;
      end 
      //2
      5'b00010: begin
        {AluSrcA, AluSrcB, AluOP,PCSrc} = 8'b00010000;
        ns = 5'b00011;
      end
      //3
      5'b00011: begin
        {RegDst, MemtoReg,reg_write} = 3'b111;
        ns = 5'b00100;
      end
      //4
      5'b00100: begin
        {AluSrcA, AluSrcB, AluOP, PCSrc,PCWrite} = 9'b001100001;
        ns = 5'b00000;
      end
      //5
      5'b00101:begin
        {AluSrcA, AluSrcB, AluOP, LoadALU} = 8'b01100001;
         if(LT==1'b0) ns = 5'b00110;
         if(LT==1'b1) ns = 5'b01000;
      end
      //6
      5'b00110: begin
        {IorD, memRead} = 2'b11;
        ns = 5'b00111;
      end
      //7
      5'b00111: begin
        {RegDst, reg_write, MemtoReg} = 3'b010;
        ns = 5'b00000;
      end
      //8
      5'b01000: begin
        {IorD, memWrite} = 2'b11;
        ns = 5'b00000;
      end
      //9
      5'b01001: begin
       if(I==1'b0) ns = 5'b01010;
       if(I==1'b1) ns = 5'b01101;
      end
      //10
      5'b01010: begin
        {AluSrcA, AluSrcB, RmorRd,loadZN} = 6'b010011;
	AluOP=opc;
        if (opc==3'b101) ns = 5'b00000;
        if (opc!=3'b101) LoadALU=1'b1;
	if (opc!=3'b101) ns = 5'b01100;
      end
      //12
      5'b01100: begin
        {RegDst,MemtoReg,reg_write } = 3'b011;
        ns = 5'b00000;
      end
      //13
      5'b01101: begin
         {AluSrcA, AluSrcB,loadZN} = 5'b01101;
         AluOP=opc;
         if (opc==3'b101) ns = 5'b00000;
	 if (opc!=3'b101) LoadALU=1'b1;
	 if (opc!=3'b101) ns = 5'b01100;
      end
      //14
      5'b01110: begin
       if(I==1'b0) ns = 5'b01111;
       if(I==1'b1) ns = 5'b10000;
       RmorRd = 1'b1;
      end
      //15
      5'b01111: begin
       {AluSrcA, AluSrcB,loadZN,loadCV} = 6'b010011;
       AluOP=opc;
       if(opc==3'b110) ns = 5'b00000;
       if(opc!=3'b110) LoadALU=1'b1;
       if(opc!=3'b110) ns = 5'b01100;
      end
      //16
      5'b10000: begin
       {AluSrcA, AluSrcB,loadZN,loadCV}=6'b011011;
	AluOP=opc;
       if(opc==3'b110) ns = 5'b00000;
       if(opc!=3'b110) LoadALU=1'b1;
       if(opc!=3'b110) ns = 5'b01100;
      end
      //17
      5'b10001: begin
       if(I==1'b0) ns = 5'b10010;
       if(I==1'b1) ns = 5'b10011;
      end
      //18
      5'b10010: begin
       {AluSrcA, AluSrcB, AluOP,RmorRd,loadZN,LoadALU}=10'b1000000111;
       ns = 5'b01100;
      end
      //19
      5'b10011: begin
       {AluSrcA, AluSrcB, AluOP,loadZN,LoadALU}=9'b101000011;
        ns = 5'b01100;
      end
    endcase
  end  
  always@(posedge clk, posedge rst) begin
    if(rst) ps <= 5'b00000;
    else ps <= ns;
  end  
endmodule

