module scrambler #
(    // width of LFSR
    parameter LFSR_WIDTH = 16,
    // LFSR polynomial
    parameter LFSR_POLY = 16'b11010000000010001,
    // LFSR seed
    parameter LFSR_SEED = 1,
    parameter LFSR_USED_OUT = LFSR_WIDTH,
    // bit-reverse input and output
    parameter OUT_NO = 2**LFSR_USED_OUT-1
)
(reset, clk, enables);
   input reset, clk;
   output enables;
   wire[LFSR_WIDTH-1:0] lfsr_out;
   
   lfsr #(LFSR_WIDTH, LFSR_POLY, LFSR_SEED) LFSR1 (reset, clk, lfsr_out);
   decoder #(LFSR_USED_OUT, OUT_NO) DEC1 (lfsr_out[LFSR_USED_OUT-1:0], enables);
endmodule