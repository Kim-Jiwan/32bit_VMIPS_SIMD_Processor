module alu(input [31:0] in1, in2, input [2:0] alu_ctrl, output reg [31:0] z);

	always @(*)begin
	   case(alu_ctrl)
		 	3'b000: z = in1 + in2;
		 	3'b001: z = in1 - in2;
		 	3'b010: z = in1 & in2;
		 	3'b011: z = in1 | in2;
		 	3'b100: z = (in1 < in2) ? 32'd1:32'd0;
		 	3'b101: z = in1 * in2;
		 	3'b110: z = 32'd0;
			default : z = 32'hxxxxxxxx;
		endcase
	end

endmodule
