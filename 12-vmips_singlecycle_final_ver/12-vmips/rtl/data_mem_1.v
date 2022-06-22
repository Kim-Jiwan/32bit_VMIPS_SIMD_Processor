module data_mem_1(datamem_addr, datamem_data, clk, rst, we, re, readData);
	input [31:0] datamem_addr, datamem_data;
	input clk, rst, we, re;
	output [31:0] readData;

	integer i;
	reg [31:0] internal_mem [0:127];

	initial #10
	$readmemb("datafile.txt", internal_mem);

	always @(posedge clk) begin
		if(~rst) begin
			for (i=0; i<128; i=i+1)
				internal_mem[i] <= 32'd0;
			end
		if (we) begin
				internal_mem[datamem_addr] <= datamem_data;
		end
	end
	assign readData = (re) ? internal_mem[datamem_addr]:32'd0;
endmodule
