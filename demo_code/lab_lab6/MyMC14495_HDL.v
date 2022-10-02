`timescale 1ns/1ps

module MyMC14495_HDL(
  input D0, D1, D2, D3,
  input LE,
  input point,
  output reg p,
  output reg a, b, c, d, e, f, g
);

  `define MC14495_NUM {D3, D2, D1, D0}
  `define MC14495_OUT {a, b, c, d, e, f, g}

  always@(*) begin
    if(1'b0 == LE) begin
      /* Able to print */
      // Point
      p = point;
      // Num(0~9, A~F)
      case(`MC14495_NUM)
        4'h0: `MC14495_OUT = 7'b000_0001;
        4'h1: `MC14495_OUT = 7'b100_1111;
        4'h2: `MC14495_OUT = 7'b001_0010;
        4'h3: `MC14495_OUT = 7'b000_0110;
        4'h4: `MC14495_OUT = 7'b100_1100;
        4'h5: `MC14495_OUT = 7'b010_0100;
        4'h6: `MC14495_OUT = 7'b010_0000;
        4'h7: `MC14495_OUT = 7'b000_1111;
        4'h8: `MC14495_OUT = 7'b000_0000;
        4'h9: `MC14495_OUT = 7'b000_0100;
        4'hA: `MC14495_OUT = 7'b000_1000;
        4'hB: `MC14495_OUT = 7'b110_0000;
        4'hC: `MC14495_OUT = 7'b011_0001;
        4'hD: `MC14495_OUT = 7'b100_0010;
        4'hE: `MC14495_OUT = 7'b011_0000;
        4'hF: `MC14495_OUT = 7'b011_1000;
        default: `MC14495_OUT = 7'bxxx_xxxx;
      endcase

    end else begin
      // Print nothing (LE == 1)
      `MC14495_OUT = 7'b111_1111;
      p = 1'b1;
    end

  end

endmodule