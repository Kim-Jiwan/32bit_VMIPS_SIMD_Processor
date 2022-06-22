module Ctrl2(input [3:0] format,
			input [25:0] inst,
			output reg [4:0] reg_dst, reg_s, reg_t, imme,
			output reg reg_write, mem_read, mem_write, memtoreg,
			output reg [2:0] alu_op,
			output reg [1:0] alu_src,
			output reg [9:0] imme_1,
			output reg sigi);

	always @(*) begin
		case(format)
			4'b0001: begin // I5
				if(inst[25:23]==3'b000 & inst[5:0]==6'b000110) begin	//addvi
					reg_dst<=inst[10:6];
					reg_s<=inst[15:11];
					reg_t<=5'b00000;
					reg_write<=1'b1;
					mem_read<=1'b0;
					mem_write<=1'b0;
					alu_op<=3'b000;
					alu_src<=2'b01;
					memtoreg<=1'b0;
					imme<=inst[20:16];
					imme_1 <= 10'b0000000000;
					sigi <= 1'b0;
				end
				else if(inst[25:23]==3'b001 & inst[5:0]==6'b000110) begin	//subvi
					reg_dst<=inst[10:6];
					reg_s<=inst[15:11];
					reg_t<=5'b00000;
					reg_write<=1'b1;
					mem_read<=1'b0;
					mem_write<=1'b0;
					alu_op<=3'b001;
					alu_src<=2'b01;
					memtoreg<=1'b0;
					imme<=inst[20:16];
					imme_1 <= 10'b0000000000;
					sigi <= 1'b0;
				end
			end

			4'b1000: begin // MI10
				if(inst[5:2] == 4'b1000) begin // LD
					reg_dst <= inst[10:6];
					reg_s <= inst[15:11];
					reg_t <= 5'b0;
					imme_1 <= inst[25:16];
					imme<=5'b00000;
					reg_write <= 1'b1;
					mem_read <= 1'b1;
					mem_write <= 1'b0;
					alu_op <= 3'b0;
					alu_src <= 2'b10;
					memtoreg <= 1'b1;
					sigi <= 1'b0;
				end

				if(inst[5:2] == 4'b1001) begin // ST
					reg_dst <= 5'b0;
					reg_s <= inst[15:11];
					reg_t <= inst[10:6];
					imme_1 <= inst[25:16];
					imme<=5'b00000;
					reg_write <= 1'b0;
					mem_read <= 1'b0;
					mem_write <= 1'b1;
					alu_op <= 3'b0;
					alu_src <= 2'b10;
					memtoreg <= 1'b0;
					sigi <= 1'b0;
				end
			end

			4'b0010 : begin // I10
				if(inst[25:23] == 3'b110) begin // LDI
					reg_dst <= inst[10:6];
					reg_s <= 5'b0;
					reg_t <= 5'b0;
					imme_1 <= inst[20:11];
					imme<=5'b00000;
					reg_write <= 1'b1;
					mem_read <= 1'b0;
					mem_write <= 1'b0;
					alu_op <= 3'b0;
					alu_src <= 2'b10;
					memtoreg <= 1'b0;
					sigi <= 1'b1;
				end
			end

			4'b0100: begin //3R
				if(inst[25:23]==3'b000 & inst[5:0]==6'b001110) begin	//addv
					reg_dst<=inst[10:6];
					reg_s<=inst[15:11];
					reg_t<=inst[20:16];
					reg_write<=1'b1;
					mem_read<=1'b0;
					mem_write<=1'b0;
					alu_op<=3'b000;
					alu_src<=2'b00;
					memtoreg<=1'b0;
					imme<=5'b00000;
					imme_1 <= 10'b0000000000;
					sigi <= 1'b0;
				end
				else if(inst[25:23]==3'b001 & inst[5:0]==6'b001110) begin	//subv
					reg_dst<=inst[10:6];
					reg_s<=inst[15:11];
					reg_t<=5'b00000;
					reg_write<=1'b1;
					mem_read<=1'b0;
					mem_write<=1'b0;
					alu_op<=3'b001;
					alu_src<=2'b00;
					memtoreg<=1'b0;
					imme<=5'b00000;
					imme_1 <= 10'b0000000000;
					sigi <= 1'b0;
				end
			end
			default: begin
				reg_dst<=inst[10:6];
				reg_s<=inst[15:11];
				reg_t<=5'b00000;
				reg_write<=1'b0;
				mem_read<=1'b0;
				mem_write<=1'b0;
				alu_op<=3'b000;
				alu_src<=2'b00;
				memtoreg<=1'b0;
				imme<=5'b00000;
				imme_1 <= 10'b0000000000;
				sigi <= 1'b0;
			end

		endcase
  end

endmodule
