module IF_ID(clk, rst, ld, FLSH, inst, ADD1, inst_out, ADD1_Out);
    input clk, rst, FLSH;
    input [31:0] inst, ADD1;
    input ld;   
    output reg [31:0] inst_out, ADD1_Out;
    always @(posedge clk)
    begin
        if (FLSH)
        begin
            inst_out <= 32'b0;
        end
        else
        if (rst)
        begin
            ADD1_Out <= 32'b0;
            inst_out <= 32'b0;
        end
        else
        begin
            if (ld) begin
                inst_out <= inst;
                ADD1_Out <= ADD1;    
            end
        end
    end
endmodule
