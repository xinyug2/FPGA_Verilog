// EE 217
// Lab 4
// Xinyu Gu


// This module takes in three inputs that 
// include a clock for timing the posedge
// change, a reset for reset and an input 
// that needs to be properly corrected 
// This module propers and outputs a corrected
// input to present the exact time of input 
// and to avoid metastability
module D_FF(clk,reset, T, O);


	input logic clk;   
	input logic reset;  
	input logic T;
	output logic O;
	
	logic temp;
	
	logic ns, ps;
	parameter on = 1'b1, off = 1'b0;

	always_comb begin
		case (O)
			on:  
			begin
				ns = off;
			end 
			
			off:
			begin
				if(T == on & T != ps)
					ns = on;
				else
					ns = off;
			end
			default: ns = off;
		endcase
	end
	
    // DFFs
    always @(posedge clk)
    	if (reset)
    	begin
			O <= off;
			ps <= off;
		end
        else 
        begin
		   temp <= ns; 
        	O <= temp;
        	ps <= T;
        end

	
endmodule

// This module tests the function of module
// D_FF through simulations
module D_FF_testbench ();
	logic clk;
	logic reset;
	logic T;
	logic O;

	D_FF dut (.clk, .reset, .T, .O);
	
	// Set up the clock
	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	always begin
		#(CLOCK_PERIOD / 2);
		clk = ~clk;
	end 

	
	initial begin	
									@(posedge clk);
									@(posedge clk);
		reset <= 1;					@(posedge clk);
		reset <= 0; T <= 1;   	@(posedge clk);
                           			@(posedge clk);
                           			@(posedge clk);
                           			@(posedge clk);
                    T <= 0;    @(posedge clk);
                    @(posedge clk);
                    T <= 1; @(posedge clk);
                    @(posedge clk);
                    @(posedge clk);
                    @(posedge clk);
                    @(posedge clk);
                    @(posedge clk);
                    T <= 0; @(posedge clk);
                    @(posedge clk);
	$stop;
	end

endmodule

