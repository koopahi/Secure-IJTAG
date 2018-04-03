module scrambler_Test();
    reg reset, clk;
    wire [] enables;
    scrambler #(2,4) DUT1(reset, clk, enables);
    initial begin
        in = 2’b00;
        #5
        $display("With input %b, output is %b", in, out);
        in = 2’b01;
        #5
        $display("With input %b, output is %b", in, out);
        in = 2’b10;
        #5
        $display("With input %b, output is %b", in, out);
        in = 2’b11;
        #5
        $display("With input %b, output is %b", in, out);
        $stop;
    end
endmodule
