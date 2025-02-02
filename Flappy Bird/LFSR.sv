// EE 271
// Lab 6
// Xinyu Gu

// This module implements a 3-bit linear
// feedback shift register to generate 
// random numbers

module LFSR(clk, reset, active, out);

	input logic clk, active;  // Clock
	input logic reset;  // Asynchronous reset active low
	output logic [2:0] out;


	
	always_ff @(posedge clk) begin
		if(reset | ~active) begin
			out <= 3'd0;
		end
		else	begin
				out[2] <= out[1];
				out[1] <= out[0];
				out[0] <= (out[0] ^~ out[2]);
			
		end 
	end

endmodule


// This mudole simulates the functions of 
// module LFSR

module LFSR_testbench ();
	logic clk, reset;
	logic [2:0] out;

	LFSR randomNumber (.clk, .reset, .out);

	// Set up the clock
	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	always begin
		#(CLOCK_PERIOD / 2);
		clk = ~clk;
	end 

	initial begin	
									@(posedge clk);
		reset <= 1;					@(posedge clk);
		reset <= 0; 				@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
		$stop;
	end
endmodule