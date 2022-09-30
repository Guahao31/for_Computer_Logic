`timescale 1ns / 1ps

module MyMC14495_tb();

// Inputs
  reg D0;
  reg D1;
  reg D2;
  reg D3;
  reg LE;
  reg point;

// Output
  wire p;
  wire a;
  wire b;
  wire c;
  wire d;
  wire e;
  wire f;
  wire g;

// Instantiate the UUT
  MyMC14495 UUT (
  .D0(D0), 
  .D1(D1), 
  .D2(D2), 
  .D3(D3), 
  .LE(LE), 
  .point(point), 
  .p(p), 
  .a(a), 
  .b(b), 
  .c(c), 
  .d(d), 
  .e(e), 
  .f(f), 
  .g(g)
  );
// Initialize Inputs
  integer i;
  initial begin
    D3 = 0;
    D2 = 0;
    D1 = 0;
    D0 = 0;
    LE = 0;
    point = 0;
    
    for (i=0; i<=15;i=i+1) begin
      #50;
      {D3,D2,D1,D0}=i;
      point = i;
    end
      
    #50;
    LE = 1;
  end
endmodule
