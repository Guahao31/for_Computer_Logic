`timescale 1ns/1ps

module top_tb();
/* INPUTS */
  reg clk;
  reg[3:0] BTN_Y;

  /* SW[1:0] to control if the counter for A or B is reversal */
	reg A_Ctrl;
	reg B_Ctrl;
	/* SW[3:2] to choose the mode of the ALU */
	reg [1:0] ALU_Ctrl;
	/* SW[5:4] to choose from A B C and 0 */
	/* 00 for A; 01 for B; 10 for C; 11 for 0 */
	reg [1:0] Trans_select;
  /* SW[15] choose mode */
  /* 0 for ALU mode, 1 for Trans mode */
  reg mode;

  wire[15:0] SW_input;
  assign SW_input = {mode, 9'b0, Trans_select, ALU_Ctrl, B_Ctrl, A_Ctrl};
  //                  15   14~6       5~4         3~2      1        0

/* OUTPUTS */
  wire[3:0] debug_A;
  wire[3:0] debug_B;
  wire[3:0] debug_C;
  wire[3:0] debug_res;

/* INSTANCE */
  Top test_m (.clk(clk), .BTN_Y(BTN_Y), .SW(SW_input), .debug_A(debug_A),
              .debug_B(debug_B), .debug_C(debug_C), .debug_res(debug_res));
  
/* CLOCK */
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  reg[31:0] counter = 0;

  initial begin
    $dumpfile("TOP.vcd");
    $dumpvars(1, top_tb);
    BTN_Y = 4'b0000;
    A_Ctrl = 1'b0;
    B_Ctrl = 1'b0;
    ALU_Ctrl = 2'b00;
    Trans_select = 2'b00;
    mode = 1'b0; // ALU mode
  end

  always @(negedge clk) begin
    // Reset Btns
    #2 BTN_Y = 4'b0000;
  end

  always @(posedge clk) begin
    counter = counter + 32'b1;

    case(counter)

      /* ALU mode, init A & B with 1 and 2 */
      32'd1: begin
        #2 BTN_Y = 4'b0001; // A++
      end

      32'd2, 32'd3, 32'd4: begin
        #2 BTN_Y = 4'b0010; // B++
      end
      // B=3

      32'd5: begin
        B_Ctrl = 1'b1;
      end

      32'd6: begin
        #2 BTN_Y = 4'b0010;
      end
      // B=2

      32'd14: begin
        #2 BTN_Y = 4'b0100; // C = A+B
      end

      32'd15: begin
        ALU_Ctrl = 2'b01;
        #2 BTN_Y = 4'b0100; // C = A-B 
      end

      32'd16: begin
        ALU_Ctrl = 2'b10;
        #2 BTN_Y = 4'b0100; // C = A&B
      end

      32'd17: begin
        ALU_Ctrl = 2'b11;
        // C = 0 as #6 did
      end

      32'd18: begin
        #2 BTN_Y = 4'b0100; // C = A|B (3)
      end

      /* Trans mode, Init A=1, B=2, C=3 */
      32'd30: begin
        mode = 1'b1;
        ALU_Ctrl = 2'b00;
      end

      /* C->A */
      32'd31: begin
        Trans_select = 2'b10;
        #2 BTN_Y = 4'b0001;
      end
      /* A=3, B=2, C=3, res=5 */

      /* 0->B */
      32'd32: begin
        Trans_select = 2'b11;
        #2 BTN_Y = 4'b0010;
      end
      /* A=3, B=0, C=3, res=3 */

      /* C->B */
      32'd33: begin
        Trans_select = 2'b10;
        #2 BTN_Y = 4'b0010;
      end
      /* A=3, B=3, C=3, res=6 */

      /* 0->C */
      32'd34: begin
        Trans_select = 2'b11;
        #2 BTN_Y = 4'b0100;
      end
      /* A=3, B=3, C=0, res=6 */

      /* Change to ALU mode to change value of A */
      32'd40: begin
        mode = 1'b0;
        A_Ctrl = 1'b1;
      end

      /* Change A to F(15) */
      32'd41, 32'd42, 32'd43, 32'd44: begin
        #2 BTN_Y = 4'b0001;
      end
      /* A=15, B=3, C=0, res=2 */

      32'd45: begin
        mode = 1'b1;
      end

      /* C->C */
      32'd50: begin
        Trans_select = 2'b10;
        #2 BTN_Y = 4'b0100;
      end

      /* B->B */
      32'd51: begin
        Trans_select = 2'b01;
        #2 BTN_Y = 4'b0010;
      end

      /* A->A */
      32'd52: begin
        Trans_select = 2'b00;
        #2 BTN_Y = 4'b0001;
      end
      /* A=15, B=3, C=0, res=2 */

      /* B->C */
      32'd53: begin
        Trans_select = 2'b01;
        #2 BTN_Y = 4'b0100;
      end
      /* A=15, B=3, C=3, res=2 */

      /* A->C */
      32'd54: begin
        Trans_select = 2'b00;
        #2 BTN_Y = 4'b0100;
      end
      /* A=15, B=3, C=15, res=2 */

      /* A->B */
      32'd55: begin
        Trans_select = 2'b00;
        #2 BTN_Y = 4'b0010;
      end

      /* A=15, B=15, C=15, res=14 */

      32'd70: begin
        $finish();
      end

      default: begin
        // Clear
        #2 BTN_Y = 4'b0000;
      end
    endcase
  end

endmodule