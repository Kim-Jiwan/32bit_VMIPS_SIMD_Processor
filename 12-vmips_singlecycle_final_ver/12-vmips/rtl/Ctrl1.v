module Ctrl1(input [31:26] MSA_en,
			input [25:21] R_RF_Sep,
			input [5:0] opcode,
			output reg [3:0] format);
	always @(*) begin
		if(MSA_en==6'b011110) begin
			if(opcode[5:3]==3'b000)begin
				if(opcode[2:0]==3'b000 | opcode[2:0]==3'b001 | opcode[2:0]==3'b010) // I8
					format = 4'b0000;
				else if(opcode[2:0]==3'b110) // I5
					format = 4'b0001;
				else if(opcode[2:0]==3'b111) // I10
					format = 4'b0010;
			end
			if(opcode[5:3]==3'b001)begin
				if(opcode[2:0]==3'b001 | opcode[2:0]==3'b010) // BIT
					format = 4'b0011;
				else if(opcode[2:0]==3'b101 | opcode[2:0]==3'b110 | opcode[2:0]==3'b111) // 3R
					format = 4'b0100;
			end
			if(opcode[5:3]==3'b010)begin
				if(opcode[2:0]!=3'b110 | opcode[2:0]!=3'b111) // 3R
					format = 4'b0100;
			end // 3R은 경우가 많아서 케이스 두개로 나뉜다.
			if(opcode[5:3]==3'b011)begin
				if(opcode[2:0]==3'b001) // ELM
					format = 4'b0101;
				else if(opcode[2:0]==3'b010 | opcode[2:0]==3'b011 | opcode[2:0]==3'b100) // 3RF
					format = 4'b0110;
				else if(opcode[2:0]==3'b110) begin// VEC/2R/2RF
					if(R_RF_Sep==5'b11000) // 2R
						format = 4'b0111;
					else if(R_RF_Sep==5'b11001) // 2RF
						format = 4'b1000;
					else // VEC
						format = 4'b1001;
				end
			end
			if(opcode[5:3]==3'b100)begin // MI10
				format = 4'b1000;
			end
		end
		else if(MSA_en==6'b010001) // branch
			format = 4'b1011;
		else
			format =4'b0000;
  end
endmodule
