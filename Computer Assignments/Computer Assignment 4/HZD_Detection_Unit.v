`timescale 1ns/1ns
module HZD_Detection_Unit(ID_EX_mem_read, ID_EX_Rt, IF_ID_Rs, IF_ID_Rt, Sel, IF_ID_ld, PC_ld);
    input ID_EX_mem_read;
    input [4:0] ID_EX_Rt, IF_ID_Rs, IF_ID_Rt;
    output reg Sel, IF_ID_ld, PC_ld;
    always @(ID_EX_mem_read, ID_EX_Rt, IF_ID_Rs, IF_ID_Rt)
    begin
        Sel <= 1'b1;
        IF_ID_ld <= 1'b1;
        PC_ld <= 1'b1;

        if (ID_EX_mem_read && ((ID_EX_Rt == IF_ID_Rs) || (ID_EX_Rt == IF_ID_Rt)) ) begin
            Sel <= 1'b0;
            IF_ID_ld <= 1'b0; 
            PC_ld <= 1'b0;
        end
    end
endmodule

