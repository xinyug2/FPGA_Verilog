// EE 271
// Lab 5
// Xinyu Gu

// This module takes 4 inputs that include a clock for
// timing the posedge change, a reset for reset and two
// user inputs. SW9 is used for reset, KEY0 and KEY1 
// are used for user inputs
// This module displays the current status of the game
// through a 9-LED light pattern on LEDR8 to LEDR0 as 
// well as the current score between a cyber player and 
// a human player on HEX0 and HEX5.


module DE1_SoC (CLOCK_50, HEX0, HEX1,HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);

	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	input logic CLOCK_50;
	
	logic L, R;
	logic temp;
	logic [9:0] cyber;
	logic [31:0] clk;
	parameter clock = 15;
	
	clock_divider cd (CLOCK_50, clk);
	// clk[clock]
	
	LFSR ran (.clk(clk[clock]), .reset(SW[9]), .out(cyber));
	
	CyberPlayer C (.A({1'b0, SW[8:0]}), .B(cyber), .out(temp));
	D_FF flopL (.clk(clk[clock]), .reset(SW[9]), .T(temp), .O(L));
	D_FF flopR (.clk(clk[clock]), .reset(SW[9]), .T(~KEY[0]), .O(R));
	
	
	Play P1 (.clk(clk[clock]), .reset(SW[9]), .L(L), .R(R), .LEDR(LEDR[8:0]), .D1(HEX5), .D2(HEX0));
	
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	//assign HEX5 = 7'b1111111;
	
endmodule
	
//This module tests the functions of module DE1_SoC
// through simulation 
module DE1_SoC_testbench();
	logic  [6:0]	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic    [9:0] LEDR;
	logic      [3:0] KEY;
	logic     [9:0] SW;
	logic     CLOCK_50;
	
	
	
	DE1_SoC dut (.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
	
	
	parameter CLOCK_PERIOD = 100;
	initial CLOCK_50 = 1;
	always begin
		#(CLOCK_PERIOD / 2);
		CLOCK_50 = ~CLOCK_50;
	end 
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin	
						      	@(posedge CLOCK_50);
		KEY[0] <= 1;
		SW[8:0]  <= 9'b00000111;
									@(posedge CLOCK_50);
		SW[9]  <= 1; 		 	@(posedge CLOCK_50);
		SW[9]  <= 0; 		 	@(posedge CLOCK_50);
			@(posedge CLOCK_50);
		repeat (50)		   @(posedge CLOCK_50);
	
//								@(posedge clk);
//								@(posedge clk);
//		KEY[0] <= 0;   		 	@(posedge clk);
//		                    	@(posedge clk);
//		KEY[0] <= 1;  			@(posedge clk);
//								@(posedge clk);
//		KEY[0] <= 0;			@(posedge clk);
//								@(posedge clk);
//		KEY[0] <= 1;  			@(posedge clk);
//								@(posedge clk);
//		KEY[0] <= 0;			@(posedge clk);
//								@(posedge clk);
//		KEY[0] <= 1;  			@(posedge clk);
//								@(posedge clk);
//		KEY[0] <= 0;			@(posedge clk);
//								@(posedge clk);
//		KEY[0] <= 1;  			@(posedge clk);
//								@(posedge clk);
//		KEY[0] <= 0;			@(posedge clk);
//								@(posedge clk);	
//		KEY[0] <= 1;  			@(posedge clk);
//								@(posedge clk);
//		KEY[0] <= 0;			@(posedge clk);
//								@(posedge clk);	
//		KEY[0] <= 1;  			@(posedge clk);
//								@(posedge clk);
//		KEY[0] <= 0;			@(posedge clk);
//								@(posedge clk);
//		KEY[0] <= 1;			@(posedge clk);
//								@(posedge clk);
//								@(posedge clk);
//								@(posedge clk);
//								@(posedge clk);
//		KEY[0] <= 0;			@(posedge clk);
//								@(posedge clk);
//		KEY[0] <= 1;			@(posedge clk);
//								@(posedge clk);
//		KEY[0] <= 0; 			@(posedge clk);
		$stop;
	end
endmodule 

