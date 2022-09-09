initial begin
    // $dumpfile("demo1_tb.vcd");
    // $dumpvars(0, demo1_tb);

    in = 8'b0000_0000;
    #10; in = 8'b1000_0001;
    #10; in = 8'b0000_0001;
    // Other tests
    #10;
end