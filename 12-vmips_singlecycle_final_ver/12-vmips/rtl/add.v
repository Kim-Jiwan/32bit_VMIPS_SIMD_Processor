module add (A, B, out);
	parameter [5:0] N = 32;
	input [N-1:0] A, B;
	output reg [N-1:0] out;
	always @(*)
		out = A + B;

endmodule
