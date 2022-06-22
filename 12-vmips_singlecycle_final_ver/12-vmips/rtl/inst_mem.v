module inst_mem(current_pc, clk, rst, current_ins);
	input [31:0] current_pc;
	input clk, rst;
	output [31:0] current_ins;

	integer i;
	reg [31:0] internal_mem [31:0];

	initial #10
	  $readmemb("instructionfile.txt", internal_mem);

	always @(posedge clk) begin
		if(~rst) begin
				for(i=0; i<32; i=i+1)
					internal_mem[i] <= 32'b0;
				end
	end

	assign current_ins =  internal_mem[current_pc];

endmodule
