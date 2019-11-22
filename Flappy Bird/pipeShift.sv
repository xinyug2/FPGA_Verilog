// EE 271
// Lab 6
// Xinyu Gu

// This module propagate the pipe pattern generated from
// the right of the led array to the left of the led array,
// towards the bird
module pipeShift (clk, reset, active, gameover, newPattern, pipe);

	input logic clk, reset, active, gameover;
	input logic [7:0] newPattern;
	output logic [7:0] pipe;
	
	logic [7:0] count = 0;
	logic [7:0] ps, ns;
	
	always_comb begin
		if (gameover) 
			ns = ps;
		else 
			ns = newPattern;
	
	end
	
	assign pipe = ps;
	
	always_ff @(posedge clk) begin
	
		if (reset | ~active) begin
			ps[7:0] <= 8'b00000000;
			count <= 0;
		end
		else begin
			if (count == 0) 
				ps[7:0] <= ns;
			
			count <= count + 1'b1;
		end
		
	end
	
endmodule 

// This module simulates the function of module pipeShift
module pipeShift_testbench();
	logic clk, reset, active, gameover;
	logic [7:0] newPattern;
	logic [7:0] pipe;
	
	pipeShift dut(.clk, .reset, .active, .gameover, .newPattern, .pipe);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial clk=1;
	always begin
		#(CLOCK_PERIOD/2);
		clk = ~clk;
	end
	
	initial begin
		reset <= 1;	active <= 0;	newPattern <= 8'b10100110;	
																		@(posedge clk);
		reset <= 0;													@(posedge clk);
						active <= 1;								@(posedge clk);
						newPattern <= 8'b11010101;				@(posedge clk);
						gameover <= 1;									@(posedge clk);
						newPattern <= 8'b11010111;				@(posedge clk);
																		@(posedge clk);
		$stop;
	end
endmodule
