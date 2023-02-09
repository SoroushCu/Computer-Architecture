`timescale 1ns/1ns
module DividerController (CLK,Start,PosFlag,RST,CNTCO,CNTRST,CNTEN,CNTSEL,CNTLD,REGRST,REGLD,SHREGRST,SHREGLD,SHREGEN,MUXSEL,FINISH,ov,divbyzero,OV,DIVBYZERO);
    input CLK,Start,PosFlag,CNTCO,RST,ov,divbyzero;
    output reg CNTRST,CNTEN,CNTSEL,CNTLD,REGRST,REGLD,SHREGRST,SHREGLD,SHREGEN,MUXSEL,FINISH,OV,DIVBYZERO;
    reg [3:0] PS , NS;
    parameter [3:0] IDLE = 0,INIT = 1,LOAD = 2,INPUTCHECK=3,SHIFT = 4,SUB = 5,POSCHEKNFIX = 6,UPDATESHREG = 7,COCHECK = 8,END = 9;
    always @(Start,PS) begin
        NS = 3'b000;
	{CNTRST,CNTEN,CNTSEL,CNTLD,REGRST,REGLD,SHREGRST,SHREGLD,SHREGEN,MUXSEL,FINISH}=11'd0;
        case (PS)
            IDLE : begin NS = Start ? INIT : IDLE; OV=1'b0;DIVBYZERO=1'b0; end
            INIT : begin NS = Start ? INIT : LOAD; CNTRST=1'b1;REGRST=1'b1;SHREGRST=1'b1;CNTSEL=1'b1; end
            LOAD : begin NS = INPUTCHECK; CNTLD=1'b1; REGLD=1'b1; SHREGLD=1'b1;MUXSEL=1'b0;CNTSEL=1'b1; end
	    INPUTCHECK: begin NS=(ov|divbyzero)?IDLE:SHIFT; if(ov==1) OV=1'b1; if(divbyzero==1) DIVBYZERO=1'b1; CNTSEL=1'b1;  end
            SHIFT : begin NS = SUB; SHREGEN=1'b1;CNTEN=1;CNTSEL=1'b1; end
            SUB : begin NS = POSCHEKNFIX;CNTSEL=1'b1; end
            POSCHEKNFIX : begin NS = PosFlag ? UPDATESHREG : COCHECK;CNTSEL=1'b1; end
            UPDATESHREG : begin NS = COCHECK; SHREGLD=1'b1;MUXSEL=1'b1;CNTSEL=1'b1;end
	    COCHECK : begin NS=CNTCO ? END:SHIFT; CNTSEL=1'b1; end
            END : begin NS = IDLE; FINISH=1'b1; end
            default: NS = IDLE; 
        endcase
    end
    always @(posedge CLK,posedge RST) begin
	if(RST)
	  PS<=IDLE;
	else
         PS <= NS;
    end
endmodule