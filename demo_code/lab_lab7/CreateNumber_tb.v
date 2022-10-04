`timescale 1ns/1ns

module CreateNumber_tb();

  reg[3:0] btn;
  wire[15:0] num;

  CreateNumber m0(.btn(btn), .num(num));

  initial begin
    $dumpfile("CreateNumber.vcd");
    $dumpvars(1, CreateNumber_tb);

    #50;
    // Simulate pressing one btn
    #5 btn = 4'b1000;
    #5 btn = 4'b0100;
    #5 btn = 4'b0010;
    #5 btn = 4'b0001;

    // No botton pressed
    #5 btn = 4'b0000;

    // Press two bottons at a time
    #5 btn = 4'b1010;

    #50;
  end

endmodule