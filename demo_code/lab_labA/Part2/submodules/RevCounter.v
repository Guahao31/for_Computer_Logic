`timescale 1ns / 1ps

/** module RevCounter
  * input
	* 	clk_1s: A clock signal driven by module clk_1s.
	*		s: 1 for increment, 0 for decrement
	* output
	* 	cnt: a 16-bits register
	* 	Rc: when the counter reset(i.e. carry will be set), Rc becomes 1
	* 			increment(s=1 & cnt=F) or decrement(s=0, cnt=0)
 */

//! NOTE: DO NOT CHANGE THE MODULE NAME & PORT NAMES
module RevCounter( 
	input wire clk,
	input wire s,
	output reg [15:0] cnt=0,
	output wire Rc
);
	 
	/* Your code here */


endmodule
