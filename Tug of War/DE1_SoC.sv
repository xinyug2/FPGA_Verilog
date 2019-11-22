// EE 271
// Lab 4
// Xinyu Gu

// This module takes 4 inputs that include a clock for
// timing the posedge change, a reset for reset and two
// user inputs. SW9 is used for reset, KEY0 and KEY1 
// are used for user inputs
// This module displays the current status of the game
// through a 9-LED light pattern on LEDR8 to LEDR0 as 
// well as the winner (in number) when the game is
// finished

module DE1_SoC (CLOCK_50, HEX0, HEX1,HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);

	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	input logic CLOCK_50;
	
	logic L, R;
	
	D_FF flopL (.clk(CLOCK_50), .reset(SW[9]), .T(KEY[3]), .O(L));
	D_FF flopR (.clk(CLOCK_50), .reset(SW[9]), .T(KEY[0]), .O(R));
	
	
	Play P1 (.clk(CLOCK_50), .reset(SW[9]), .L(L), .R(R), .LEDR(LEDR[8:0]), .W(HEX0));
	
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
endmodule
	
//This module tests the functions of module DE1_SoC
// through simulation 
module DE1_SoC_testbench();
	logic  [6:0]	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic    [9:0] LEDR;
	logic      [3:0] KEY;
	logic     [9:0] SW;
	logic     clk;
	
	DE1_SoC dut (.CLOCK_50(clk), .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
	
	
	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	always begin
		#(CLOCK_PERIOD / 2);
		clk = ~clk;
	end 
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin	
									      	@(posedge clk);
											@(posedge clk);
		SW[9]  <= 1; 					 	@(posedge clk);
		SW[9]  <= 0; 					 	@(posedge clk);
		KEY[3] <= 0; 	KEY[0] <= 0;    	@(posedge clk);
		                           			@(posedge clk);
						KEY[0] <= 1;  		@(posedge clk);
											@(posedge clk);
						KEY[0] <= 0;		@(posedge clk);
											@(posedge clk);
						KEY[0] <= 1;  		@(posedge clk);
											@(posedge clk);
						KEY[0] <= 0;		@(posedge clk);
											@(posedge clk);
						KEY[0] <= 1;  		@(posedge clk);
											@(posedge clk);
						KEY[0] <= 0;		@(posedge clk);
											@(posedge clk);
						KEY[0] <= 1;  		@(posedge clk);
											@(posedge clk);
						KEY[0] <= 0;		@(posedge clk);
											@(posedge clk);	
						KEY[0] <= 1;  		@(posedge clk);
											@(posedge clk);
						KEY[0] <= 0;		@(posedge clk);
											@(posedge clk);	
						KEY[0] <= 1;  		@(posedge clk);
											@(posedge clk);
						KEY[0] <= 0;		@(posedge clk);
											@(posedge clk);
						KEY[0] <= 1;		@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
						KEY[0] <= 0;		@(posedge clk);
											@(posedge clk);
						KEY[0] <= 1;		@(posedge clk);
											@(posedge clk);
		KEY[3] <= 1;	KEY[0] <= 0; 		@(posedge clk);
											@(posedge clk);
		KEY[3] <= 0;						@(posedge clk);
		KEY[3] <= 1;              			@(posedge clk);
		KEY[3] <= 0;						@(posedge clk);
		KEY[3] <= 1;              			@(posedge clk);
		KEY[3] <= 0;						@(posedge clk);
		KEY[3] <= 1;              			@(posedge clk);
		KEY[3] <= 0;						@(posedge clk);
		KEY[3] <= 1;              			@(posedge clk);
		KEY[3] <= 0;						@(posedge clk);
		KEY[3] <= 1;              			@(posedge clk);
		KEY[3] <= 0;						@(posedge clk);
		KEY[3] <= 1;              			@(posedge clk);
											@(posedge clk);
		$stop;
	end
endmodule 

