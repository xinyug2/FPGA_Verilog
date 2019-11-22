// EE 271
// Lab 5
// Xinyu Gu

// This module takes in two 10-bit input
// A and B, it outputs 1 if A is greater 
// than B
module CyberPlayer(A, B, out);

	//input logic clk, reset;
	input logic [9:0] A, B;
	output logic out;
	//logic temp;
	
	

	always_comb begin
		out = A > B;
	end
			
endmodule 


// This module simulates the function 
// of module CyberPlayer
module CyberPlayer_testbench();

	logic [9:0] A, B;
	logic out;
	
	CyberPlayer dut (.A, .B, .out);
	
	
	integer j = 0;
	initial begin 
		A = 10'b0011011010;
		for (j = 0; j < 2**10; j++) begin
		
			B = j; #10;
		end
	end
	
endmodule

