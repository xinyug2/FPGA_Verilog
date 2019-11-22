// EE 271
// Lab 6
// Xinyu Gu

// This module activate the game when receive
// the very first user input after the game 
// resets
module activate(clk, reset, press, active);

	input logic clk, reset, press;
	output logic active;
	
	logic ps, ns;
	
	always_comb begin
		ns = ps | press;
	end
	
	assign active = ps;
	
	always_ff @(posedge clk) begin
	
		if (reset) 
			ps <= 0;
		else 
			ps <= ns;
	end 
	
endmodule 

// This module simulates the function of module activate
module activate_testbench();

	logic clk, reset, press;
	logic active;
	
	activate dut (.clk, .reset, .press, .active);
	
	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	always begin
		#(CLOCK_PERIOD / 2);
		clk = ~clk;
	end
	
	initial begin
		reset <= 1;	press <= 1;	@(posedge clk);
						press <= 0;	@(posedge clk);
		reset <= 0;					@(posedge clk);
										@(posedge clk);
						press <= 1;	@(posedge clk);
						press <= 0;	@(posedge clk);
		reset <= 1;					@(posedge clk);
										@(posedge clk);
		$stop;
	end
endmodule