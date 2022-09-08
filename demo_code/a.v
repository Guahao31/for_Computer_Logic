// reg [255:0] counter;
always @(negedge clk) begin
  counter = counter+1;
end