
// EE 271
// Xinyu Gu
// Lab 3


// This module takes in two inputs that indicates
// the wind direction and output lights pattern 
// corresponding wind direction. 
module 	seaTacLight (CLOCK_50, SW, LEDR, reset);
    input logic CLOCK_50, reset;
    input logic [1:0] SW;
    output logic [2:0] LEDR;
	 logic [31:0] clk;

    logic [2:0] ps; 
    logic [2:0] ns;

    // States and Output encoding
    parameter [2:0] M = 3'b010;
						  

    // Next State logic
	 // M >> 1 = 001, M << 1 = 100, M = 010, ~M = 101
    always_comb begin
        case (ps)
            ~M:     if      (~SW[1] & ~SW[0]) ns = M;     // 00
                    else if (~SW[1] & SW[0])  ns = M >> 1;     // 01
                    else   ns = M << 1;     // 10                  
            
				M >> 1:      if      (~SW[1] & ~SW[0]) ns = ~M;  
                    else if (~SW[1] & SW[0])  ns = M;     
                    else   ns = M << 1;         
            
				M:      if      (~SW[1] & ~SW[0]) ns = ~M;  
                    else if (~SW[1] & SW[0])  ns = M << 1;     
                    else  ns = M >> 1;     
            
				M << 1:      if      (~SW[1] & ~SW[0]) ns = ~M;  
                    else if (~SW[1] & SW[0])  ns = M >> 1;     
                    else ns = M;     
                    
            default:    ns = ~M;
        endcase
	 end
	 

    // Output logic
    assign LEDR = ps;
	 

    // DFFs
    always_ff @(posedge CLOCK_50) begin
		if (reset)
         ps <= M; 
		else 
			ps <= ns;
	end 

endmodule

// Alternative method
//module 	seaTacLight (CLOCK_50, SW, LEDR, reset);
//    input logic CLOCK_50, reset;
//    input logic [1:0] SW;
//    output logic [2:0] LEDR;
//	 //logic [31:0] clk;
//
//    logic [2:0] ps; 
//    logic [2:0] ns;
//
//    // States and Output encoding
////    para3'b010eter [2:0] nil = 3'bxxx,
////                    3'b010 = 3'b010;
//						  
//
//    // Next State logic
//    always_comb begin
//        case (ps)
//            3'b101:     if      (~SW[1] & ~SW[0]) ns = 3'b010;     // 00
//                    else if (~SW[1] & SW[0])  ns = 3'b001;     // 01 
//                    else   ns = 3'b100;     // 10
//                    //else                      ns = nil;
//            3'b001:      if      (~SW[1] & ~SW[0]) ns = 3'b101;  
//                    else if (~SW[1] & SW[0])  ns = 3'b010;     // 01 again, to 3'b010
//                    else   ns = 3'b100;     // 10 again, back to L
//                    //else                      ns = nil;
//            3'b010:      if      (~SW[1] & ~SW[0]) ns = 3'b101;  
//                    else if (~SW[1] & SW[0])  ns = 3'b100;     
//                    else  ns = 3'b001;     // 10 again, to R
//                    //else                      ns = nil;
//            3'b100:      if      (~SW[1] & ~SW[0]) ns = 3'b101;  
//                    else if (~SW[1] & SW[0])  ns = 3'b001;     
//                    else ns = 3'b010;     
//                    //else                      ns = nil;
//            default:    ns = 3'b101;
//        endcase
//	 end
//	 
//
//    // Output logic
//    assign LEDR = ps;
//	 
//
//
//    // DFFs
//    always_ff @(posedge CLOCK_50) begin
//		if (reset)
//         ps <= 3'b010; 
//		else 
//			ps <= ns;
//	end 
//
//endmodule


// This module simulates the function of 
// module seaTacLight
module seaTacLight_testbench();
	logic clk;
	logic [1:0] SW;
	logic [2:0] LEDR;
	logic reset;
	
	//seaTacLight dut (.clk, .reset, .SW, .inputLED);
	seaTacLight dut (.CLOCK_50(clk), .SW, .LEDR, .reset);
	// Set up the clock
	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	always begin
		#(CLOCK_PERIOD / 2);
		clk = ~clk;
	end 
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin	
		reset = 1'b1;
									      @(posedge clk);
		reset = 1'b0;
											@(posedge clk);
		SW[1] <= 0; SW[0] <= 0;    @(posedge clk);
		                           @(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);									
		SW[1] <= 0; SW[0] <= 1;    @(posedge clk);
		                           @(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
		SW[1] <= 1; SW[0] <= 0;    @(posedge clk);
		                           @(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
		SW[1] <= 1; SW[0] <= 1;    @(posedge clk);
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


