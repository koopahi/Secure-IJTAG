module decoder_Test();
    reg[2:0] in;
    wire[3:0] out;
    decoder #(3,4) DEC1(in,out);
    initial begin
        in = 2'b00;
        #5
        $display("With input %b, output is %b", in, out);
        in = 2'b01;
        #5
        $display("With input %b, output is %b", in, out);
        in = 2'b10;
        #5
        $display("With input %b, output is %b", in, out);
        in = 3'b110;
        #5
        $display("With input %b, output is %b", in, out);
        $stop;
    end
endmodule