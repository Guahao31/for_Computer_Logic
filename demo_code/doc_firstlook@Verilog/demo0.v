module reverse (
    input [1:0] in,
    output [1:0] out
);

    assign out = {in[0], in[1]};
    
endmodule