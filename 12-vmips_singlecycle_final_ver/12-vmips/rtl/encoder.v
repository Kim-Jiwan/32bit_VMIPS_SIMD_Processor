module encoder(x, y, z, w, enc_sig, data);
	input  		 [31:0]		x, y, z, w;
	input 		 			    enc_sig;
	output reg [127:0]	data;
	wire 			 [31:0]		sum;

	assign sum = x + y + z + w;

	always @(*)begin
		case(enc_sig)
			1'b0		: data = {w, z, y, x};
			//1'b1		: data = {96'd0, {w + z + y + x}};
			1'b1		: data = {96'd0, sum};
		endcase
	end

endmodule
