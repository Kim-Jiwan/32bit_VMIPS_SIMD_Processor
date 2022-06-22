module pc(next_pc, clk, rst, current_pc);
	input [31:0] next_pc;
	input clk, rst;
	output reg [31:0] current_pc;
	
	always @(posedge clk) begin
		if(~rst)
			current_pc <= 32'b0;
		else
			current_pc <= next_pc;
	end
endmodule