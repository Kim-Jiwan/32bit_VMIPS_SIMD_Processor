module decoder_tb();

    reg     [31:0]      inst;
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

endmodule
