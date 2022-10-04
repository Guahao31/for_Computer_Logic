/*
Module Name: CreateNumber
Description:
  To change the value printed on Arduino using btns.
  You will get a initial value printed as the para. INIT_HEXES defined.
  After each pression on btn, a number will increase by 1.
*/

module CreateNumber#(
  parameter INIT_HEXES = 16'b1010_1011_1100_1101 // Init with "AbCd"
) (
  input[3:0] btn,
  output reg[15:0] num
);
  wire[3:0] A, B, C, D;

  initial num <= INIT_HEXES;

  assign A = num[ 3: 0] + 4'd1;
  assign B = num[ 7: 4] + 4'd1;
  assign C = num[11: 8] + 4'd1;
  assign D = num[15:12] + 4'd1;

  always @(posedge btn[0]) num[ 3: 0] <= A;
  always @(posedge btn[1]) num[ 7: 4] <= B;
  always @(posedge btn[2]) num[11: 8] <= C;
  always @(posedge btn[3]) num[15:12] <= D;

endmodule