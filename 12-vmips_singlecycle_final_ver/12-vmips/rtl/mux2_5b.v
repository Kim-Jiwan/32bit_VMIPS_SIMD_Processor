module mux2_5b (i0, i1, sel, y);
  parameter [2:0] N = 5;
  input [N-1:0] i0, i1;
  input sel;
  output reg [N-1:0]  y;
  always @(*) begin
    case(sel)
      1'b0: y=i0;
      1'b1: y=i1;
    endcase
  end

endmodule
