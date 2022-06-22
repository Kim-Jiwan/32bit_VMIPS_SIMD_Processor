module vreg_file_z(read_reg1, read_reg2, write_reg, write_data, clk, rst, reg_write,
				  reg_read_data1, reg_read_data2);
	input 	[4:0]		read_reg1, read_reg2, write_reg;
	input 	[31:0]	write_data;
	input 					clk, rst, reg_write;
	output  [31:0] 	reg_read_data1, reg_read_data2;

	reg [31:0] reg_array[31:0];

	always @(posedge clk) begin
		if(~rst) begin
			reg_array[0] <= 32'b0;
			reg_array[1] <= 32'b0;
			reg_array[2] <= 32'b0;
			reg_array[3] <= 32'b0;
			reg_array[4] <= 32'b0;
			reg_array[5] <= 32'b0;
			reg_array[6] <= 32'b0;
			reg_array[7] <= 32'b0;
			reg_array[8] <= 32'b0;
			reg_array[9] <= 32'b0;
			reg_array[10] <= 32'b0;
			reg_array[11] <= 32'b0;
			reg_array[12] <= 32'b0;
			reg_array[13] <= 32'b0;
			reg_array[14] <= 32'b0;
			reg_array[15] <= 32'b0;
			reg_array[16] <= 32'b0;
			reg_array[17] <= 32'b0;
			reg_array[18] <= 32'b0;
			reg_array[19] <= 32'b0;
			reg_array[20] <= 32'b0;
			reg_array[21] <= 32'b0;
			reg_array[22] <= 32'b0;
			reg_array[23] <= 32'b0;
			reg_array[24] <= 32'b0;
			reg_array[25] <= 32'b0;
			reg_array[26] <= 32'b0;
			reg_array[27] <= 32'b0;
			reg_array[28] <= 32'b0;
			reg_array[29] <= 32'b0;
			reg_array[30] <= 32'b0;
			reg_array[31] <= 32'b0;
		end
		else begin
			if(reg_write) begin
				reg_array[write_reg] <= write_data;
			end
		end
	end

	assign reg_read_data1 = (read_reg1 == 0) ? 32'b0 : reg_array[read_reg1];
	assign reg_read_data2 = (read_reg2 == 0) ? 32'b0 : reg_array[read_reg2];
endmodule
