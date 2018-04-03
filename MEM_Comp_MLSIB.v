
module MEM_Comp_MLSIB  (FromSO, SI, ShiftEN, CaptureEN, UpdateEn, Select, KBits,
                  			Clock, RstBar,
                  			SO, ToSI, ToSelect);
parameter Length = 256;
parameter key_value= 3412345;
input FromSO, SI, ShiftEN, CaptureEN,UpdateEn, Select;
input Clock, RstBar;
input [Length-1:0] KBits;
output SO, ToSI, ToSelect;
wire [Length-1:0] data;

wire CompOut;

reg [Length-1:0] my_memory= key_value;

MLSIB SIB1(FromSO, SI, ShiftEN, CaptureEN, UpdateEn, Select,CompOut,
                  			Clock, RstBar,
                  			SO, ToSI, ToSelect);
Comp #(Length) COMP1 (my_memory, KBits, CompOut);
//assign CompOut= ~|(my_memory ^ KBits);
                  			
endmodule
