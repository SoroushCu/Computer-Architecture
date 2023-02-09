`timescale 1ns/1ns
module ID_EX_MAIN(clk, rst, read_data1, read_data2, sgnext, Rt, Rd, Rs,
 ADD1, read_data1_out, read_data2_out, sgnextout,
 Rt_out, Rd_out, Rs_out, ADD1_OUT);
    input clk,rst;
    input [31:0] read_data1, read_data2, sgnext,ADD1;
    input [4:0] Rt, Rd, Rs;
    output reg [31:0] read_data1_out, read_data2_out, sgnextout,ADD1_OUT;
    output reg [4:0] Rt_out, Rd_out, Rs_out;
    always @(posedge clk) begin
        if (rst)
        begin
            {read_data1_out, read_data2_out, sgnextout, ADD1_OUT} <= {128'b0};
            {Rt_out, Rd_out, Rs_out} <= {15'b0};
        end
        else
        begin
            {read_data1_out, read_data2_out, sgnextout, ADD1_OUT} <= {read_data1, read_data2, sgnext, ADD1};
            {Rt_out, Rd_out, Rs_out} <= {Rt, Rd, Rs};
        end
    end
endmodule
