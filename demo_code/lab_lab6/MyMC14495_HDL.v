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
      p = ();                             // fill sth in ()
      // Num(0~9, A~F)
      case(`MC14495_NUM)
        4'h0: `MC14495_OUT = 7'b000_0001;
        /* Complete the following code. */
        4'h1: ();
        4'h2: ();
        4'h3: ();
        4'h4: ();
        4'h5: ();
        4'h6: ();
        4'h7: ();
        4'h8: ();
        4'h9: ();
        4'hA: ();
        4'hB: ();
        4'hC: ();
        4'hD: ();
        4'hE: ();
        4'hF: ();
        /* end of your code */
        default: `MC14495_OUT = 7'bxxx_xxxx;
      endcase

    end else begin
      // Print nothing (LE == 1)
      `MC14495_OUT = ();                  // fill sth in ()
      p = ();                             // fill sth in ()
    end

  end

endmodule