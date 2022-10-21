`timescale 1ns / 1ps

module     LEDP2S(input wire clk,						//parallel to serial
						input wire rst,
						input wire Start,
						input wire[DATA_BITS-1:0] PData,	// data to print
						output wire sclk,									// output
						output wire sclrn,
						output wire sout,									// one bit at a time
						output reg  EN
						);
						
parameter
	DATA_BITS = 16,  											// data length
	DATA_COUNT_BITS = 4,										// data shift bits
	DIR = 0;														// Shift direction =0
		
endmodule
