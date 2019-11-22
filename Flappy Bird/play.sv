
module play #(parameter WIDTH = 8) (clk, reset, red_array, green_array, press, HEX0, HEX1, HEX2);

	input logic clk, reset, press;
	output logic [7:0][7:0] red_array, green_array;
	output logic [6:0] HEX0, HEX1, HEX2;
	logic gameover;
	logic active;
	logic addPoint;
	logic [2:0] randNum;
	
	parameter on = 1'b1, off = 1'b0;
	
	
	activate A (.clk, .reset, .press, .active);
	
//	bird b1 (.clk, .reset, .active, .gameover, .press, .resetState(on), .uplight(off), .downlight(red_array[0][6]), .uplimit(on), .light(red_array[0][7]));
//	genvar i;
//	generate 
//		for (i = WIDTH - 1; i >= 2 ; i--) begin: birdControl
//			bird B (.clk, .reset, .active, .gameover, .press, .resetState(off), .uplight(red_array[0][i]), .downlight(red_array[0][i - 2]), .uplimit(on), .light(red_array[0][i - 1]));
//		end
//	endgenerate 
//	bird b8 (.clk, .reset, .active, .gameover, .press, .resetState(off), .uplight(red_array[0][1]), .downlight(off), .uplimit(off), .light(red_array[0][0]));
//	

	bird l0 (clk, reset, active, gameover, press, off, off, red_array[0][6], on, red_array[0][7]);
	bird l1 (clk, reset, active, gameover, press, off, red_array[0][7], red_array[0][5], off, red_array[0][6]);
	bird l2 (clk, reset, active, gameover, press, off, red_array[0][6], red_array[0][4], off, red_array[0][5]);
	bird l3 (clk, reset, active, gameover, press, on, red_array[0][5], red_array[0][3], off, red_array[0][4]);
	bird l4 (clk, reset, active, gameover, press, off, red_array[0][4], red_array[0][2], off, red_array[0][3]);
	bird l5 (clk, reset, active, gameover, press, off, red_array[0][3], red_array[0][1], off, red_array[0][2]);
	bird l6 (clk, reset, active, gameover, press, off, red_array[0][2], red_array[0][0], off, red_array[0][1]);
	bird l7 (clk, reset, active, gameover, press, off, red_array[0][1], off, off, red_array[0][0]);
	
	
	assign red_array[7][7:0] = 8'b00000000;
	assign red_array[6][7:0] = 8'b00000000;
	assign red_array[5][7:0] = 8'b00000000;
	assign red_array[4][7:0] = 8'b00000000;
	assign red_array[3][7:0] = 8'b00000000;
	assign red_array[2][7:0] = 8'b00000000;
	assign red_array[1][7:0] = 8'b00000000;
	
	LFSR random (.clk, .reset, .out(randNum));
	
//	pipe_generator pip0 (.clk, .reset, .active, .gameover, .index(randNum), .leds(green_array[7][7:0]));
//	generate 
//		for (i = WIDTH - 1; i >= 1; i--) begin: pipeControl
//			pipeShift P (.clk, .reset, .active, .gameover, .newPattern(green_array[i][7:0]), .pipe(green_array[i-1][7:0]));
//		end
//		
//	endgenerate 

	pipe_generator pip0 (clk, reset, active, gameover, randomNumber, green_array[7][7:0]);
	pipeShift pip1 (clk, reset, active, gameover, green_array[7][7:0], green_array[6][7:0]);
	pipeShift pip2 (clk, reset, active, gameover, green_array[6][7:0], green_array[5][7:0]);
	pipeShift pip3 (clk, reset, active, gameover, green_array[5][7:0], green_array[4][7:0]);
	pipeShift pip4 (clk, reset, active, gameover, green_array[4][7:0], green_array[3][7:0]);
	pipeShift pip5 (clk, reset, active, gameover, green_array[3][7:0], green_array[2][7:0]);
	pipeShift pip6 (clk, reset, active, gameover, green_array[2][7:0], green_array[1][7:0]);
	pipeShift pip7 (clk, reset, active, gameover, green_array[1][7:0], green_array[0][7:0]);
	
	
	crash C (.clk, .reset, .active, .bird(red_array[0]), .pipe(green_array[0]), .crashed(gameover), .addPoint);
	
	logic c0, c1, c2;
	
	hex d0 (.clk, .reset, .active, .dv(7'b1000000), .increment(addPoint), .display(HEX0), .cycle(c0));
	hex d1 (.clk, .reset, .active, .dv(7'b1111111), .increment(c0), .display(HEX1), .cycle(c1));
	hex d2 (.clk, .reset, .active, .dv(7'b1111111), .increment(c1), .display(HEX2), .cycle(c2));

endmodule 

module play_testbench();

	logic clk, reset, press;
	logic [7:0][7:0] red_array, green_array;
	logic [6:0] HEX0, HEX1, HEX2;
	
	play dut (.clk, .reset, .red_array, .green_array, .press, .HEX0, .HEX1, .HEX2);
	
	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	always begin 
		#(CLOCK_PERIOD / 2);
		clk = ~clk;
	end
	
	initial begin
		reset <= 1;	press <= 1;	@(posedge clk);
						press <= 0;	@(posedge clk);
		reset <= 0;						@(posedge clk);
						press <= 1;	@(posedge clk);
											@(posedge clk);
						press <= 0;	@(posedge clk);
						press <= 1;	@(posedge clk);
						press <= 0;	@(posedge clk);
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
	
		
	
	
	