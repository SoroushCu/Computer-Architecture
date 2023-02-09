`timescale 1ns/1ns
module FWD_Unit(ID_EX_Rs, ID_EX_Rt, EX_MEM_reg_write, EX_MEM_Rd, MEM_WB_reg_write, MEM_WB_Rd, FWDA, FWDB);
    input EX_MEM_reg_write, MEM_WB_reg_write;
    input [4:0] ID_EX_Rs, ID_EX_Rt,EX_MEM_Rd, MEM_WB_Rd;
    output reg [1:0] FWDA, FWDB;
    always @(ID_EX_Rs, ID_EX_Rt, EX_MEM_reg_write, EX_MEM_Rd, MEM_WB_reg_write, MEM_WB_Rd) begin
        FWDA <= 2'b00;
        FWDB <= 2'b00;
        if ((EX_MEM_reg_write == 1'b1) && (EX_MEM_Rd != 5'b00000) && (EX_MEM_Rd == ID_EX_Rs))
            FWDA <= 2'b10;
        if ((EX_MEM_reg_write == 1'b1) && (EX_MEM_Rd != 5'b00000) && (EX_MEM_Rd == ID_EX_Rt))
            FWDB <= 2'b10;
        if ((MEM_WB_reg_write == 1'b1) && (MEM_WB_Rd != 5'b00000) && (!((EX_MEM_reg_write == 1'b1) && (EX_MEM_Rd != 5'b00000) && (EX_MEM_Rd == ID_EX_Rs))) 
            && (MEM_WB_Rd == ID_EX_Rs))
            FWDA <= 2'b01;
        if ((MEM_WB_reg_write == 1'b1) && (MEM_WB_Rd != 5'b00000) && !((EX_MEM_reg_write == 1'b1) && (EX_MEM_Rd != 5'b00000) && (EX_MEM_Rd == ID_EX_Rt)) 
            && (MEM_WB_Rd == ID_EX_Rt))
            FWDB <= 2'b01;  
    end
endmodule
