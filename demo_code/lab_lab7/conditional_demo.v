module dispsync(
  input   [15:0] Hexs,		//端口变量说明与定义合并
  input   [1:0] Scan,
  input   [3:0] Point,
  input   [3:0] Les,
  output  [3:0] Hex,
  output  p,LE,
  output  [3:0] AN
);

  assign Hex =  (2'b00 == Scan) ? Hexs[3:0] :
                (2'b01 == Scan) ? Hexs[7:4] :
                (2'b10 == Scan) ? Hexs[11:8]:
                (2'b11 == Scan) ? Hexs[15:12]:
                4'bxxxx;
  
  assign AN =   (2'b00 == Scan) ? 4'b1110 :
                (2'b01 == Scan) ? 4'b1101 :
                (2'b10 == Scan) ? 4'b1011:
                (2'b11 == Scan) ? 4'b0111:
                4'bxxxx;
  
  // Similar to above for p & LE
  
endmodule
