// EE 271
// Lab 6
// Xinyu Gu

// This module displays the score of the game
module hex (clk, reset, active, dv, increment, display, cycle);

	input logic clk, reset, active, increment;
	input logic [6:0] dv;
	output logic cycle;
	output [6:0] display;
	
	logic [6:0] ps, ns;
	
	
	parameter	zero	= 7'b1000000,
					one	= 7'b1111001,
					two	= 7'b0100100,
					three	= 7'b0110000,
					four	= 7'b0011001,
					five	= 7'b0010010,
					six	= 7'b0000010,
					seven	= 7'b1111000,
					eight	= 7'b0000000,
					nine	= 7'b0010000;
				 
				 
	always_comb begin
		if(increment)
			case(ps)
				zero:		ns = one;
				one:		ns = two;
				two:		ns = three;
				three:	ns = four;
				four:		ns = five;
				five:		ns = six;
				six:		ns = seven;
				seven:	ns = eight;
				eight:	ns = nine;
				nine:		ns = zero;
				default:	ns = one;
			endcase
		else
			ns = ps;
			
	end 
	
	assign display = ps;
	assign cycle = (ps == nine) & increment;
	
	always_ff @(posedge clk) begin
		if (reset | ~active) 
			ps <= dv;
		else 
			ps <= ns;
	end
	
endmodule 

// This module simulates the function of module hex

module hex_testbench();

	logic clk, reset, active, increment;
	logic [6:0] dv;
	logic [6:0] display;
	logic cycle;
	
	hex dut (.clk, .reset, .active, .dv, .increment, .display, .cycle);
	
	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	
	always begin
	
		#(CLOCK_PERIOD / 2);
		clk = ~clk;
	end
	
	
	initial begin
		
		reset <= 1;	active <= 0;	
				dv <= 7'b1111111;	increment <= 1;	
														@(posedge clk);
				dv <= 7'b0000000;					@(posedge clk);
		      reset <= 0;							@(posedge clk);
				active <= 1;						@(posedge clk);
										increment <= 0;	
														@(posedge clk);
										increment <= 1;	
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
										increment <= 0;	
														@(posedge clk);
										increment <= 1;	
														@(posedge clk);
														@(posedge clk);
		$stop;
	end
endmodule
	
	