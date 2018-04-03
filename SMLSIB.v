module SMLSIB (FromSO, SI, ShiftEN, CaptureEN, UpdateEn, Select, CompOut,
                  			Clock, RstBar,
                  			SO, ToSI, ToSelect);
input FromSO, SI, ShiftEN, CaptureEN,UpdateEn, Select, CompOut;
input Clock, RstBar;
output SO, ToSI, ToSelect;
wire D_DF1, D_DF2, Q_DF1, Q_DF2, Q_DF3, MO1, MO2;
MUX2_1 mux1 (.i1(SI), .i2(FromSO), .sel(Q_DF2), .out(MO1));
MUX2_1 mux2 (.i1(Q_DF1), .i2(MO1), .sel(Select & ShiftEN), .out(MO2));
MUX2_1 mux3 (.i1(MO2), .i2(Q_DF2), .sel(Select & CaptureEN), .out(D_DF1));
D_FF   DFF1 (.D(D_DF1), .CLK(Clock), .Q(Q_DF1), .RstBar(RstBar));
MUX2_1 mux4 (.i1(Q_DF2), .i2(Q_DF1), .sel(Select & UpdateEN &(~Q_DF1 | CompOut)& (~Q_DF3)), .out(D_DF2));
D_FF   DFF2 (.D(D_DF2), .CLK(Clock), .Q(Q_DF2), .RstBar(RstBar));
D_FF   DFF3 (.D((Select & UpdateEN & ~CompOut)|Q_DF3), .CLK(Clock), .Q(Q_DF3), .RstBar(RstBar));

assign ToSelect  = Q_DF2 & Select;
assign SO  = Q_DF1;
assign ToSI = SI;

endmodule
