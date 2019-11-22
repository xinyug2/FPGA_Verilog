
module DE1_Soc(CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, GPIO_0);

//	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
//	output logic [9:0] LEDR;
//	input logic [3:0] KEY;
//	input logic [9:0] SW;
//	input logic CLOCK_50;
//	output logic [35:0] GPIO_0;
//	
//	assign HEX3 = 7'b1111111;
//	assign HEX4 = 7'b1111111;
//	assign HEX5 = 7'b1111111;
//	
//	logic [31:0] clk0;
//	parameter whichClock = 15;
//	clock_divider cd (CLOCK_50, clk0);
//	
//	logic clk;
//	assign clk = clk0[whichClock];
//	
//	logic reset; 
//	assign reset = SW[9];
//	
//	logic press;
//	logic [7:0][7:0] red_array, green_array;
//	
//	
//	D_FF flop (.clk, .reset, .T(~KEY[0]), .O(press));
//	
//	play #(.WIDTH(8)) P (.clk, .reset, .red_array, .green_array, .press, .HEX0, .HEX1, .HEX2);
//	
//	
//	led_matrix_driver mega (.clock(clk), .red_array, .green_array, .red_driver(GPIO_0[27:20]), .green_driver(GPIO_0[35:28]), .row_sink(GPIO_0[19:12]));
	

input logic CLOCK_50; 
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	output logic [35:0] GPIO_0;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
	assign red_array[7][7:0] = 8'b00000000;
	assign red_array[6][7:0] = 8'b00000000;
	assign red_array[5][7:0] = 8'b00000000;
	assign red_array[4][7:0] = 8'b00000000;
	assign red_array[3][7:0] = 8'b00000000;
	assign red_array[2][7:0] = 8'b00000000;
	assign red_array[1][7:0] = 8'b00000000;
	
	logic on = 1'b1, off = 1'b0;					
	logic reset;
	assign reset = SW[9];
	logic [7:0][7:0] red_array, green_array;
	logic gameOver;
	
	wire [31:0] clk;
	parameter whichClock = 16;
	clock_divider cdiv (CLOCK_50, clk);
	wire dclk;								
	assign dclk = clk[whichClock];
	//assign clk0 = clk[12];
	
	logic in;
	logic active;
	D_FF ui (dclk, reset, ~KEY[0], in);
	activate gs (dclk, reset, in, active);
	
	
	logic [2:0] randomNumber; 
	LFSR r4 (dclk, reset, active, randomNumber);
	
	pipe_generator pip0 (dclk, reset, active, gameOver, randomNumber, green_array[7][7:0]);
	pipeShift pip1 (dclk, reset, active, gameOver, green_array[7][7:0], green_array[6][7:0]);
	pipeShift pip2 (dclk, reset, active, gameOver, green_array[6][7:0], green_array[5][7:0]);
	pipeShift pip3 (dclk, reset, active, gameOver, green_array[5][7:0], green_array[4][7:0]);
	pipeShift pip4 (dclk, reset, active, gameOver, green_array[4][7:0], green_array[3][7:0]);
	pipeShift pip5 (dclk, reset, active, gameOver, green_array[3][7:0], green_array[2][7:0]);
	pipeShift pip6 (dclk, reset, active, gameOver, green_array[2][7:0], green_array[1][7:0]);
	pipeShift pip7 (dclk, reset, active, gameOver, green_array[1][7:0], green_array[0][7:0]);
	
	bird l0 (dclk, reset, active, gameOver, in, off, off, red_array[0][6], on, red_array[0][7]);
	bird l1 (dclk, reset, active, gameOver, in, off, red_array[0][7], red_array[0][5], off, red_array[0][6]);
	bird l2 (dclk, reset, active, gameOver, in, off, red_array[0][6], red_array[0][4], off, red_array[0][5]);
	bird l3 (dclk, reset, active, gameOver, in, on, red_array[0][5], red_array[0][3], off, red_array[0][4]);
	bird l4 (dclk, reset, active, gameOver, in, off, red_array[0][4], red_array[0][2], off, red_array[0][3]);
	bird l5 (dclk, reset, active, gameOver, in, off, red_array[0][3], red_array[0][1], off, red_array[0][2]);
	bird l6 (dclk, reset, active, gameOver, in, off, red_array[0][2], red_array[0][0], off, red_array[0][1]);
	bird l7 (dclk, reset, active, gameOver, in, off, red_array[0][1], off, off, red_array[0][0]);
	
	led_matrix_driver mDriver (dclk, red_array, green_array, GPIO_0[27:20], GPIO_0[35:28], GPIO_0[19:12]);
	
	logic extraPoint;
	crash stat (dclk, reset, active, red_array[0], green_array[0], gameOver, extraPoint);
	
	logic pp0, pp1, pp2;
	hex d0(dclk, reset, active, 7'b1000000, extraPoint, HEX0, pp0);
	hex d1(dclk, reset, active, 7'b1111111, pp0, HEX1, pp1);
	hex d2(dclk, reset, active, 7'b1111111, pp1, HEX2, pp2);
endmodule 

module DE1_Soc_testbench();

	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic [35:0] GPIO_0;
	logic CLOCK_50;
	
	DE1_Soc dut (.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW, .GPIO_0);
	
	parameter CLOCK_PERIOD = 100;
	initial CLOCK_50 = 1;
	always begin 
		#(CLOCK_PERIOD / 2);
		CLOCK_50 = ~CLOCK_50;
	end
	
	initial begin	
						      	@(posedge CLOCK_50);
		KEY[0] <= 1;
		SW[8:0]  <= 9'b00000111;
									@(posedge CLOCK_50);
		SW[9]  <= 1; 		 	@(posedge CLOCK_50);
		SW[9]  <= 0; 		 	@(posedge CLOCK_50);
			@(posedge CLOCK_50);
		KEY[0] <= 1;
		
		repeat (50)		   @(posedge CLOCK_50);
	end
	
		
	
endmodule