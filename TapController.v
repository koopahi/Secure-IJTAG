module TapController (TMS, TCK, RstBar, sel, Enable, 
			ShiftIR, ClockIR, UpdateIR, ShiftDR, ClockDR, UpdateDR);
			
 input TMS;
 input TCK;
 output reg RstBar = 1'b0;
 output sel;
 output reg Enable;
 output reg ShiftIR, ClockIR, UpdateIR;
 output reg ShiftDR, ClockDR, UpdateDR;


	parameter [3:0]Test_logic_reset   =4'b1111;
	parameter [3:0]run_test_idle      =4'b1100;
	parameter [3:0]select_DR_scan     =4'b0111;
	parameter [3:0]capture_DR         =4'b0110;
	parameter [3:0]shift_DR           =4'b0010;
	parameter [3:0]exit1_DR           =4'b0001;
	parameter [3:0]pause_DR           =4'b0011;
	parameter [3:0]exit2_DR           =4'b0000; 
	parameter [3:0]update_DR          =4'b0101;
	parameter [3:0]select_IR_scan     =4'b0100;
	parameter [3:0]capture_IR         =4'b1110;
	parameter [3:0]shift_IR           =4'b1010;
	parameter [3:0]exit1_IR           =4'b1001;
	parameter [3:0]pause_IR           =4'b1011;
	parameter [3:0]exit2_IR           =4'b1000;
	parameter [3:0]update_IR          =4'b1101;

	reg [3:0]TAP_STATE = Test_logic_reset;
  always @( posedge TCK)
	begin
	//if (TCK == 1'b1 )
	//begin
		case( TAP_STATE )
		  
			Test_logic_reset :
				if( TMS == 1'b0 ) 
					TAP_STATE = run_test_idle;
				else if( TMS == 1'b1) 
					TAP_STATE = Test_logic_reset;
					
			run_test_idle:
				if (TMS == 1'b1) 
					TAP_STATE = select_DR_scan;
				else if (TMS == 1'b0) 
					TAP_STATE = run_test_idle;
				
			select_DR_scan :
				if( TMS == 1'b0) 
					TAP_STATE = capture_DR;
				else if (TMS == 1'b1) 
					TAP_STATE = select_IR_scan;
				
			capture_DR:
				if(TMS == 1'b0)
					TAP_STATE = shift_DR;
				else if(TMS == 1'b1)
					TAP_STATE = exit1_DR;
				
			shift_DR:
				if(TMS == 1'b1) 
					TAP_STATE = exit1_DR;
				else if(TMS == 1'b0) 
					TAP_STATE = shift_DR;
				
			exit1_DR:
				if(TMS == 1'b0)  
					TAP_STATE = pause_DR;
				else if(TMS == 1'b1) 
					TAP_STATE = update_DR;
				
			pause_DR:
				if(TMS == 1'b1) 
					TAP_STATE = exit2_DR;
				else if( TMS == 1'b0) 
					TAP_STATE = pause_DR;
				
			exit2_DR:
				if( TMS == 1'b1)
				  TAP_STATE = update_DR;
				else if ( TMS == 1'b0) 
				  TAP_STATE = shift_DR;
				
			update_DR:
				if (TMS == 1'b0)  
					TAP_STATE = run_test_idle;
				else if (TMS == 1'b1) 
					TAP_STATE = select_DR_scan;
				
			select_IR_scan: 
				if ( TMS == 1'b0)  
					TAP_STATE = capture_IR;
				else if (TMS == 1'b1) 
					TAP_STATE = Test_logic_reset;
				
			capture_IR:
				if ( TMS == 1'b0)
					TAP_STATE = shift_IR;
				else if( TMS == 1'b1) 
					TAP_STATE = exit1_IR;
				
			shift_IR:
				if (TMS == 1'b1) 
					TAP_STATE = exit1_IR;
				else if( TMS == 1'b0) 
					TAP_STATE = shift_IR;
				
			exit1_IR:
				if ( TMS == 1'b0) 
					TAP_STATE = pause_IR;
				else if (TMS == 1'b1) 
					TAP_STATE = update_IR;
				
			pause_IR:
				if ( TMS == 1'b1) 
					TAP_STATE = exit2_IR;
				else if (TMS == 1'b0) 
					TAP_STATE = pause_IR;
				
			exit2_IR:
				if (TMS == 1'b1) 
					TAP_STATE = update_IR;
				else if( TMS == 1'b0) 
					TAP_STATE = shift_IR;
				
			update_IR:
				if( TMS == 1'b0)  
					TAP_STATE = run_test_idle;
				else if ( TMS == 1'b1) 
					TAP_STATE = select_DR_scan;
				
		endcase
	//end // END IF	
	end // END ALWAYS

	

	always @(negedge TCK)
	begin
	  RstBar = 1'b1;
	  Enable = 1'b0;
	  ShiftIR = 1'b0;
	  ShiftDR = 1'b0;
	  ClockIR = 1'b1;
	  UpdateIR = 1'b0;
	  ClockDR = 1'b1;
	  UpdateDR = 1'b0; 
	  
	  case (TAP_STATE)
	    Test_logic_reset:
	       RstBar = 1'b0;
			shift_IR:
			begin
				 Enable = 1'b1;
				 ShiftIR = 1'b1;
				 ClockIR = 1'b0;
			end
			shift_DR:
			begin
			   Enable = 1'b1;	 
				 ShiftDR = 1'b1;
				 ClockDR = 1'b0;				 
			end
			capture_IR:
			   ClockIR = 1'b0;
			update_IR: 
			   UpdateIR = 1'b1;
		  capture_DR:
			   ClockDR = 1'b0;
			update_DR: 
			   UpdateDR = 1'b1;
		endcase
	 end //end always
  	assign sel = TAP_STATE[3];
	  
		/*if (TCK == 1'b0)
		  begin
			 if (TAP_STATE == Test_logic_reset) 
			 	RstBar = 1'b0;
			 else 
				RstBar = 1'b1; 
			
			 if ((TAP_STATE == shift_IR) | (TAP_STATE == shift_DR))
				Enable = 1'b1;
			 else
				Enable = 1'b0;
			
			 if (TAP_STATE == shift_IR) 
				ShiftIR = 1'b1;
			 else 
				ShiftIR = 1'b0; 
			
			 if (TAP_STATE == shift_DR)
				ShiftDR = 1'b1;
			 else 
				ShiftDR = 1'b0;
			end 
		
		if ( ( TCK == 1'b0) &(TAP_STATE == capture_IR) | (TAP_STATE == shift_IR))// TCK somaye ezafe karde
			ClockIR = 1'b0;
		else
			 ClockIR = 1'b1;
			 
		
		if (( TCK == 1'b0) & (TAP_STATE == update_IR )) 
			UpdateIR = 1'b1;
		else 
			UpdateIR = 1'b0; 
		
		if (( TCK == 1'b0) & ( TAP_STATE == capture_DR) | (TAP_STATE == shift_DR))
			ClockDR = 1'b0;
		else 
			ClockDR = 1'b1;
		
		if ( TCK == 1'b0 & TAP_STATE == update_DR) 
			UpdateDR = 1'b1;
		else
			UpdateDR = 1'b0; 
	end // end always

	assign sel = TAP_STATE[3];*/
	
endmodule

