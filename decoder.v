// a - binary input (n bits wide)
// b - one hot output (m bits wide)
module decoder(a, b) ;
    parameter n=2 ;
    parameter m=4 ;
    input [n-1:0] a ;
    output [m-1:0] b ;
    wire [m-1:0] one= 1'b1;
    wire [m-1:0] b = {one} <<a;
endmodule

