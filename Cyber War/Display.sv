// EE 271
// Lab 5
// Xinyu Gu

// This module returns a 7-bit output represents 
// a decimal number between 0 and 7 corresponding to 
// a given 3-bit input 
module Display(in, out);

	input logic [2:0] in;
	output logic [6:0] out;
	
	
	always_comb begin
		
		case(in)
		
			3'b000: out = 7'b1000000;
			3'b001: out = 7'b1111001;
			3'b010: out = 7'b0100100;
			3'b011: out = 7'b0110000;
			3'b100: out = 7'b0011001;
			3'b101: out = 7'b0010010;
			3'b110: out = 7'b0000010;
			3'b111: out = 7'b1111000;
			default: out = 7'b1000000;
		endcase
	end
	
endmodule

// This module simulates the function of 
// module Display
module Display_testbench();

	logic [2:0] in;
	logic [6:0] out;
	
	Display dut (.in, .out);
	
	integer i = 0;
	initial begin 
		for (i = 0; i < 2**3; i++) begin
			in = i; #10;
		end
	end
	
endmodule 
	