// EE 271 
// Lab 6
// Xinyu Gu

// This module generates seven different 8-bit 'pipe' patterns 
// corresponding to different random numbers result from a 
// 3-bit LFSR
module pipe_generator (clk, reset, active, gameover, index, leds);
	input logic clk, reset, active, gameover;
	input logic [2:0] index;
	output logic [7:0] leds;
	
	logic [8:0] count = 0;
	logic gap = 1'b0;
	logic [7:0] ps, ns;
	
	always_comb begin
		if (gameover)
			ns = leds;
		else
			if (gap == 0)
				case(index)
					3'b000:	ns = 8'b10011111;
					3'b001:	ns = 8'b11001111;
					3'b010:	ns = 8'b11100111;
					3'b011:	ns = 8'b11110011;
					3'b100:	ns = 8'b11111001;
					3'b101:	ns = 8'b11001111;
					3'b110:	ns = 8'b11100111;
					default:	ns = 8'b00000000;
				endcase
			else
				ns = 8'b00000000;
	end
				
	assign leds = ps;
		
	always @(posedge clk)
		if (reset | ~active) begin
			ps <= 8'b00000000;
			count <= 0;
			gap <= 1'b0;
		end
		else begin
			if (count == 0) begin
				ps <= ns;
				gap <= gap + 1'b1;
			end
			count <= count + 1'b1;
		end
endmodule


// This module simulates the function of 
// module pipe_generator
module pipe_generator_testbench();
	logic clk, reset, active, gameover;
	logic [2:0] index;
	logic [7:0] leds;
	
	pipe_generator dut(.clk, .reset, .active, .gameover, .index, .leds);
	
	// Set up the clock
	parameter CLOCK_PERIOD=100;
	initial clk=1;
	always begin
		#(CLOCK_PERIOD/2);
		clk = ~clk;
	end
	
	initial begin
		reset <= 1;	active <= 0;	index <= 3'b010;	@(posedge clk);
		reset <= 0;											@(posedge clk);
						active <= 1;						@(posedge clk);
											index <= 3'b000;	@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
											index <= 3'b001;	@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
											index <= 3'b010;	@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
											index <= 3'b011;	@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
											index <= 3'b100;	@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
											index <= 3'b101;	@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
											index <= 3'b110;	@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
											index <= 3'b111;	@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
						gameover <= 1;		index <= 3'b110;	@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
		$stop;
	end
endmodule