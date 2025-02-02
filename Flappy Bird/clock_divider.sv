
// EE 271 
// Xinyu Gu
// Lab 6

// This module generates slower clocks from
// a given clock
// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ...
// [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ...
module clock_divider (clock, divided_clocks);

	input logic clock;
	output logic [ 31 : 0 ] divided_clocks;
	
	initial begin
		divided_clocks <= 0 ;
	end

	always_ff @( posedge clock) begin
		divided_clocks <= divided_clocks + 1 ;
	end

endmodule