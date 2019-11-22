// EE 271
// Lab 4
// Xinyu Gu


// This module takes in 6 inputs includes a clock 
// for timing the posedge change, a reset for reset
// purpose, two inputs indicate whether the object/light
// on the left/right side is on and two user inputs.
// This module outputs a signal to turn the target
// object/light on/off.
module Lights(clk,reset,C,L,R,LL,RL,On);


	input logic clk,C,L,R,LL,RL,reset;
	// L, input from the left user
	// R, input from the right user
	// LL, state of the light on the left
	// RL, state of the light on the right
	output logic On;
	
	logic ps, ns;
	
	parameter on = 1'b1, off = 1'b0;
	
	always_comb begin
		case(ps)
		
			on:	if (R & L | ~R & ~L) 			 ns = on;
					else 									 ns = off;
					
			off:	if (~R & L & RL | R & ~L & LL) ns = on;
					else 									 ns = off;
					
		
		endcase 
	end 
	
	assign On = ps;
	
	always_ff @(posedge clk) begin
		
		if (reset)
			ps <= C;
		else 
			ps <= ns;
	end
			
endmodule


// This module tests the function of module
// Lights through simulations
module Lights_testbench();

	logic clk, reset, C, L, R, LL, RL;
	logic On;
	
	Lights dut (.clk, .reset, .C, .L, .R, .LL, .RL, .On);
	
	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	
	always begin 
	
		#(CLOCK_PERIOD / 2)
		clk = ~clk;
		
	end
	
	
	initial begin
							
											@(posedge clk)
		reset <= 1'b1;					@(posedge clk)
		C <= 0; L <= 1; R <= 0; LL <= 0; RL <= 1;
											@(posedge clk)
		reset <= 1'b0;
		
		C <= 0; L <= 1; R <= 0; LL <= 0; RL <= 1;				
											@(posedge clk)
											@(posedge clk)
											@(posedge clk)
											
		C <= 0; L <= 0; R <= 0; LL <= 0; RL <= 1; 							
											@(posedge clk)
											@(posedge clk)
											@(posedge clk)
											
		C <= 0; L <= 0; R <= 0; LL <= 1; RL <= 0;							
											@(posedge clk)
											@(posedge clk)
											@(posedge clk)
											
		C <= 0; L <= 0; R <= 1; LL <= 1; RL <= 0;						
											@(posedge clk)
											@(posedge clk)
											@(posedge clk)
											
		C <= 0; L <= 1; R <= 0; LL <= 0; RL <= 0;							
											@(posedge clk)
											@(posedge clk)
											@(posedge clk)
											
		C <= 0; L <= 1; R <= 1; LL <= 1; RL <= 0; 				
											@(posedge clk)
											@(posedge clk)
											@(posedge clk)
											
		C <= 0; L <= 0; R <= 1; LL <= 1; RL <= 0;							
											@(posedge clk)
											@(posedge clk)
											@(posedge clk)
		C <= 0; L <= 1; R <= 0; LL <= 1; RL <= 0;									
											@(posedge clk)
											@(posedge clk)
											@(posedge clk)
											@(posedge clk)
		C <= 0; L <= 0; R <= 1; LL <= 0; RL <= 1;									
											@(posedge clk)
											@(posedge clk)
											@(posedge clk)
											@(posedge clk)
											
		$stop;

	end
	
endmodule 