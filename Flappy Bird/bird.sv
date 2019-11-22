// EE 271
// Lab 6
// Xinyu Gu

// This module determines whether a led light is on or off
// given its location in the led array and the status of leds
// that are above and below it
module bird (clk, reset, active, gameover, press, resetState, uplight, downlight, uplimit, light);

	input logic clk, reset, active, gameover;
	input logic press, resetState, uplight, downlight, uplimit;
	output logic light;
	
	logic [5:0] count = 6'b0;
	logic ps, ns;
	//logic check = 1'b1;
	
	always_comb begin
	
		if (gameover) begin
			ns = ps;
		end
		else begin
			case(ps) 
				1'b0: ns = (press & downlight) | (~press & uplight);
						
				
				1'b1: ns = uplimit & press;
					
			endcase
			
		end

			
	end

	
	assign light = ps;
	
	always_ff @(posedge clk) begin
	
		if (reset | ~active) begin
			ps <= resetState;
			count <= 0;
			
		end 
		else begin 
			if (count == 0) 
				ps <= ns;
				
			count <= count + 1'b1;
			//check = ~check;
			
		end
		
	end

endmodule 

// This module simulates the function of module bird
module bird_testbench();
		logic clk, reset, active, gameover;
		logic press, resetState, uplight, downlight, uplimit;
		logic light;
		
		bird dut (.clk, .reset, .active, .gameover, .resetState, .uplight, .downlight, .uplimit, .light);
		
		parameter CLOCK_PERIOD = 100;
	
		initial clk = 1;
		
		always begin
		
			#(CLOCK_PERIOD / 2) 
			clk = ~clk;
		end
		
		initial begin
		reset <= 1;	active <= 0;
		uplimit <= 0;	gameover <= 0;		uplight <= 0;	downlight <= 0;
						resetState <= 1;								
																@(posedge clk);
						resetState <= 0;								
																@(posedge clk);
						press <= 1;				downlight <= 1;	
																@(posedge clk);
		
						reset <= 0;							@(posedge clk);
						press <= 0;							@(posedge clk);
						press <= 1;							@(posedge clk);
						active <= 1;						@(posedge clk);
						downlight <= 0;					@(posedge clk);
						uplight <= 1;						@(posedge clk);
						press <= 0;							@(posedge clk);
						uplight <= 0;						@(posedge clk);
						downlight <= 1;					@(posedge clk);
													
			uplimit <= 1;	press <= 1;							
																@(posedge clk);
						downlight <= 0;					@(posedge clk);
			gameover <= 1;									@(posedge clk);
						press <= 0;							@(posedge clk);
																@(posedge clk);
		$stop;
	end
endmodule