// EE 271
// Xinyu Gu
// Lab 3

// This module utilizes a clock, two inputs that indicates
// wind direction and a input that reset the display and 
// outputs a cycling three-light pattern to corresponding 
// wind directions

module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);

	input logic CLOCK_50; // 50MHz clock.
	output logic [ 6 : 0 ] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [ 9 : 0 ] LEDR;
	input logic [ 3 : 0 ] KEY; // True when not pressed, False when pressed
	input logic [ 9 : 0 ] SW;

	// Generate clk off of CLOCK_50, whichClock picks rate.
	logic [ 31 : 0 ] clk;
	parameter whichClock = 25 ;
	clock_divider cdiv (CLOCK_50, clk);

	// Hook up FSM inputs and outputs.
	logic reset;
	assign reset = ~KEY[ 0 ]; // Reset when KEY[0] is pressed.
	
	

	seaTacLight S1 ( .CLOCK_50(clk[whichClock]), .SW(SW[1:0]), .LEDR(LEDR[2:0]), .reset(reset));


endmodule

