

module MEM_Comp_SMLSIB  (FromSO, SI, ShiftEN, CaptureEN, UpdateEn, Select, KBits,
                  			Clock, RstBar,
                  			SO, ToSI, ToSelect);
parameter Length = 128;
parameter key_value= 3476123;
input FromSO, SI, ShiftEN, CaptureEN,UpdateEn, Select;
input Clock, RstBar;
input [Length-1:0] KBits;
output SO, ToSI, ToSelect;

wire CompOut;

reg [Length-1:0] my_memory= key_value;

SMLSIB SIB1(FromSO, SI, ShiftEN, CaptureEN, UpdateEn, Select,CompOut,
                  			Clock, RstBar,
                  			SO, ToSI, ToSelect);
//assign CompOut= (my_memory==KBits)  ? 1:0;                	
Comp #(Length) COMP1 (my_memory, KBits, CompOut);
                  		
endmodule
