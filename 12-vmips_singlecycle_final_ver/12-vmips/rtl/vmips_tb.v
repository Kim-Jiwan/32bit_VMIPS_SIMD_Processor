module vmips_tb();
		reg clk, rst;
		reg [31:0] PC;
		wire [31:0] sPC;
		wire [31:0] inst;

		vmips_top				u0		(PC, clk, rst, sPC);

		initial begin
			//i		= 0;
			clk = 0;
			rst = 0;
			PC	= 32'd0;
			#10
			 	rst = ~rst;

				//clk = ~clk;

			#300
			  $finish;
		end

		always begin
			#5
			  clk = ~clk;
		end

		always begin
				#10
				if(vmips_top.inst!=32'd0) begin
				//if((mips_top.current_instr!==32'hxxxxxxxx)||(PC==0)) begin
				//if(i<60) begin
				//i = i + 1;
				//if(PC <= 13'd24) begin
					$timeformat(-12, 0," ps");
					//$display("ID:1816, at time%t, PC=%d, RF[0, 1, 2, 3, 4, 7] is:%d,%d,%d,%d,%d,%d", $time, PC, r0, r1, r2, r3, r4, r7);
					$display("HF_GPGPU : at time%t, PC=%d", $time, PC);
					$display("Vector1[x, y, z, w] is:%d,%d,%d,%d", vreg_file_x.reg_array[1], vreg_file_y.reg_array[1], vreg_file_z.reg_array[1], vreg_file_w.reg_array[1]);
					$display("Vector2[x, y, z, w] is:%d,%d,%d,%d", vreg_file_x.reg_array[2], vreg_file_y.reg_array[2], vreg_file_z.reg_array[2], vreg_file_w.reg_array[2]);
					$display("Vector3[x, y, z, w] is:%d,%d,%d,%d", vreg_file_x.reg_array[3], vreg_file_y.reg_array[3], vreg_file_z.reg_array[3], vreg_file_w.reg_array[3]);
					$display("Vector4[x, y, z, w] is:%d,%d,%d,%d", vreg_file_x.reg_array[4], vreg_file_y.reg_array[4], vreg_file_z.reg_array[4], vreg_file_w.reg_array[4]);
					$display("Vector5[x, y, z, w] is:%d,%d,%d,%d", vreg_file_x.reg_array[5], vreg_file_y.reg_array[5], vreg_file_z.reg_array[5], vreg_file_w.reg_array[5]);
					$display("Vector6[x, y, z, w] is:%d,%d,%d,%d", vreg_file_x.reg_array[6], vreg_file_y.reg_array[6], vreg_file_z.reg_array[6], vreg_file_w.reg_array[6]);



					//$display("Vector2[x, y, z, w] is:%d,%d,%d,%d",
										//vreg_file_x.reg_array[1], vreg_file_y.reg_array[1], vreg_file_z.reg_array[1], vreg_file_w.reg_array[1]);
					//$display("Vector3[x, y, z, w] is:%d,%d,%d,%d",
										//vreg_file_x.reg_array[2], vreg_file_y.reg_array[2], vreg_file_z.reg_array[2], vreg_file_w.reg_array[2]);
				end
				else begin
			  	$timeformat(-12, 0," ps");
					$display("HF_GPGPU : at time%t, PC=%d", $time, PC);
					$display("Vector1[x, y, z, w] is:[%d,%d,%d,%d]", vreg_file_x.reg_array[1], vreg_file_y.reg_array[1], vreg_file_z.reg_array[1], vreg_file_w.reg_array[1]);
					$display("Vector2[x, y, z, w] is:[%d,%d,%d,%d]", vreg_file_x.reg_array[2], vreg_file_y.reg_array[2], vreg_file_z.reg_array[2], vreg_file_w.reg_array[2]);
					$display("Vector3[x, y, z, w] is:[%d,%d,%d,%d]", vreg_file_x.reg_array[3], vreg_file_y.reg_array[3], vreg_file_z.reg_array[3], vreg_file_w.reg_array[3]);
					$display("Vector4[x, y, z, w] is:[%d,%d,%d,%d]", vreg_file_x.reg_array[4], vreg_file_y.reg_array[4], vreg_file_z.reg_array[4], vreg_file_w.reg_array[4]);
					$display("Vector5[x, y, z, w] is:[%d,%d,%d,%d]", vreg_file_x.reg_array[5], vreg_file_y.reg_array[5], vreg_file_z.reg_array[5], vreg_file_w.reg_array[5]);
					$display("Vector6[x, y, z, w] is:[%d,%d,%d,%d]", vreg_file_x.reg_array[6], vreg_file_y.reg_array[6], vreg_file_z.reg_array[6], vreg_file_w.reg_array[6]);
					#10
					`ifndef COMP_SELECT_MODULES
					$display("The final result of B in vector memory is:[%d, %d, %d, %d]", vmips_tb.u0.dx.internal_mem[4],vmips_tb.u0.dy.internal_mem[5],vmips_tb.u0.dz.internal_mem[6],vmips_tb.u0.dw.internal_mem[7]);
					`else
					`endif
					$finish;
				end
		end

		always begin
		    #10
				PC = sPC;
		end





		/*
    // tmp memory for verification
    reg     [31:0]      tmp_mem    [7:0];

    wire    [4:0]       reg_dst, reg_s, reg_t, imme;
		wire				reg_write, mem_read, mem_write, memtoreg;
    wire    [2:0]       alu_op;
    wire    [1:0]       alu_src;
    wire    [9:0]       imme_1;

    integer i;

    decoder u0  (   .inst       (inst),

                    .reg_dst    (reg_dst),
                    .reg_s      (reg_s),
                    .reg_t      (reg_t),
                    .imme       (imme),

					.reg_write	(reg_write),
					.mem_read	(mem_read),
					.mem_write	(mem_write),
					.memtoreg	(memtoreg),

                    .alu_op     (alu_op),
                    .alu_src    (alu_src),
                    .imme_1     (imme_1)    );

    initial begin
        $display("Loading mem....");
        $readmemb("instruction_file.txt", tmp_mem);
    end

    always #1 begin
        if (i < 8) begin
            inst = tmp_mem[i];
            i = i + 1;
			$display("current instruction is %b", inst);
			$display("reg_dst = %b, reg_s = %b, reg_t = %b, imme = %d",
					  reg_dst,		reg_s, 		reg_t, 		imme		);
			$display("reg_write = %b, mem_read = %b, mem_write = %b, memtoreg = %b",
					  reg_write,	  mem_read, 	 mem_write, 	 memtoreg		);
			$display("alu_op = %b, alu_src = %b, imme_1 = %d",
					  alu_op,	   alu_src,	     imme_1);
        end

		else begin
			$display("instruction test is done.");
			$finish;
		end
    end
		*/
endmodule
