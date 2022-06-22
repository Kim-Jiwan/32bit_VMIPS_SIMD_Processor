module vmips_top(PC, clk, rst, nPC);
	input [31:0] PC;
	input clk, rst;
	output [31:0] nPC;

	wire [31:0]		pc_p1;
	wire [31:0]		inst;
	wire [4:0]		vreg_xa, vreg_xb, vreg_ya, vreg_yb, vreg_za, vreg_zb, vreg_wa, vreg_wb;
	wire [4:0]		wreg_x, wreg_y, wreg_z, wreg_w;
	wire [4:0]		nvreg_xb, nvreg_yb, nvreg_zb, nvreg_wb;
	wire [31:0]		rdat_xa, rdat_xb, rdat_ya, rdat_yb, rdat_za, rdat_zb, rdat_wa, rdat_wb;
	wire [31:0]		nrdat_xb, nrdat_yb, nrdat_zb, nrdat_wb;
	wire [31:0]		swdat_x, swdat_y, swdat_z,swdat_w;
	wire [31:0]		wdat_x, wdat_y, wdat_z, wdat_w;
	wire [31:0]		result_x, result_y, result_z, result_w;
	wire [31:0]		nresult_x;
	wire [31:0]		read_dat_x, read_dat_y, read_dat_z, read_dat_w;
  wire 					reg_write, memtoreg, mem_write, mem_read, enc_sig;
	wire [1:0]		alu_src;
	wire [2:0]	  alu_op;
	wire [4:0]    reg_dst, reg_s, reg_t, imme;
	wire [9:0]		imme_1;
	wire 					sig_i;





	//wire 					sig;
	//wire 					Jump, Branch;
	//wire 					zero;
	integer 			i;


	assign {vreg_xa, vreg_xb, wreg_x} = {inst[15:11], inst[20:16], inst[10:6]};
	assign {vreg_ya, vreg_yb, wreg_y} = {inst[15:11], inst[20:16], inst[10:6]};
	assign {vreg_za, vreg_zb, wreg_z} = {inst[15:11], inst[20:16], inst[10:6]};
	assign {vreg_wa, vreg_wb, wreg_w} = {inst[15:11], inst[20:16], inst[10:6]};


	assign enc_sig = (inst[5:2] == 4'b1001) ? 1'b1 : 1'b0;


	inst_mem				i0			(pc_p1, clk, rst, inst);

	add							add0		(pc_p1, 32'd1, nPC);

	pc							p0			(PC, clk, rst, pc_p1);

	decoder 				dec0  	(.inst(inst), .reg_dst(reg_dst), .reg_s(reg_s), .reg_t(reg_t),
													 .imme(imme), .reg_write(reg_write), .mem_read(mem_read),
													 .mem_write(mem_write), .memtoreg(memtoreg), .alu_op(alu_op),
													 .alu_src(alu_src), .imme_1(imme_1), .sig_i(sig_i));

	mux2            m0_x		(result_x, read_dat_x, memtoreg, swdat_x);
	mux2            m0_y		(result_y, read_dat_y, memtoreg, swdat_y);
	mux2            m0_z		(result_z, read_dat_z, memtoreg, swdat_z);
	mux2            m0_w		(result_w, read_dat_w, memtoreg, swdat_w);

	mux2						m1_x		( .i0({32'd0}), .i1(swdat_x), .sel(reg_write), .y(wdat_x));
	mux2						m1_y		( .i0({32'd0}), .i1(swdat_y), .sel(reg_write), .y(wdat_y));
	mux2						m1_z		( .i0({32'd0}), .i1(swdat_z), .sel(reg_write), .y(wdat_z));
	mux2						m1_w		( .i0({32'd0}), .i1(swdat_w), .sel(reg_write), .y(wdat_w));

	//regFile		d0 (reg_write[25:21], inst[20:16], wreg, wdat, clk, rst, reg_write, rdat1, rdat2);
	vreg_file_x			v_rf_x	(vreg_xa, nvreg_xb, wreg_x, wdat_x, clk, rst, reg_write, rdat_xa, rdat_xb);
	vreg_file_y			v_rf_y	(vreg_ya, nvreg_yb, wreg_y, wdat_y, clk, rst, reg_write, rdat_ya, rdat_yb);
	vreg_file_z			v_rf_z	(vreg_za, nvreg_zb, wreg_z, wdat_z, clk, rst, reg_write, rdat_za, rdat_zb);
	vreg_file_w			v_rf_w	(vreg_wa, nvreg_wb, wreg_w, wdat_w, clk, rst, reg_write, rdat_wa, rdat_wb);

	mux3						m2_x		( .i0(rdat_xb), .i1({27'd0, imme}), .i2({22'd0, imme_1}), .sel(alu_src), .y(nrdat_xb) );
	mux3						m2_y		( .i0(rdat_yb), .i1({27'd0, imme}), .i2({22'd0, imme_1}), .sel(alu_src), .y(nrdat_yb) );
	mux3						m2_z		( .i0(rdat_zb), .i1({27'd0, imme}), .i2({22'd0, imme_1}), .sel(alu_src), .y(nrdat_zb) );
	mux3						m2_w		( .i0(rdat_wb), .i1({27'd0, imme}), .i2({22'd0, imme_1}), .sel(alu_src), .y(nrdat_wb) );

	alu							alu_x		(rdat_xa, nrdat_xb, alu_op, result_x);
	alu							alu_y		(rdat_ya, nrdat_yb, alu_op, result_y);
	alu							alu_z		(rdat_za, nrdat_zb, alu_op, result_z);
	alu							alu_w		(rdat_wa, nrdat_wb, alu_op, result_w);

/*
		wdat_x = result_x;
		wdat_y = result_y;
		wdat_z = result_z;
		wdat_w = result_w;
*/

	mux2							m3			(result_x, {22'd0, imme_1}, sig_i, nresult_x);

	data_mem_1				dx	  	(nresult_x, 				rdat_xb, clk, rst, mem_write, mem_read, read_dat_x);
	data_mem_1				dy	  	({nresult_x+32'd1}, rdat_yb, clk, rst, mem_write, mem_read, read_dat_y);
	data_mem_1				dz	  	({nresult_x+32'd2}, rdat_zb, clk, rst, mem_write, mem_read, read_dat_z);
	data_mem_1				dw	  	({nresult_x+32'd3}, rdat_wb, clk, rst, mem_write, mem_read, read_dat_w);

	mux2_5b						m4_x		( .i0(vreg_xb), .i1(wreg_x), .sel(mem_write), .y(nvreg_xb));
	mux2_5b						m4_y		( .i0(vreg_yb), .i1(wreg_y), .sel(mem_write), .y(nvreg_yb));
	mux2_5b						m4_z		( .i0(vreg_zb), .i1(wreg_z), .sel(mem_write), .y(nvreg_zb));
	mux2_5b						m4_w		( .i0(vreg_wb), .i1(wreg_w), .sel(mem_write), .y(nvreg_wb));


endmodule
