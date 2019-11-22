// EE 271
// Lab 4
// Xinyu Gu

// This module takes in 6 inputs that include
// a clock for timing the posedge change, a reset
// for reset the status, two inputs that indicate
// the status of the edge lights and two user
// inputs. 
// This module outputs and displays the winner

module Winner(clk, reset, L, R, LE, RE, W);

	input logic clk,reset,L,R,LE,RE;
	output [6:0] W;
	
	logic [6:0] ps,ns;
	
	parameter [6:0] off = 7'b1111111;
	parameter [6:0] one = 7'b1111001;
	parameter [6:0] two = 7'b0100100;
						 
	always_comb begin
	
		case(ps)
		
			off: if (L & ~R & LE) 		ns = one;
				  else if (~L & R & RE) ns = two;
				  else 						ns = off;
				  
			one: ns = one;
			two: ns = two;
			
			default: ns = off;
			
		endcase
	end 
	
	assign W = ps;
	
	always_ff @(posedge clk) 
		if (reset) 
			ps <= off;
		else 
			ps <= ns;
			
		
endmodule 


// This module tests the functions of module winner
// through simulation
module Winner_testbench();

	logic clk,reset,L,R,LE,RE;
	logic [6:0] W;
	
	Winner dut(.clk,.reset,.L,.R,.LE,.RE,.W);
	
	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	always begin
		#(CLOCK_PERIOD / 2);
		clk = ~clk;
	end 
	
	initial begin
		reset = 1'b1;
									      @(posedge clk);
		reset = 1'b0;
											@(posedge clk);
		L <= 0; R <= 0; LE <= 0; RE <= 0;   
											@(posedge clk);
		                           @(posedge clk);
											@(posedge clk);
		L <= 0; R <= 0; LE <= 0; RE <= 1;
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
		L <= 0; R <= 0; LE <= 1; RE <= 0;
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);									
		L <= 0; R <= 1; LE <= 0; RE <= 0;    
											@(posedge clk);
		                           @(posedge clk);
											@(posedge clk);
		L <= 1; R <= 0; LE <= 0; RE <= 0;
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
		L <= 1; R <= 1; LE <= 0; RE <= 1;
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
		L <= 1; R <= 0; LE <= 1; RE <= 0;
											@(posedge clk);
											@(posedge clk);
		                           @(posedge clk);
		L <= 1; R <= 1; LE <= 1; RE <= 0;
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
		L <= 1; R <= 0; LE <= 0; RE <= 1;
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
		L <= 0; R <= 1; LE <= 0; RE <= 1;
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
		L <= 0; R <= 1; LE <= 1; RE <= 0;
		                           @(posedge clk);
											@(posedge clk);
											@(posedge clk);
											
		$stop;
		
	
	end
endmodule 

	