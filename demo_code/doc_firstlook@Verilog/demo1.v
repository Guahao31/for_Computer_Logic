module sign_extender
    (
        input [7:0] original,
        output [15:0] sign_extended_original
    );

    assign sign_extended_original = {{8{original[7]}}, original[7:0]};

endmodule