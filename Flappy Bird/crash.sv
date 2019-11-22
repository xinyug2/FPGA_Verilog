
module crash (clk, reset, active, bird, pipe, crashed, addPoint);

	input logic clk, reset, active;
	input logic [7:0] bird, pipe;
	output logic crashed, addPoint;
	
	logic ps, ns;
	logic [7:0] pp, np;
	
	always_comb begin
	
		ns = bird[0] | (bird[7] & pipe[7]) 
						 | (bird[6] & pipe[6])
						 | (bird[5] & pipe[5])
						 | (bird[4] & pipe[4])
						 | (bird[3] & pipe[3])
						 | (bird[2] & pipe[2])
						 | (bird[1] & pipe[1]);
						 
		np = pipe;
		
	end 
	
	assign crashed = ps;
	assign addPoint = ~(pp == 8'b00000000) & (pipe == 8'b00000000);
	
	always_ff @(posedge clk) begin 
		if (reset | ~active) begin
			ps <= 1'b0;
			pp <= 8'b00000000;
		end
		else begin
			ps <= ns;
			pp <= np;
		end
	end

endmodule 

module crash_testbench();

		logic clk, reset, active;
		logic [7:0] bird, pipe;
		logic crashed, addPoint;
		
		crash dut (.clk, .reset, .active, .bird, .pipe, .crashed, .addPoint);
		
		parameter CLOCK_PERIOD = 100;
		initial clk = 1;
		always begin
			#(CLOCK_PERIOD / 2)
			clk = ~clk;
		end
		
		initial begin
		reset <= 1; active <= 0;
			bird <= 8'b00010000;	pipe <= 8'b1111111; 	@(posedge clk);
		reset <= 0;														@(posedge clk);
						active <= 1;									@(posedge clk);
											pipe <= 8'b11001111;	@(posedge clk);
											pipe <= 8'b00000000;	@(posedge clk);
											pipe <= 8'b11111001;	@(posedge clk);
			bird <= 8'b00000001;									@(posedge clk);
		reset <= 1;														@(posedge clk);
																			@(posedge clk);
		$stop;
	end
endmodule
						 
						