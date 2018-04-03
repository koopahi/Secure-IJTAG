
module Comp #(parameter SIZE=8)(a, b, eq );
  input[SIZE-1:0] a, b;
  output eq;
  wire [SIZE-1:0] axb;

   assign eq = ~| axb;
   genvar i;                                      
   generate for (i=0; i<SIZE; i=i+1) begin: row   
     xor my_xor (axb[i], a[i], b[i]);
   end endgenerate
endmodule
