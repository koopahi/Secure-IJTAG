
module lfsr #
(
    // width of LFSR
    parameter LFSR_WIDTH = 32,
    // LFSR polynomial
    parameter LFSR_POLY = 32'h10000001,
    // LFSR seed
    parameter LFSR_SEED = 1
    // bit-reverse input and output
)
( reset, clk, lfsr_out
);
    output reg [LFSR_WIDTH-1:0] lfsr_out;  // lfsr register
	 input reset, clk;

    wire feedback;

    assign feedback = ^(lfsr_out & LFSR_POLY); // depends on polynomial used

    always@(posedge clk) begin

        if (reset)
            lfsr_out <= 8'hFF;   // lfsr must be non-zero to work

        else
            lfsr_out <= {lfsr_out[LFSR_WIDTH-2:0], feedback};

end
endmodule

