// EE 271
// Lab 5
// Xinyu Gu

// This module takes in 6 inputs that include a clock for 
// timing the posedge change, a reset for reset the status, 
// two inputs that indicate the status of the edge lights 
// and two inputs from the cyber player and the human player
// repectively. 
// This module outputs and displays the current score between
// the cyber player and the human player up to a score of 7
module Counters(clk, reset, L, R, LE, RE, reset_p, D1, D2);

	input logic clk,reset, L, R, LE, RE;
	output logic reset_p;
	output logic [6:0] D1,D2;

	logic [2:0] ps, ns, psc, nsc;
	
	parameter [2:0] zero = 3'b000, seven = 3'b111;
	
	always_comb begin
		
		if ((ps != seven) & (L & ~R & LE)) begin
			reset_p = 1'b1;
			ns = ps + 3'b001;
			nsc = psc;
		end
		else if ((psc != seven) & (~L & R & RE)) begin
			reset_p = 1'b1;
			ns = ps;
			nsc = psc + 3'b001;
		end
		else if (ps == seven && ns == seven) begin
			reset_p = 1'b1;
			ns = ps;
			nsc = psc;
		end
		else begin
			reset_p = 1'b0;
			ns = ps;
			nsc = psc;
		end
		
	end
	
	Display player (.in(psc),.out(D1));
	Display cyber (.in(ps),.out(D2));
	
	always_ff @(posedge clk) 
	
		if (reset) begin
			ps <= zero;
			psc <= zero;
		end
		else begin
			ps <= ns;
			psc <= nsc;
		end

	
endmodule

// This module simulates the function of 
// module Counters
module Counters_testbench();

	logic clk,reset,L,R,LE,RE;
	logic [6:0] D1, D2;
	logic reset_p;
	
	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	always begin
		#(CLOCK_PERIOD / 2);
		clk = ~clk;
	end 
	
	Counters dut (.clk, .reset, .L, .R, .LE, .RE, .reset_p, .D1, .D2);
	
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

	
		