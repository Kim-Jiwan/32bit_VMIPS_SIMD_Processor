module mux3 (i0, i1, i2, sel, y);
  parameter [5:0] N = 32;
  input [N-1:0] i0, i1, i2;
  input [1:0] sel;
  output reg [N-1:0] y;
  always @(*) begin
    case(sel)
      2'b00: y=i0;
      2'b01: y=i1;
      2'b10: y=i2;
	  default y=0;
    endcase
  end

endmodule
