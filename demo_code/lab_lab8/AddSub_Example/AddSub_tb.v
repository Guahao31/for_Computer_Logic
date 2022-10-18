`timescale 1ps/1ps

module AddSub_tb();
  reg[7:0] A;
  reg[7:0] B;
  reg Ctrl;

  wire[7:0] S;
  wire Co;

  AddSub #(.WIDTH(8))
    m0 (.A(A), .B(B), .Ctrl(Ctrl), .S(S), .Co(Co));

  initial begin
    $dumpfile("AddSub.vcd");
    $dumpvars(1, AddSub_tb);

    A = 0; B = 0; Ctrl = 0;
    #10 A = 8'b0000_0010; B = 8'b0000_0100;
    #10 A = 8'b1000_0001; B = 8'b0111_1111;
    #10 Ctrl = 1;
    #10 A = 8'b0010_0000; B = 8'b0000_1100;
    #10 A = 8'b0000_0001; B = 8'b1111_1111;
    #10;
  end

endmodule