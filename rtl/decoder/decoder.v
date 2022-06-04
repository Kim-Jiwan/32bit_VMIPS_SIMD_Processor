module decoder(input [31:0] inst,
			output reg [4:0] reg_dst, reg_s, reg_t, imme,
			output reg reg_write, mem_read, mem_write, memtoreg,
			output reg [2:0] alu_op,
			output reg [1:0] alu_src,
			output reg [9:0] imme_1);
			
wire [3:0] format;
			
Ctrl1 u1 (inst[31:26],inst[25:21],inst[5:0],format)
Ctrl2 u2 (format,inst[25:0], reg_dst, reg_s, reg_t, imme, reg_write, mem_read, mem_write, memtoreg, alu_op,alu_src, imme_1);

endmodule