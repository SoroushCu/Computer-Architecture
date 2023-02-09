module DividerTopLevel (input [9:0]Dividend,input[4:0]Divisor,input CLK,Start,output[4:0]Quo,Rem,output FINISH,OV,DIVBYZERO);
    wire REGLD,REGRST,SHREGLD,SHREGEN,SHREGRST,PosFlag,ov,divbyzero,MUXSEL,CNTLD,CNTRST,CNTEN,CNTSEL,CNTCO;
    DividerDatapath Dpth(CLK,Divisor,Dividend,Rem,Quo,CNTRST,CNTEN,CNTSEL,CNTLD,CNTCO,REGRST,REGLD,SHREGRST,SHREGLD,SHREGEN,MUXSEL,PosFlag,ov,divbyzero);
    DividerController CTRL(CLK,Start,PosFlag,RST,CNTCO,CNTRST,CNTEN,CNTSEL,CNTLD,REGRST,REGLD,SHREGRST,SHREGLD,SHREGEN,MUXSEL,FINISH,ov,divbyzero,OV,DIVBYZERO);
endmodule


