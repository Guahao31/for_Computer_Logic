always @(posedge clk) begin
  // a初始值为1,b初始值为0
  a <= b;
  b <= a;
  // 结束时，a=0, b=1
end