module sign_extender_para
    #(
        parameter 
        INPUT_WIDTH = 8,
        OUTPUT_WIDTH = 16
        )
    (
        input [INPUT_WIDTH-1:0] original,
        output reg [OUTPUT_WIDTH-1:0] sign_extended_original
        );

    wire [OUTPUT_WIDTH-INPUT_WIDTH-1:0] sign_extend;

    generate
        genvar i;
        for (i = 0; i < OUTPUT_WIDTH-INPUT_WIDTH; i = i + 1) begin : gen_sign_extend
            assign sign_extend[i]  = (original[INPUT_WIDTH-1]) ? 1'b1 : 1'b0;
        end
    endgenerate

    always @(*) begin
        sign_extended_original  = {sign_extend,original};
    end

endmodule

module top
    (
        input [7:0] input_8,
        input [15:0] input_16,
        output [15:0] output_8_to_16,
        output [31:0] output_16_to_32
        );

    sign_extender_para #(.INPUT_WIDTH(8), .OUTPUT_WIDTH(16))
        sign_extender_8_16 (.original(input_8), .sign_extended_original(output_8_to_16));
    sign_extender_para #(.INPUT_WIDTH(16), .OUTPUT_WIDTH(32))
        sign_extender_16_32 (.original(input_16), .sign_extended_original(output_16_to_32));

endmodule