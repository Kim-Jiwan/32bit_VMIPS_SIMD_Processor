module data_mem(datamem_addr, datamem_data, clk, rst, we, re, readData);
	input [127:0] datamem_addr, datamem_data;
	input clk, rst, we, re;
	output [127:0] readData;

	integer i;
	reg [127:0] internal_mem [0:128];

	initial #10
	$readmemb("datafile.txt", internal_mem);

	always @(posedge clk) begin
		if(~rst) begin
			for (i=0; i<129; i=i+1)
				internal_mem[i] <= 128'd0;
			end
		if (we) begin
				internal_mem[datamem_addr] <= datamem_data;
		end
	end
	assign readData = (re) ? internal_mem[datamem_addr]:128'd0;
endmodule
