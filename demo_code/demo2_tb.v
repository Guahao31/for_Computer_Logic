`timescale 1ns/1ps

module demo2_tb;
reg [7:0] in_8;
reg [15:0] in_16;
wire[15:0] out_8_16;
wire[31:0] out_16_32;

top m0(in_8, in_16, out_8_16, out_16_32);

initial begin
    $dumpfile("demo2_tb.vcd");
    $dumpvars(0, demo2_tb);

    in_8 = 8'b0000_0000; in_16 = 16'h0000;
    #10; in_8 = 8'b1000_0001; in_16 = 16'h7007;
    #10; in_8 = 8'b0000_0001; in_16 = 16'h0001;
    #10; in_8 = 8'b1111_1111; in_16 = 16'hFFFF;
    #10; in_8 = 8'b1100_0011; in_16 = 16'hC00C;
    #10; in_8 = 8'b0100_0010; in_16 = 16'h4004;
    #10;
end
endmodule