`timescale 1ns/1ns
module MIPSPipelineTB();


    wire [31:0] inst_adr, inst, data_adr, data_in, data_out,MinVal,MinIndice;
    wire mem_read_to_data_mem, mem_write_to_data_mem;
    reg clk, rst;
    
    MIPSPipeTopLevel CPU(clk, rst, inst_adr, inst, data_adr, data_out, data_in, mem_write_to_data_mem, mem_read_to_data_mem);

    InstMem IM (inst_adr, inst);
    
    DataMem DM (data_adr, data_out, mem_read_to_data_mem, mem_write_to_data_mem, clk, data_in, MinVal, MinIndice);  
    initial
    begin
        rst     = 1'b1;
        clk     = 1'b0;
        #20 rst = 1'b0;
        #8000 $stop;
    end
    
    always
    begin
        #8 clk = ~clk;
    end
endmodule
