
// EE 217
// Lab 6
// Xinyu Gu


// This module takes in three inputs that 
// include a clock for timing the posedge
// change, a reset for reset and an input 
// that needs to be properly corrected 
// This module propers and outputs a corrected
// input to present the exact time of input 
// and to avoid metastability
module D_FF(clk,reset, T, O);


	input logic clk;   
	input logic reset;  
	input logic T;
	output logic O;
	
	logic ps, ns;
	
	always_comb ns = T;
	// assign ns = T;
	
	assign O = ps;
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= 1'b0;
		else 
			ps <= ns;
	
	end
	
endmodule

// This module tests the function of module
// D_FF through simulations
module D_FF_testbench ();
	logic clk;
	logic reset;
	logic T;
	logic O;

	D_FF dut (.clk, .reset, .T, .O);
	
	// Set up the clock
	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	always begin
		#(CLOCK_PERIOD / 2);
		clk = ~clk;
	end 

	
	initial begin	
									@(posedge clk);
									@(posedge clk);
		reset <= 1;					@(posedge clk);
		reset <= 0; T <= 1;   	@(posedge clk);
                           			@(posedge clk);
                           			@(posedge clk);
                           			@(posedge clk);
                    T <= 0;    @(posedge clk);
                    @(posedge clk);
                    T <= 1; @(posedge clk);
                    @(posedge clk);
                    @(posedge clk);
                    @(posedge clk);
                    @(posedge clk);
                    @(posedge clk);
                    T <= 0; @(posedge clk);
                    @(posedge clk);
	$stop;
	end

endmodule